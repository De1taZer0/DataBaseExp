#使用三种不同的方法查询选修了课程名为“数据库”的学生学号和姓名
#方法一
EXPLAIN SELECT S.SNO, S.SNAME
FROM Student S
         JOIN SC ON S.SNO = SC.SNO
         JOIN Course C ON SC.CNO = C.CNO
WHERE C.CNAME = '数据库';

#方法二
EXPLAIN SELECT S.SNO, S.SNAME
FROM Student S
WHERE S.SNO IN (SELECT SNO
                FROM SC
                WHERE CNO IN (SELECT CNO
                              FROM Course
                              WHERE CNAME = '数据库'));

#方法三
EXPLAIN SELECT S.SNO, S.SNAME
FROM Student S, SC, Course C
WHERE S.SNO = SC.SNO
  AND SC.CNO = C.CNO
  AND C.CNAME = '数据库';
