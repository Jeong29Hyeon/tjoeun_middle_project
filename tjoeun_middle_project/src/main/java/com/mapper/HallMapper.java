package com.mapper;

import com.dto.Hall;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface HallMapper {

    List<Hall> selectAll();
}
