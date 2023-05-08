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
    void deleteTicket(Integer tno);
    Ticket existSeat(Ticket ticket);
    List<Ticket> pastTicketById(String id);
    List<Ticket> futureTicketById(String id);
    List<Ticket> currentTicketById(String id);
}
