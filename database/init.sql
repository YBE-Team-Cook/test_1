alter user 'root'@'localhost' identified with caching_sha2_password by 'root';
flush privileges;

create database if not exists db;

use db;

create table if not exists account
(
    account_id  int auto_increment comment '계정 ID' primary key,
    email       varchar(45)                        not null comment '이메일',
    name        varchar(45)                        not null comment '이름',
    password    varchar(255)                       not null comment '비밀번호',
    created_at  datetime default CURRENT_TIMESTAMP not null comment '생성일',
    modified_at datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '수정일'
)
    comment '계정';

create table if not exists board
(
    board_id    int auto_increment comment '게시판 ID' primary key,
    title       varchar(255)                       not null comment '제목',
    content     mediumtext                         not null comment '내용',
    created_at  datetime default CURRENT_TIMESTAMP not null comment '생성일',
    modified_at datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '수정일',
    account_id  int                                not null comment '계정 ID',
    constraint board_account_account_id_fk
        foreign key (account_id) references account (account_id)
            on update cascade on delete cascade
)
    comment '게시판';