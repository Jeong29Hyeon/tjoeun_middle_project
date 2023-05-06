package com.service;

import com.dto.Ticket;
import com.mapper.TicketMapper;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TicketService {
    TicketMapper ticketMapper;
    @Autowired
    public TicketService(TicketMapper ticketMapper) {
        this.ticketMapper = ticketMapper;
    }

    public void insertTicket(Ticket ticket) throws Exception {
        String[] eachSeats = ticket.getSeats().split(",");
        Ticket checkTicket = new Ticket();
        checkTicket.setHallInfo(ticket.getHallInfo());
        checkTicket.setDayInfo(ticket.getDayInfo());
        checkTicket.setTimeInfo(ticket.getTimeInfo());
        for(String str : eachSeats){
            checkTicket.setSeats(str);
            Ticket duplicateSeat = ticketMapper.existSeat(checkTicket);
            if(duplicateSeat != null){
                throw new Exception("이미 선택된 좌석");
            }
        }
        int result = ticketMapper.insertTicket(ticket);
        if(result != 1){
            throw new Exception("티켓 생성 에러");
        }
    }
    public List<Ticket> selectById(String id) {
        ArrayList<Ticket> list = new ArrayList<>();
        list = (ArrayList<Ticket>) ticketMapper.selectAllById(id);
        return list;
    }
    public List<Ticket> pastTicketById(String id) {
        ArrayList<Ticket> list = new ArrayList<>();
        list = (ArrayList<Ticket>) ticketMapper.pastTicketById(id);
        return list;
    }
    public List<Ticket> futureTicketById(String id) {
        ArrayList<Ticket> list = new ArrayList<>();
        list = (ArrayList<Ticket>) ticketMapper.futureTicketById(id);
        return list;
    }
    public List<Ticket> currentTicketById(String id) {
        ArrayList<Ticket> list = new ArrayList<>();
        list = (ArrayList<Ticket>) ticketMapper.currentTicketById(id);
        return list;
    }
    public List<String> selectChoiceSeats(String hallInfo, String dayInfo, String timeInfo)throws Exception {
        Map<String,String> map = new HashMap<>();
        map.put("hallInfo",hallInfo);
        map.put("dayInfo",dayInfo);
        map.put("timeInfo",timeInfo);
        return ticketMapper.selectChoiceSeats(map);
    }
    public void deleteTicket(Integer tno){
        ticketMapper.deleteTicket(tno);
    }
}
