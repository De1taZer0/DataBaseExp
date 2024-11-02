/*
 本关任务：
 针对 SPJ_MNG 数据库，创建带输入参数和输出参数的存储过程(函数)—jsearch3。
 该存储过程的作用是：当输入一个供应商编号(输入参数 SNO )时，将返回该供应商的名称(输出参数 SNAME )。调用存储过程并验证结果。
 */

drop procedure if exists jsearch3;
delimiter //
create procedure jsearch3(in i_sno varchar(5), out name varchar(20))
begin
    select SNAME into name from s where SNO = i_sno;
end//
delimiter ;

call jsearch3('S1', @name);
select @name;