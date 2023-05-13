package com.service;

import com.dto.Payment;
import com.dto.Ticket;
import com.mapper.PaymentMapper;
import com.mapper.TicketMapper;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

@Service
public class TicketService {
    TicketMapper ticketMapper;
    PaymentMapper paymentMapper;

    DataSourceTransactionManager transactionManager;

    @Autowired
    public TicketService(TicketMapper ticketMapper, PaymentMapper paymentMapper,
        DataSourceTransactionManager transactionManager) {
        this.ticketMapper = ticketMapper;
        this.paymentMapper = paymentMapper;
        this.transactionManager = transactionManager;
    }

    public void insertTicket(Ticket ticket,String imp_uid, Integer paid_amount) throws Exception {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = transactionManager.getTransaction(def);
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

        Payment payment = null;
        try {
            ticketMapper.insertTicket(ticket);
            payment = new Payment();
            payment.setPaid_amount(paid_amount);
            payment.setImp_uid(imp_uid);
            payment.setTno(ticket.getTno());
            paymentMapper.insertTicketPayment(payment);
            transactionManager.commit(status);
        } catch (Exception e) {
            transactionManager.rollback(status);
            throw new RuntimeException(e);
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
    public Integer sumPrice(String id){
        return ticketMapper.sumPrice(id);
    }
}
