#查询没有使用天津供应商生产的红色零件的工程号码
SELECT DISTINCT j.JNO
FROM j
WHERE j.JNO NOT IN
      (SELECT j.JNO
       FROM j, spj, s, p
       WHERE j.JNO = spj.JNO
         AND spj.SNO = s.SNO
         AND spj.PNO = p.PNO
         AND s.CITY = '天津'
         AND p.COLOR = '红');

