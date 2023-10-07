package com.example.test.domain.model.entity;

import com.example.test.domain.model.entity.cmmn.BaseTimeEntity;
import jakarta.persistence.*;
import org.hibernate.annotations.*;

import java.time.LocalDateTime;

@Entity
@DynamicInsert
@DynamicUpdate
@Comment("게시판")
public class Board extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "board_id", updatable = false, nullable = false)
    @Comment("게시판 ID")
    private Integer boardId;

    @ManyToOne
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "account_id", nullable = false, updatable = false, referencedColumnName = "account_id")
    @Comment("계정 ID")
    private Account account;

    @Column(nullable = false, length = 255)
    @Comment("제목")
    private String title;

    @Column(columnDefinition = "MEDIUMTEXT", nullable = false)
    @Comment("내용")
    private String content;

    public Board(Integer boardId, Account account, String title, String content) {
        this.boardId = boardId;
        this.account = account;
        this.title = title;
        this.content = content;
    }

    private Board(Builder builder) {
        boardId = builder.boardId;
        account = builder.account;
        title = builder.title;
        content = builder.content;
        createdAt = builder.createdAt;
        modifiedAt = builder.modifiedAt;
    }

    public Board() {

    }

    public static Builder builder() {
        return new Builder();
    }

    public Integer getBoardId() {
        return boardId;
    }

    public Account getAccount() {
        return account;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }

    public static final class Builder {
        private Integer boardId;
        private Account account;
        private String title;
        private String content;
        private LocalDateTime createdAt;
        private LocalDateTime modifiedAt;

        private Builder() {
        }

        public Builder boardId(Integer val) {
            boardId = val;
            return this;
        }

        public Builder account(Account val) {
            account = val;
            return this;
        }

        public Builder title(String val) {
            title = val;
            return this;
        }

        public Builder content(String val) {
            content = val;
            return this;
        }

        public Builder createdAt(LocalDateTime val) {
            createdAt = val;
            return this;
        }

        public Builder modifiedAt(LocalDateTime val) {
            modifiedAt = val;
            return this;
        }

        public Board build() {
            return new Board(this);
        }
    }
}
