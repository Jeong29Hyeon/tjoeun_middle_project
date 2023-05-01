package com.mapper;
import com.dto.User;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {
    int insert(User user);
    int deleteById(String id);
    int update(User user);
    User selectById(String id);
}
