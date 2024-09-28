#找出使用上海供应商的零件的工程名称
SELECT j.JNAME
FROM j, spj, s
WHERE j.JNO = spj.JNO
  AND spj.SNO = s.SNO
  AND s.CITY = '上海';

