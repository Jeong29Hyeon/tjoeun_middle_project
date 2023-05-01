package com.mapper;
import com.dto.User;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {
    int insertUser(User user);

    User selectById(String id);

    int updateUser(User user);

    int deleteById(String id);

}
