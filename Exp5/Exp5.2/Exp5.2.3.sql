/*
 本关任务：为 Student 表创建一个名为 dele_s2 的 DELETE 触发器，
 该触发器的作用是删除 Student 表中的记录时删除 SC 表中该学生的选课纪录。
 */

drop trigger if exists dele_s2;
delimiter //
create trigger dele_s2 before delete on Student
for each row
begin
    delete from SC where SNO = old.SNO;
end;
//
delimiter ;