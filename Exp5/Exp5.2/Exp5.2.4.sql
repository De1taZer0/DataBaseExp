/*
 本关任务：为 Student 表创建一个名为 update_s 的 UPDATE 触发器，SQL 状态码为03100，
 该触发器的作用是禁止更新 Student 表中 “SDEP” 字段的内容（更新不成功，并且提示“不能更新SDEP字段”）。
 */

drop trigger if exists update_s;
delimiter //
create trigger update_s before update on Student
for each row
begin
    if old.SDEP != new.SDEP then
        signal sqlstate '03100' set message_text = '不能更新SDEP字段';
    end if;
end;
//
delimiter ;
