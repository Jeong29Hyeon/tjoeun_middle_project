package com.service;

import com.dto.Payment;
import com.mapper.PaymentMapper;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PaymentService {
    PaymentMapper paymentMapper;
    @Autowired
    public PaymentService(PaymentMapper paymentMapper) {
        this.paymentMapper = paymentMapper;
    }

    public void insertTicketPayment(Payment payment) throws Exception {
        int result = paymentMapper.insertTicketPayment(payment);
        if(result < 1){
            throw new Exception("티켓 결제정보 생성안됨");
        }
    }
    public void insertGoodsPayment(Payment payment) throws Exception {
        int result = paymentMapper.insertGoodsPayment(payment);
        if(result < 1){
            throw new Exception("티켓 결제정보 생성안됨");
        }
    }

    public String getAccessToken(){
        String reqUrl = "https://api.iamport.kr/users/getToken";
        String access_token = "";
        try {
            URL url = new URL(reqUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type","application/json");
            conn.setDoOutput(true);

            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            Map<String,Object> map = new HashMap<>();
            map.put("imp_key","5207846072363461");
            map.put("imp_secret","CmWts21sjpizpZUz7nKWvZFXdjpydYg9e9bSxSSnKIEDNq2BKYxChqcs13lWnqY5EhknogE5uEoDuPaI");
            JSONParser jsonParser = new JSONParser();
            JSONObject reqJson = new JSONObject(map);
            System.out.println("reqJson.toString() = " + reqJson.toString());
            bw.write(reqJson.toJSONString());
            bw.flush();

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode = " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder result = new StringBuilder();
            String line = "";
            while((line = br.readLine())!=null){
                result.append(line);
            }
            JSONObject obj = (JSONObject) jsonParser.parse(result.toString());
            JSONObject responseObj = (JSONObject) obj.get("response");
            access_token = responseObj.get("access_token").toString();
            System.out.println("access_token = " + access_token);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return access_token;
    }


    public String getImpUidByTno(Integer tno) {
        return paymentMapper.selectImpUidByTno(tno);
    }

    public void payCancel(String accessToken, String imp_uid) {
        String reqUrl = "https://api.iamport.kr/payments/cancel";
        try {
            URL url = new URL(reqUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type","application/json");
            conn.setRequestProperty("Authorization",accessToken);
            conn.setDoOutput(true);

            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            Map<String,Object> map = new HashMap<>();
            map.put("imp_uid",imp_uid);
            JSONObject reqJson = new JSONObject(map);
            bw.write(reqJson.toJSONString());
            bw.flush();

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode = " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder result = new StringBuilder();
            String line = "";
            while((line = br.readLine())!=null){
                result.append(line);
            }
            JSONParser parser = new JSONParser();
            JSONObject obj = (JSONObject) parser.parse(result.toString());
            System.out.println("obj = " + obj);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
