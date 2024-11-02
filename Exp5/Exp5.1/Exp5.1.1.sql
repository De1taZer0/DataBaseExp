
/*
 本关任务：为了协助本题自动生成1000条员工数据，创建一个自动生成员工 ID 的用户自定义函数 generateEID(num int, year int) 。
其中员工 ID 要求是一个8位的数字，前四位表示插入员工数据的当前年份，后四位按照从0001到9999的顺序增长。例如2023年插入的第一条数据是20230001，所有1000条员工 ID 分别是20230001-20231000，每个员工的工资初值是（2000 + ID%10*300）。
调用该函数generateEID(1000,2023)实现自动插入2023年的1000条员工数据。注意插入数据的时候员工姓名为c+员工ID（如：c20230028)，工资是（2000+8*300）。
 */
drop table if exists employee;
create table employee(
    eID int,
    eName varchar(20),
    salary int
);

drop procedure if exists generateEID;
delimiter //
create procedure generateEID(num int, year int)
begin
    declare i int default 1;
    declare eID int;
    while i <= num do
        set eID = year * 10000 + i;
        insert into employee values(eID, concat('c', eID), 2000 + eID % 10 * 300);
        set i = i + 1;
    end while;
end;
//
delimiter ;

call generateEID(1000, 2023);
select * from employee;