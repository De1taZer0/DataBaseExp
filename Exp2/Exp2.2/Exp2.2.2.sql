#把由S5供给J4的零件P6改为由S3供应
UPDATE spj
SET SNO = 'S3'
WHERE SNO = 'S5' AND JNO = 'J4' AND PNO = 'P6'