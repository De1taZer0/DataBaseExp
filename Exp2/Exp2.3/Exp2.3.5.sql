#查询供给该工程的零件P1的平均供应量大于供给工程J1的任何一种零件的最大供应量的工程
SELECT DISTINCT JNO
FROM spj
WHERE PNO = 'P1'
GROUP BY JNO
HAVING AVG(QTY) > ALL
       (SELECT MAX(QTY)
        FROM spj
        WHERE JNO = 'J1'
        GROUP BY PNO);