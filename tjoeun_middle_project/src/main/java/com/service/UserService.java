package com.service;

import com.dto.User;
import com.mapper.UserMapper;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    UserMapper userMapper;

    @Autowired
    public UserService(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    public void register(User user) throws Exception {
        if (userMapper.insertUser(user) == 0) {
            throw new Exception("인서트 되지않음");
        }
    }

    public User login(String id, String passwd) throws Exception {
        User user = userMapper.selectById(id);
        if (user == null || !user.getPassword().equals(passwd)) {
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

    public void editInfo(User editUser) throws Exception {
        if (userMapper.updateUser(editUser) == 0) {
            throw new Exception("수정 안됨");
        }
    }
}
