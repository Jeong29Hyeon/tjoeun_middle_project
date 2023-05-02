package com.mapper;

import com.dto.Cinema;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CinemaMapper {

    List<Cinema> selectAll(Cinema cinema);
}
