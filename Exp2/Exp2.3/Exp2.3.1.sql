#求每个供应商号码，供应商名以及所供应零件的种类数量
SELECT s.SNO, s.SNAME, count(distinct PNO)
FROM s LEFT JOIN spj ON s.SNO = spj.SNO
GROUP BY s.SNO, s.SNAME;

