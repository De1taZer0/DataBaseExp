/*
 本关任务：
 创建一个视图( card_customer )，包含拥有银行卡的所有客户编号，姓名, 身份证号, 拥有的银行卡个数。
 */

drop view if exists card_customer;
create view card_customer as
select c_id, c_name, c_id_card, count(b_number) as card_num
from customer, bank_card
where c_id = b_c_id
group by c_id
order by c_id;
