package com.service;

import com.dto.Ticket;
import com.mapper.TicketMapper;
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
        int result = ticketMapper.insertTicket(ticket);
        if(result != 1){
            throw new Exception("티켓 생성 에러");
        }
    }
}
