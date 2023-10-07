package com.example.test.domain.model.repository.impl;

import com.example.test.domain.model.entity.Account;
import com.example.test.domain.model.repository.AccountRepository;
import com.querydsl.jpa.impl.JPAQueryFactory;
import jakarta.persistence.EntityManager;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static com.example.test.domain.model.entity.QAccount.account;

@Repository
@Transactional
public class AccountRepositoryImpl implements AccountRepository {
    private final JPAQueryFactory jpaQueryFactory;
    private final EntityManager entityManager;

    public AccountRepositoryImpl(JPAQueryFactory jpaQueryFactory, EntityManager entityManager) {
        this.jpaQueryFactory = jpaQueryFactory;
        this.entityManager = entityManager;
    }

    @Override
    public List<Account> selectAccounts() {
        return jpaQueryFactory.selectFrom(account).fetch();
    }
}
