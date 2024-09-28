#查询至少使用了供应商S1所供应的全部零件的工程号
SELECT DISTINCT JNO
FROM spj
WHERE PNO IN
      (SELECT PNO
       FROM spj
       WHERE SNO = 'S1')
GROUP BY JNO
HAVING COUNT(DISTINCT PNO) = (SELECT COUNT(DISTINCT PNO)
                               FROM spj
                               WHERE SNO = 'S1');

