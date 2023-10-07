package com.example.test.service.impl;


import com.example.test.domain.mapper.AccountMapper;
import com.example.test.domain.model.repository.AccountRepository;
import com.example.test.service.AccountService;
import com.example.test.web.dto.AccountDTO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AccountServiceImpl implements AccountService {
    private final AccountRepository accountRepository;
    public AccountServiceImpl(AccountRepository accountRepository) {
        this.accountRepository = accountRepository;
    }

    @Override
    public List<AccountDTO> findAccounts() {
        return AccountMapper.INSTANCE.toDTOList(accountRepository.selectAccounts());
    }
}
