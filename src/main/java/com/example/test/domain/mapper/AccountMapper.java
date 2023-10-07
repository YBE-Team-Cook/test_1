package com.example.test.domain.mapper;

import com.example.test.domain.mapper.cmmn.GenericMapper;
import com.example.test.domain.model.entity.Account;
import com.example.test.web.dto.AccountDTO;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AccountMapper extends GenericMapper<AccountDTO, Account> {
    AccountMapper INSTANCE = Mappers.getMapper(AccountMapper.class);
}
