/*
 本关任务：
 在上一关原有视图( card_customer )的基础上，修改该视图，使其仅包含拥有信用卡的所有客户编号，姓名，身份证号，拥有的信用卡个数。
 */

alter view card_customer as
select c_id, c_name, c_id_card, count(b_number) as card_num
from customer, bank_card
where c_id = b_c_id and b_type = '信用卡'
group by c_id
order by c_id;