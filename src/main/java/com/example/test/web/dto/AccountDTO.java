package com.example.test.web.dto;

import io.soabase.recordbuilder.core.RecordBuilder;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDateTime;

@RecordBuilder
public record AccountDTO(
        Integer accountId,
        @Email(message = "유효하지 않은 메일 값입니다")
        String email,
        @NotNull(message = "닉네임을 입력해주세요")
        String name,
        String password,
        LocalDateTime createdDate,
        LocalDateTime modifiedDate
) {
}
