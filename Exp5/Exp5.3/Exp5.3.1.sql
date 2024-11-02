/*
 本关任务：
 针对 SPJ_MNG 数据库，创建一个没有参数的存储过程—jsearch1。
 该存储过程的作用是：当执行该存储过程时，将返回 S 表中北京供应商的所有信息。
 */

drop procedure if exists jsearch1;
delimiter //
create procedure jsearch1()
begin
    select * from s where CITY = '北京';
end//
delimiter ;

call jsearch1();