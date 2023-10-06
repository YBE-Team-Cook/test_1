alter user 'root'@'localhost' identified with caching_sha2_password by 'root';
flush privileges;

create database if not exists test;

use test;

create table if not exists ACCOUNT
(
    ACCOUNT_ID  int auto_increment comment '계정 ID'
        primary key,
    EMAIL       varchar(45)                        not null comment '이메일',
    NAME        varchar(45)                        not null comment '이름',
    PASSWORD    varchar(255)                       not null comment '비밀번호',
    CREATED_AT  datetime default CURRENT_TIMESTAMP not null comment '생성일',
    MODIFIED_AT datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '수정일'
)
    comment '계정';

create table if not exists BOARD
(
    BOARD_ID    int auto_increment comment '게시판 ID'
        primary key,
    TITLE       varchar(255)                       not null comment '제목',
    CONTENT     mediumtext                         not null comment '내용',
    CREATED_AT  datetime default CURRENT_TIMESTAMP not null comment '생성일',
    MODIFIED_AT datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '수정일',
    ACCOUNT_ID  int                                not null comment '계정 ID',
    constraint BOARD_ACCOUNT_ACCOUNT_ID_fk
        foreign key (ACCOUNT_ID) references ACCOUNT (ACCOUNT_ID)
            on update cascade on delete cascade
)
    comment '게시판';

INSERT IGNORE INTO ACCOUNT (EMAIL, NAME, PASSWORD, CREATED_AT, MODIFIED_AT)
VALUES ('user1@example.com', 'User One', 'password1', NOW(), NOW()),
       ('user2@example.com', 'User Two', 'password2', NOW(), NOW()),
       ('user3@example.com', 'User Three', 'password3', NOW(), NOW());

INSERT IGNORE INTO BOARD (TITLE, CONTENT, CREATED_AT, MODIFIED_AT, ACCOUNT_ID)
VALUES ('게시판 제목 1', '게시판 내용 1', NOW(), NOW(), 1),
       ('게시판 제목 2', '게시판 내용 2', NOW(), NOW(), 2),
       ('게시판 제목 3', '게시판 내용 3', NOW(), NOW(), 3);