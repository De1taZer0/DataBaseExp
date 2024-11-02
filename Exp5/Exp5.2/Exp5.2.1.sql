/*
 本关任务：针对 SC 表创建一个名为 insert_s 的 INSERT 触发器。
该触发器的功能：当用户向 SC 表中插入记录时，如果插入的 cno 值不是 Course 表中 Cno 的已有值，则提示用户“不能插入 Course 表中没有的数据”，并阻止该数据的插入,SQL 状态码为31000；如果插入的 sno 值不是 Student 表中的 sno 的已有值，则提示用户“不能插入 Student 表中没有的数据”，并阻止该数据的插入，SQL 状态码为32000。
 */
drop trigger if exists insert_s;
delimiter //
create trigger insert_s before insert on SC
for each row
begin
    declare cno_count int;
    declare sno_count int;
    select count(*) into cno_count from Course where CNO = new.CNO;
    select count(*) into sno_count from Student where SNO = new.SNO;
    if cno_count = 0 then
        signal sqlstate '31000' set message_text = '不能插入Course表中没有的数据';
    end if;
    if sno_count = 0 then
        signal sqlstate '32000' set message_text = '不能插入Student表中没有的数据';
    end if;
end;
//
delimiter ;
