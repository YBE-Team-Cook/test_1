package com.example.test.domain.model.repository;

import com.example.test.domain.model.entity.Account;

import java.util.List;

public interface AccountRepository {
    public List<Account> selectAccounts();
}
