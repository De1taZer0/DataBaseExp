/*
 本关任务：为 Student 表创建一个名为 dele_s1 的 DELETE 触发器，
 该触发器的作用是提示用户“不能删除该表中的数据”并阻止用户删除 S 表中的数据，SQL 状态码为03000。
 */

drop trigger if exists dele_s1;
delimiter //
create trigger dele_s1 before delete on Student
for each row
begin
    signal sqlstate '03000' set message_text = '不能删除该表中的数据';
end;
//
delimiter ;