package com.service;

import com.dto.Like;
import com.mapper.LikeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LikeService {

    LikeMapper likeMapper;

    @Autowired
    public LikeService(LikeMapper likeMapper) {
        this.likeMapper = likeMapper;
    }


    public int ltlikecount(Like like) throws Exception {
        int result = likeMapper.ltlikecount(like);
        if(result == 0){
            throw new Exception("좋아요 count 실패");
        }
        return result;
    }

    public int ltlikegetinfo(Like like) throws Exception{
        int result =  likeMapper.ltlikegetinfo(like);
        if(result == 0){
            throw new Exception("좋아요 getinfo 실패");
        }
        return result;
    }

    public void likeinsert(Like like) throws Exception{
        int result = likeMapper.likeinsert(like);
        if(result == 0){
            throw new Exception("좋아요 insert실패");
        }
    }

    public void likeupdate(Like like) throws Exception{
        int result = likeMapper.likeupdate(like);
        if(result == 0){
            throw new Exception("좋아요 update실패");
        }
    }
}
