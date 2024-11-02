/*
本关任务：该公司计划为员工按照一定的规则涨工资，请使用游标创建一个存储过程 update_salary ，执行该存储过程完成本次工资调整。工资增长规则如下：
工资在3000元以下，每月涨300元；
工资在3000-4000元之间，每月涨200元；
工资大于或者等于4000元，每月涨50元；
 */

drop procedure if exists update_salary;
delimiter //
create procedure update_salary()
begin
    declare curr_id int;
    declare curr_salary int;
    declare done int default 0;
    declare cur cursor for select eID, salary from employee;
    declare continue handler for not found set done = 1;
    open cur;
    repeat
        fetch cur into curr_id, curr_salary;
        if not done then
            if curr_salary < 3000 then
                update employee set salary = curr_salary + 300 where eID = curr_id;
            elseif curr_salary >= 3000 and curr_salary < 4000 then
                update employee set salary = curr_salary + 200 where eID = curr_id;
            else
                update employee set salary = curr_salary + 50 where eID = curr_id;
            end if;
        end if;
    until done end repeat;
    close cur;
end;
//
delimiter ;

call update_salary();
select * from employee;