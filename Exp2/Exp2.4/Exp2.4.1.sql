#查询每个学生已经获得的学分的总分（成绩及格表示获得该门课的学分，并按照所获学分由高到低的顺序输出学号，姓名，所获学分。
SELECT S.SNO, S.SNAME, SUM(C.CREDIT) AS TOTAL_CREDIT
FROM Student S
         JOIN SC ON S.SNO = SC.SNO
         JOIN Course C ON SC.CNO = C.CNO
WHERE SC.GRADE >= 60
GROUP BY S.SNO, S.SNAME
ORDER BY TOTAL_CREDIT DESC;

