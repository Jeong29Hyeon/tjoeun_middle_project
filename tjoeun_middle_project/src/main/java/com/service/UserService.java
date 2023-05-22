package com.service;

import com.dto.User;
import com.mapper.UserMapper;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import java.util.Optional;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    UserMapper userMapper;

    @Autowired
    public UserService(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    public String updateRank(String id, int sumPrice) {
        String rank = "";
        Map<String,String> map = new HashMap<>();
        if(sumPrice == 0){
            rank = "BRONZE";
            map.put("rank",rank);
            map.put("id", id);
            userMapper.updateRank(map);
            return rank;
        }else if (sumPrice < 100000) {
            rank = "BRONZE";
            map.put("rank",rank);
            map.put("id", id);
            userMapper.updateRank(map);
            return rank;
        } else if (sumPrice < 200000) {
            rank = "SILVER";
            map.put("rank",rank);
            map.put("id", id);
            userMapper.updateRank(map);
            return rank;
        } else if (sumPrice < 300000) {
            rank = "GOLD";
            map.put("rank",rank);
            map.put("id", id);
            userMapper.updateRank(map);
            return rank;
        } else if (sumPrice < 400000) {
            rank = "VIP";
            map.put("rank",rank);
            map.put("id", id);
            userMapper.updateRank(map);
            return rank;
        } else {
            rank = "VVIP";
            map.put("rank",rank);
            map.put("id", id);
            userMapper.updateRank(map);
            return rank;
        }
    }

    public void register(User user) throws Exception {
        if (userMapper.insertUser(user) == 0) {
            throw new Exception("인서트 되지않음");
        }
    }

    public User login(String id, String password) throws Exception {
        User user = userMapper.selectById(id);
        if (user == null || !user.getPassword().equals(password)) {
            throw new Exception("id,pw에 해당하는 유저가 없음");
        }
        return user;
    }

    public String idCheck(String id) {
        if (userMapper.selectById(id) == null) {
            return "success";
        }
        return "duplicate";
    }

//    public void editInfo(User editUser) throws Exception {
//        if (userMapper.updateUser(editUser) == 0) {
//            throw new Exception("수정 안됨");
//        }
//    }

    public String getAccessToken(String authorizeCode) {
        String accessToken = "";
        String refreshToken = "";
        String reqUrl = "https://kauth.kakao.com/oauth/token";
        try{
            URL url = new URL(reqUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=e765b37b419e417d6a4d99f777b7eac2");
            sb.append("&redirect_uri=http://43.200.171.39/user/kakaoAuth");
            sb.append("&code=").append(authorizeCode);
            bw.write(sb.toString());
            bw.flush();

            int responseCode = conn.getResponseCode(); //200이면 성공
            System.out.println("responseCode = " + responseCode);
            if(responseCode == 200){
                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(),
                    StandardCharsets.UTF_8));
                String line = "";
                StringBuilder result = new StringBuilder();

                while((line = br.readLine())!=null){
                    result.append(line);
                }
                System.out.println("response body= " + result);

                JSONParser parser = new JSONParser();
                JSONObject obj = (JSONObject) parser.parse(String.valueOf(result));
                accessToken = obj.get("access_token").toString();
                refreshToken = obj.get("refresh_token").toString();
                System.out.println("accessToken = " + accessToken);
                System.out.println("refreshToken = " + refreshToken);
                br.close();
            }
            bw.close();
        } catch (IOException | ParseException e) {
            throw new RuntimeException(e);
        }
        return accessToken;
    }

    public User getUserInfo(String accessToken) {
        User user = new User();
        String reqURL = "https://kapi.kakao.com/v2/user/me";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            // 요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
            if(responseCode == 200){
                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(),
                    StandardCharsets.UTF_8));
                String line = "";
                StringBuilder result = new StringBuilder();

                while ((line = br.readLine()) != null) {
                    result.append(line);
                }
                System.out.println("response body : " + result);

                JSONParser parser = new JSONParser();
                JSONObject obj = (JSONObject) parser.parse(result.toString());
                JSONObject properties = (JSONObject) obj.get("properties");
                JSONObject kakao_account = (JSONObject) obj.get("kakao_account");
                boolean email_needs_agreement = (boolean) kakao_account.get("email_needs_agreement");
                String nickname = properties.get("nickname").toString();
                user.setName(nickname);
                if(!email_needs_agreement){//이메일 동의가 필요한가 -> false 면 이메일이 있음
                    String email = kakao_account.get("email").toString();
                    user.setId(email);
                }else{
                    String id = obj.get("id").toString();
                    user.setId(id);
                }
            }
        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
        return user;
    }

    public void kakaoLogout(String accessToken) {
        String reqUrl = "https://kapi.kakao.com/v1/user/logout";
        try {
            URL url = new URL(reqUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization","Bearer "+accessToken);
            int responseCode = conn.getResponseCode();

            String line = "";
            StringBuilder result = new StringBuilder();
            if(responseCode == 200){
                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                while((line = br.readLine())!=null){
                    result.append(line);
                }
            }
            System.out.println(result);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
    public User searchIdPw(User user){
        System.out.println("service:"+user.getName());
        try {
            userMapper.searchIdPw(user);
            return userMapper.searchIdPw(user);
        }catch (Exception e){
            e.printStackTrace();
            return null;  //이름 생일 불일치
        }
    }

    public List<User> getAllUser(){
        return userMapper.selectAllUser();
    }

    public void updateInfo(User newUser) {
        userMapper.updateUser(newUser);
    }

    public User selectById(String id) {
        return userMapper.selectById(id);
    }

    public void deleteById(String id) {
        int result = userMapper.deleteById(id);
        if(result < 1){
            throw new RuntimeException("삭제실패");
        }
    }
}
