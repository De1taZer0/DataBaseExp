/*
 本关任务：模拟以下的业务写出 SQL 语句进行查询。
 1.查询银行所有银行卡的卡号和类型信息。
 2.查询银行拥有的客户数量。
 3.查询拥银行卡的所有客户编号，姓名和身份证号。
 4.统计所有的银行卡中，储蓄卡和信用卡的各自数量。
 5.查询保险表中，保险价格的平均值。
 6.查询保险表中保险价格的最大值和最小值所对应的险种和价格。
 7.某人捡到一张卡，希望查询该银行卡号是'6222021302020000006'的客户编号，姓名和联系电话。
 8.查询保险产品中保险价格大于平均值的保险名称和适用人群。
 9.查询 C 银行发布的理财产品总数，按照 p_year 分组。
 10.查询适用于老人的保险编号，保险名称，保险年限。
 */

# 1.查询银行所有银行卡的卡号和类型信息。
select b_number, b_type
from bank_card;

# 2.查询银行拥有的客户数量。
select count(distinct(b_c_id))
from bank_card;

# 3.查询拥银行卡的所有客户编号，姓名和身份证号。
select b_c_id, c_name, c_id_card
from customer, bank_card
where c_id = b_c_id
group by b_c_id
order by b_c_id;

# 4.统计所有的银行卡中，储蓄卡和信用卡的各自数量。
select b_type, count(b_number)
from bank_card
group by b_type;

# 5.查询保险表中，保险价格的平均值。
select avg(i_price)
from insurance;

# 6.查询保险表中保险价格的最大值和最小值所对应的险种和价格。
select i_name, i_price
from insurance
where i_price = (select max(i_price) from insurance)
   or i_price = (select min(i_price) from insurance)
order by i_price desc;

# 7.某人捡到一张卡，希望查询该银行卡号是'6222021302020000006'的客户编号，姓名和联系电话。
select c_id, c_name, c_phone
from customer
where c_id = (select b_c_id
              from bank_card
              where b_number = '6222021302020000006');

# 8.查询保险产品中保险价格大于平均值的保险名称和适用人群。
select i_name, i_price, i_person
from insurance
where i_price > (select avg(i_price)
                 from insurance);

# 9.查询 C 银行发布的理财产品总数，按照 p_year 分组。
select p_year, count(*)
from finances_product
group by p_year;

# 10.查询适用于老人的保险编号，保险名称，保险年限。
select i_id, i_name, i_price, i_year
from insurance
where i_person = '老人';