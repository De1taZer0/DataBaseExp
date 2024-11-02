/*
 本关任务：给 Student 表设计before update 触发器和 after update 触发器，比较 before 和 after 触发器的区别（在实验报告中给出 before 和 after 触发器创建与验证的截图，并描述对比差异的分析说明）。
 */

drop trigger if exists before_update_Student;
drop trigger if exists after_update_Student;
delimiter //
create trigger before_update_Student before update on Student
for each row
begin
end;
//
create trigger after_update_Student after update on Student
for each row
begin
end;
//
delimiter ;
