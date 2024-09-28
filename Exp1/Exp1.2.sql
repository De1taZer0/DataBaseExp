CREATE DATABASE SPJ_MNG;
USE SPJ_MNG;
CREATE TABLE s
(
    SNO    VARCHAR(5) DEFAULT '',
    SNAME  VARCHAR(20),
    STATUS INT,
    CITY   VARCHAR(10),
    PRIMARY KEY (SNO)
);

CREATE TABLE p
(
    PNO    VARCHAR(5) DEFAULT '',
    PNAME  VARCHAR(20),
    COLOR  CHAR(2),
    WEIGHT INT,
    PRIMARY KEY (PNO)
);

CREATE TABLE j
(
    JNO   VARCHAR(5) DEFAULT '',
    JNAME VARCHAR(20),
    CITY  VARCHAR(10),
    PRIMARY KEY (JNO)
);

CREATE TABLE spj
(
    ID  INT NOT NULL DEFAULT '0',
    SNO VARCHAR(5),
    PNO VARCHAR(5),
    JNO VARCHAR(5),
    QTY INT,
    PRIMARY KEY (ID)
);

INSERT INTO s (SNO, SNAME, STATUS, CITY)
VALUES ('S1', '精益', 20, '天津'),
       ('S2', '盛锡', 10, '北京'),
       ('S3', '东方红', 30, '北京'),
       ('S4', '丰泰盛', 20, '天津'),
       ('S5', '为民', 30, '上海');

INSERT INTO p (PNO, PNAME, COLOR, WEIGHT)
VALUES ('P1', '螺母', '红', 12),
       ('P2', '螺栓', '绿', 17),
       ('P3', '螺丝刀', '蓝', 14),
       ('P4', '螺丝刀', '红', 14),
       ('P5', '凸轮', '蓝', 40),
       ('P6', '齿轮', '红', 30);

INSERT INTO j (JNO, JNAME, CITY)
VALUES ('J1', '三建', '北京'),
       ('J2', '一汽', '长春'),
       ('J3', '弹簧厂', '天津'),
       ('J4', '造船厂', '天津'),
       ('J5', '机车厂', '西安'),
       ('J6', '无线电厂', '常州'),
       ('J7', '半导体厂', '南京');

INSERT INTO spj (ID, SNO, PNO, JNO, QTY)
VALUES ('1', 'S1', 'P1', 'J1', 200),
       ('2', 'S1', 'P1', 'J3', 100),
       ('3', 'S1', 'P1', 'J4', 700),
       ('4', 'S1', 'P2', 'J2', 100),
       ('5', 'S2', 'P3', 'J1', 400),
       ('6', 'S2', 'P3', 'J2', 200),
       ('7', 'S2', 'P3', 'J4', 500),
       ('8', 'S2', 'P3', 'J5', 400),
       ('9', 'S2', 'P5', 'J1', 400),
       ('10', 'S2', 'P5', 'J2', 100),
       ('11', 'S3', 'P1', 'J1', 200),
       ('12', 'S3', 'P3', 'J1', 200),
       ('13', 'S4', 'P5', 'J1', 200),
       ('14', 'S4', 'P6', 'J3', 100),
       ('15', 'S4', 'P6', 'J4', 300),
       ('16', 'S5', 'P2', 'J4', 100),
       ('17', 'S5', 'P3', 'J1', 200),
       ('18', 'S5', 'P6', 'J2', 200),
       ('19', 'S5', 'P6', 'J4', 500);