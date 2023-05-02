package com.service;

import com.dto.Cinema;
import com.mapper.CinemaMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CinemaService {
    CinemaMapper cinemaMapper;
    @Autowired
    public CinemaService(CinemaMapper cinemaMapper){this.cinemaMapper = cinemaMapper;}

    public List<Cinema> selectAll(Cinema cinema){
        ArrayList<Cinema> list = (ArrayList<Cinema>) cinemaMapper.selectAll(cinema);
        return list;
    }
}
