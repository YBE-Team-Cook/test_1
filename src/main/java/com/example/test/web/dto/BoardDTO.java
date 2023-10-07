package com.example.test.web.dto;

import io.soabase.recordbuilder.core.RecordBuilder;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Null;

import java.time.LocalDateTime;

@RecordBuilder
public record BoardDTO(
        Integer boardId,
        AccountDTO account,
        @NotNull(message = "제목을 입력해주세요")
        String title,
        String content,
        @Null(message = "Controller단에서 계산되는 값입니다.")
        LocalDateTime createdDate,
        @Null(message = "Controller단에서 계산되는 값입니다.")
        LocalDateTime modifiedDate
) {
}
