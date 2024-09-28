#查询选修了全部课程并且其中一门课在90分以上的学生姓名
SELECT S.SNAME
FROM Student S
         JOIN SC ON S.SNO = SC.SNO
WHERE S.SNO IN (SELECT SNO
                FROM SC
                GROUP BY SNO
                HAVING COUNT(DISTINCT CNO) = (SELECT COUNT(*) FROM Course)
                    AND MAX(GRADE) >= 90);