package com.service;

import com.dto.Like;
import com.dto.Review;
import com.mapper.LikeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class LikeService {

    LikeMapper likeMapper;

    @Autowired
    public LikeService(LikeMapper likeMapper) {
        this.likeMapper = likeMapper;
    }


    //    public int ltlikecount(Like like) throws Exception {
//        int result = likeMapper.ltlikecount(like);
//        if(result == 0){
//            throw new Exception("좋아요 count 실패");
//        }
//        return result;
//    }


    //    public int ltlikegetinfo(Like like) throws Exception {
//        int result = likeMapper.ltlikegetinfo(like);
//        if (result == 0) {
//            throw new Exception("좋아요 getinfo 실패");
//        }
//        return result;
//    }
    public Like likeselect(Review review) {
        try {

            return likeMapper.likeselect(review);
        } catch (Exception e) {
            System.out.println("getInfo fail");
            e.printStackTrace();
        }
        return null;

    }

    public int likeinsert(Review review) throws Exception {
        int result = likeMapper.likeinsert(review);
        System.out.println("insert likehit");
        System.out.println(review.getSeq());
        if (result == 0) {
            throw new Exception("좋아요 insert실패");
        }
        return result;
    }

    //    public void likeupdate(Like like) throws Exception{
//        int result = likeMapper.likeupdate(like);
//        if(result == 0){
//            throw new Exception("좋아요 update실패");
//        }
//    }
    public void likedelete(Review review) {
        try {

            likeMapper.likedelete(review);
        } catch (Exception e) {
            System.out.println("delete fail");
            e.printStackTrace();
        }
    }

    public List<Like> selectAllBySeq(String seq) {
        try{
            return likeMapper.selectAllBySeq(seq);
        }catch (Exception e){
            System.out.println("selcetAll fail");
            e.printStackTrace();
        }
        return null;
    }

    public List<Like> selectByUserIdSeq(String userId, String seq) {
        Map<String,Object> map = new HashMap<>();
        map.put("id",userId);
        map.put("seq",seq);
        return likeMapper.selectByUserIdSeq(map);
    }
}
