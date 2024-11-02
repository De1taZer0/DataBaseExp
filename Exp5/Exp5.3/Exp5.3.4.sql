/*
 本关任务：
 针对 SPJ_MNG 数据库，创建一个使用游标的存储过程 jsearch4 ，
 创建成功后调用该存储过程并验证结果。
 该存储过程的功能：当输入一个工程号 JNO 时，将返回供应该工程零件的所有供应商的名称( SNAME )，这些供应商名拼接成一个字符串，并用逗号’,’分隔。
    例如： 输入：J2，输出： '精益, 盛锡, 为民'。
 */

drop procedure if exists jsearch4;
delimiter //
create procedure jsearch4(in i_jno varchar(5))
begin
    declare done int default 0;
    declare i_sno varchar(5);
    declare i_name varchar(20);
    declare name varchar(40);
    declare cur cursor for select SNAME from s where SNO in (select SNO from spj where JNO = i_jno);
    declare continue handler for not found set done = 1;
    set name = '';
    open cur;
    repeat
        fetch cur into i_name;
        if not done then
            if name = '' then
                set name = i_name;
            else
                set name = concat(name, ', ',i_name);
            end if;
        end if;
    until done end repeat;
    close cur;
    select name, length(name);
end//
delimiter ;
