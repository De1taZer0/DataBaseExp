#删除供应商表中S2的记录,并从供应情况表中删除相应记录
DELETE FROM spj
WHERE SNO = 'S2';

DELETE FROM s
WHERE SNO = 'S2';