package com.example.test.domain.mapper;

import com.example.test.domain.mapper.cmmn.GenericMapper;
import com.example.test.domain.model.entity.Board;
import com.example.test.web.dto.BoardDTO;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface BoardMapper extends GenericMapper<BoardDTO, Board> {
    BoardMapper INSTANCE = Mappers.getMapper(BoardMapper.class);
}
