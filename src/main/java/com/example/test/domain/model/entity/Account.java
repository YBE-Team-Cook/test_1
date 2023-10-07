package com.example.test.domain.model.entity;

import com.example.test.domain.model.entity.cmmn.BaseTimeEntity;
import jakarta.persistence.*;
import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;

import java.time.LocalDateTime;

@Entity
@DynamicInsert
@Comment("계정")
public class Account extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "account_id", updatable = false, nullable = false)
    @Comment("계정 ID")
    private Integer accountId;

    @Column(nullable = false, length = 45)
    @Comment("이메일")
    private String email;

    @Column(nullable = false, length = 45)
    @Comment("이름")
    private String name;

    @Column(nullable = false, length = 255)
    @Comment("비밀번호")
    private String password;

    public Account(Integer accountId, String email, String name, String password) {
        this.accountId = accountId;
        this.email = email;
        this.name = name;
        this.password = password;
    }

    private Account(Builder builder) {
        accountId = builder.accountId;
        email = builder.email;
        name = builder.name;
        password = builder.password;
        createdAt = builder.createdAt;
        modifiedAt = builder.modifiedAt;
    }

    public Account() {

    }

    public static Builder builder() {
        return new Builder();
    }

    public Integer getAccountId() {
        return accountId;
    }

    public String getEmail() {
        return email;
    }

    public String getName() {
        return name;
    }

    public String getPassword() {
        return password;
    }


    public static final class Builder {
        private Integer accountId;
        private String email;
        private String name;
        private String password;
        private LocalDateTime createdAt;
        private LocalDateTime modifiedAt;

        private Builder() {
        }

        public Builder accountId(Integer val) {
            accountId = val;
            return this;
        }

        public Builder email(String val) {
            email = val;
            return this;
        }

        public Builder name(String val) {
            name = val;
            return this;
        }

        public Builder password(String val) {
            password = val;
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

        public Account build() {
            return new Account(this);
        }
    }
}
