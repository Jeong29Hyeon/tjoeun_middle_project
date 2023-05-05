package com.mapper;

import com.dto.Ticket;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TicketMapper {
    int insertTicket(Ticket ticket);
    List<Ticket> selectAllById(String id);
    List<String> selectChoiceSeats(Map<String,String> map);
    void deleteTicket(Ticket ticket);
    Ticket existSeat(Ticket ticket);
}
