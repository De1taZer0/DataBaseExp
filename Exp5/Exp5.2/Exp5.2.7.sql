/*
 本关任务：创建一个新的课程成绩统计表 CAvgGrade ( Cno, Snum, examSNum, avgGrade )，分别表示课号，选该课程的学生人数，参加考试人数，该门课程的平均成绩。
 */
/*
 利用触发器实现如下的功能：
 当 SC 表中插入、删除或者更新某个人的成绩时，自动更新表 CAvgGrade 。
 注意 SC 表中的 grade 为 NULL 时表明该学生还未参加考试，计算平均成绩时不需要计算该成绩，但是 grade 为0即考试成绩为0时，计算平均成绩需要计算该学生成绩。
 */
drop table if exists CAvgGrade;
create table CAvgGrade(
    Cno char(2), # 课号
    Snum int, # 选该课程的学生人数
    examSNum int, # 参加考试人数
    avgGrade int # 该门课程的平均成绩
);
drop trigger if exists insert_CAvgGrade;
drop trigger if exists delete_CAvgGrade;
drop trigger if exists update_CAvgGrade;
drop procedure if exists initCAvgGrade;
drop procedure if exists updAvgGrade;
delimiter //
create procedure initCAvgGrade()
begin
    declare n_cno char(2);
    declare done int default 0;
    declare n_snum int;
    declare n_examSNum int;
    declare n_avgGrade int;
    declare cno_cursor cursor for select CNO from Course;
    declare continue handler for not found set done = 1;
    open cno_cursor;
    repeat
        fetch cno_cursor into n_cno;
        if not done then
            select count(*) into n_snum from SC where CNO = n_cno;
            select count(*) into n_examSNum from SC where CNO = n_cno and GRADE is not null;
            select avg(GRADE) into n_avgGrade from SC where CNO = n_cno and GRADE is not null;
            if n_snum != 0 then
                insert into CAvgGrade values(n_cno, n_snum, n_examSNum, n_avgGrade);
            end if;
        end if;
    until done end repeat;
    close cno_cursor;
end;
create procedure updAvgGrade(in n_cno char(2))
begin
    declare n_snum int;
    declare n_examSNum int;
    declare n_avgGrade int;
    select count(*) into n_snum from SC where CNO = n_cno;
    select count(*) into n_examSNum from SC where CNO = n_cno and GRADE is not null;
    select avg(GRADE) into n_avgGrade from SC where CNO = n_cno and GRADE is not null;
    update CAvgGrade set Snum = n_snum, examSNum = n_examSNum, avgGrade = n_avgGrade where Cno = n_cno;
    if ROW_COUNT() = 0 then
        insert into CAvgGrade values(n_cno, n_snum, n_examSNum, n_avgGrade);
    end if;
end;
//
create trigger insert_CAvgGrade after insert on SC
for each row
begin
    call updAvgGrade(new.CNO);
end;
//
create trigger delete_CAvgGrade after delete on SC
for each row
begin
    call updAvgGrade(old.CNO);
end;
//
create trigger update_CAvgGrade after update on SC
for each row
begin
    call updAvgGrade(new.CNO);
end;
//
delimiter ;

call initCAvgGrade();