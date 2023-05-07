package com.controller;

import com.dto.Like;
import com.service.LikeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@RequestMapping("/like")
@Controller
public class LikeController {

    LikeService likeService;

    @Autowired
    public LikeController(LikeService likeService) {
        this.likeService = likeService;
    }

    @PostMapping("/update")
    @ResponseBody
    public Map<String,String> likeupdate(Like like){
//        logger.info("likeupdate");    //이게머임??

        Map<String,String> map = new HashMap<String, String>();

        try {
            likeService.likeupdate(like);
            map.put("result", "success");

        }catch(Exception e) {
            e.printStackTrace();
            map.put("result", "fail");
        }

        return map;
    }
}
