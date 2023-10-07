package com.example.test.service;

import com.example.test.web.dto.AccountDTO;

import java.util.List;

public interface AccountService {
    public List<AccountDTO> findAccounts();
}
