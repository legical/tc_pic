-- auto-generated definition
drop database if exists work;
create database work CHARSET='utf8mb4';
use work;
create table user
(
    id      INT(10)          NOT NULL AUTO_INCREMENT,
    userName varchar(255) NOT NULL,
    password  varchar(255) NULL,
    realName varchar(255) null,
    gender    int          null,
    birthday  datetime     null,
    idCard   varchar(255) null,
    sex       varchar(255) null,
    PRIMARY KEY (id)
)ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

INSERT INTO user VALUES (1, 'root', 'root', '管理员r', 1, '1999-03-21 09:42:36', '130102199903213516', '男');
INSERT INTO user VALUES (11, 'admin', 'admin', '管理员a', 1, '2000-06-14 14:15:24', '310101200006141674', '男');
INSERT INTO user VALUES (6, 'aa', 'a123456', '楚风', 1, '1992-04-27 09:59:34', '110101199204274432', '男');
INSERT INTO user VALUES (21, 'bb', 'b123456', '林妙雪', 0, '2001-05-24 06:52:23', '440103200105243280', '女');
INSERT INTO user VALUES (16, 'cc', 'c123456', '顾小桑', 0, '1998-11-20 03:23:21', '620102199811204467', '女');