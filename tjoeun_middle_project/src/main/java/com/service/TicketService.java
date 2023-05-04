package com.service;

import com.dto.Ticket;
import com.mapper.TicketMapper;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TicketService {
    TicketMapper ticketMapper;
    @Autowired
    public TicketService(TicketMapper ticketMapper) {
        this.ticketMapper = ticketMapper;
    }

    public void insertTicket(Ticket ticket) throws Exception {
        ticket.setSeats(ticket.getSeats()+",");
        int result = ticketMapper.insertTicket(ticket);
        if(result != 1){
            throw new Exception("티켓 생성 에러");
        }
    }

    public List<String> selectChoiceSeats(String hallInfo, String dayInfo, String timeInfo)throws Exception {
        Map<String,String> map = new HashMap<>();
        map.put("hallInfo",hallInfo);
        map.put("dayInfo",dayInfo);
        map.put("timeInfo",timeInfo);
        return ticketMapper.selectChoiceSeats(map);
    }
}
