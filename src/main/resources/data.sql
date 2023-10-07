INSERT IGNORE INTO account (email, name, password, created_at, modified_at)
VALUES ('user1@example.com', 'User One', 'password1', NOW(), NOW()),
       ('user2@example.com', 'User Two', 'password2', NOW(), NOW()),
       ('user3@example.com', 'User Three', 'password3', NOW(), NOW());

INSERT IGNORE INTO board (title, content, created_at, modified_at, account_id)
VALUES ('게시판 제목 1', '게시판 내용 1', NOW(), NOW(), 1),
       ('게시판 제목 2', '게시판 내용 2', NOW(), NOW(), 2),
       ('게시판 제목 3', '게시판 내용 3', NOW(), NOW(), 3);