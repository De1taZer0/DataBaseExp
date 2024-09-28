CREATE DATABASE Student;
USE Student;
CREATE TABLE Student
(
    SNO     CHAR(5),
    SNAME   VARCHAR(20),
    SGENDER CHAR(2),
    SBIRTH  DATE,
    SDEP    CHAR(20),
    SDMAJOR VARCHAR(20),
    SAGE    INT,
    PRIMARY KEY (SNO)
);

CREATE TABLE Course
(
    CNO    CHAR(5),
    CNAME  VARCHAR(20),
    CREDIT INT,
    CPNO   CHAR(5),
    PRIMARY KEY (CNO)
);

CREATE TABLE SC
(
    SNO           CHAR(5),
    CNO           CHAR(5),
    GRADE         INT,
    SEMESTER      CHAR(6),
    TEACHINGCLASS VARCHAR(8),
    PRIMARY KEY (SNO, CNO)
);

INSERT INTO Student (SNO, SNAME, SGENDER, SBIRTH, SDEP, SDMAJOR, SAGE)
VALUES ('20001', '李勇', '男', '2003/01/01', 'MA', '统计学', 19),
       ('20002', '刘晨', '女', '2004/02/01', 'PHY', '材料物理', 18),
       ('20003', '王敏', '女', '2000/10/01', 'CS', '计算机科学与技术', 22),
       ('20004', '张立', '男', '2003/06/01', 'CS', '数据科学与大数据技术', 19);

INSERT INTO Course (CNO, CNAME, CREDIT, CPNO)
VALUES ('1', '数据库', 3, 2),
       ('2', '高等数学', 5, ''),
       ('3', '信息系统', 2, 1),
       ('4', '操作系统', 3, 5),
       ('5', '数据结构', 3, 6),
       ('6', 'C语言', 2, '');

INSERT INTO SC (SNO, CNO, GRADE, SEMESTER, TEACHINGCLASS)
VALUES ('20001', '1', 92, '2021-2', '1-01'),
       ('20001', '2', 85, '2022-1', '2-01'),
       ('20001', '3', NULL, '2022-2', '3-01'),
       ('20002', '2', 78, '2021-2', '2-02'),
       ('20002', '3', 84, '2020-1', '3-01'),
       ('20003', '6', 91, '2022-2', '6-02');