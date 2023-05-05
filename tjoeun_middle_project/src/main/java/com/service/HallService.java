package com.service;

import com.dto.Hall;
import com.mapper.HallMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class HallService {
    HallMapper hallMapper;
    @Autowired
    public HallService(HallMapper hallMapper){this.hallMapper = hallMapper;}

    public List<Hall> selectAll(){
        ArrayList<Hall> list = (ArrayList<Hall>) hallMapper.selectAll();
        return list;
    }
}
