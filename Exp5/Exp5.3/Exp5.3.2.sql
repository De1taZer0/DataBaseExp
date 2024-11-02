/*
 本关任务：
 针对 SPJ_MNG 数据库，创建带输入参数的存储过程—jsearch2。
 该存储过程的作用是：当输入一个供应商所在城市名时（如北京），将返回该供应商的所有信息。
 */

drop procedure if exists jsearch2;
delimiter //
create procedure jsearch2(in city_name varchar(10))
begin
    select * from s where CITY = city_name;
end//
delimiter ;

call jsearch2('北京');