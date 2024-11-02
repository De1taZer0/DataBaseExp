/*
 本关任务：模拟一次理财产品的购买全周期，使用SQL或者存储过程完成数据的增删改查。
 ①客户编号为2的客户，申请更新自己的手机号码为'13312345678'。
 ②模拟4号理财产品的发售，购买，结算，停止产品的简化过程:
     第一步： 银行发售新的理财产品。
     2022/12/1日，银行发售1年期的理财产品，编号为4，开始封闭时间2023/1/6，价格为8.0元，状态为0(0表示正常）。
     提示：需要给 finances_product 表插入合适的记录。

     第二步： 客户购买4号理财产品（购买并从对应的银行卡扣钱）。
     假设有四笔交易：
     a.2023/1/5 13:00:00： 客户3用银行卡'6222021302020000016'购买了1000份4号理财产品：
     b.2023/1/5 13:00:00： 客户3用银行卡'6222021302020000002'购买了1000份4号理财产品：
     c.2023/1/5 14:00:00： 客户5用银行卡'6222021302020000003'购买了1000份4号理财产品：
     d.2023/1/5 15:00:00： 客户5用银行卡'6222021302020000003'又购买了500份4号理财产品
     提示：需要给 c_finances 表插入合适的购买记录，并且根据购买数量，单价计算购买总金额，并从购买的银行卡中扣除响应的金额（更新 bank_card 表的金额）。注意考虑储蓄卡余额不足的情况，可能会导致购买失败。整体会涉及多张表，用存储过程buy_fp封装整个处理过程。此外，更新银行卡的余额，如果是储蓄卡余额不足时应该更新失败，信用卡则可以透支（即信用卡金额可为负数）。

     第三步： 银行进行收益兑现。
     假设2024/1/6日该理财产品到期，假设收益为5%。2024/1/6日，银行给所有购买4号理财产品的用户进行收益兑现：计算所有购买客户的收益，将其本金+收益的总金额累计增加到购买该产品的银行卡余额中。
     提示：根据指定的收益率，计算每笔4号理财产品的购买交易到期后的余额（收益金额+本金）。然后将该交易的余额累加到该交易的支付银行卡的余额中。用存储过程pay_income封装整个处理过程。

     第四步： 银行停止4号理财产品
     假设银行已经处理完了4号理财产品的收益兑现。现在银行要下架该理财产品。注意删除该理财产品记录时，需考虑外键约束。
     提示：删除数据时尽量考虑备份，例如将4号理财产品的历史购买记录数据保存到一张单独的历史表（ c_finances_old ）中，然后再从 c_finances 表中删除4号理财产品的相关数据。从 finances_product 表中删除4号理财产品时，需要考虑外键约束，先删除4号产品的购买记录。历史表 c_finances_old 的结构与 c_finances 表相同，用于记录已删除的理财产品的用户历史购买记录。
*/

-- ①客户编号为2的客户，申请更新自己的手机号码为'13312345678'。
update customer
set c_phone = '13312345678'
where c_id = 2;

-- ②模拟4号理财产品的发售，购买，结算，停止产品的简化过程:
-- 第一步： 银行发售新的理财产品。
insert into finances_product(p_id, p_name, p_description, p_sale_start_date, p_excu_start_date, p_price, p_year, p_status)
values(4, 'aaaa', 'bbbb', '2022-12-1', '2023-1-6', 8.0, 1, 0);

-- 第二步： 客户购买4号理财产品（购买并从对应的银行卡扣钱）。
drop procedure if exists buy_fp;
delimiter //
create procedure buy_fp(in buy_time datetime, in customer_id int, in card_number char(30), in product_id int, in amount int)
begin
    declare price float;
    declare balance float;
    declare card_type char(30);
    declare purchase float;
    declare card_id int;
    select p_price into price from finances_product where p_id = product_id;
    select b_balance, b_type, b_c_id into balance, card_type, card_id from bank_card where b_number = card_number;
    set purchase = price * amount;
    if card_type != '储蓄卡' or balance >= purchase then
        update bank_card set b_balance = balance - purchase where b_number = card_number;
        insert into c_finances(c_id, p_id, p_time, p_quantity, p_purchase_money, p_income, p_total, b_number)
        values(customer_id, product_id, buy_time, amount, purchase,0, purchase, card_number);
    end if;
end //
delimiter ;
-- a.2023/1/5 13:00:00： 客户3用银行卡'6222021302020000016'购买了1000份4号理财产品：
call buy_fp('2023/1/15 13:00:00',3, '6222021302020000016', 4, 1000);
-- b.2023/1/5 13:00:00： 客户3用银行卡'6222021302020000002'购买了1000份4号理财产品：
call buy_fp('2023/1/15 13:00:00',3, '6222021302020000002', 4, 1000);
-- c.2023/1/5 14:00:00： 客户5用银行卡'6222021302020000003'购买了1000份4号理财产品：
call buy_fp('2023/1/15 14:00:00',5, '6222021302020000003', 4, 1000);
-- d.2023/1/5 15:00:00： 客户5用银行卡'6222021302020000003'又购买了500份4号理财产品
call buy_fp('2023/1/15 15:00:00',5, '6222021302020000003', 4, 500);

-- 第三步： 银行进行收益兑现。
drop procedure if exists pay_income;
delimiter //
create procedure pay_income(in product_id int, in rate float, in pay_time date)
begin
    declare total_income float;
    declare total_price float;
    declare customer_id int;
    declare purchase_time datetime;
    declare total float;
    declare card_number char(30);
    declare done int default 0;
    declare cur cursor for select c_id, p_time, p_total, b_number from c_finances where p_id = product_id;
    declare continue handler for not found set done = 1;
    open cur;
    repeat
        fetch cur into customer_id, purchase_time, total, card_number;
        if not done then
            set total_income = total * rate;
            set total_price = total + total_income;
            update bank_card set b_balance = b_balance + total_price where b_number = card_number;
            update c_finances set p_income = total_income, p_total = total_price where c_id = customer_id and p_time = purchase_time;
        end if;
    until done end repeat;
end //
delimiter ;
call pay_income(4, 0.05, '2024/1/6');

-- 第四步： 银行停止4号理财产品
drop table if exists c_finances_old;
create table c_finances_old like c_finances;
insert into c_finances_old
select * from c_finances where p_id = 4;
delete from c_finances where p_id = 4;
delete from finances_product where p_id = 4;
