package com.controller;

import com.dto.Movie;
import com.service.MovieService;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MainController {
    MovieService movieService;
    @Autowired
    public MainController(MovieService movieService) {
        this.movieService = movieService;
    }

    @RequestMapping(value = "/", method = {RequestMethod.GET, RequestMethod.POST})
    public String index(Model model) throws IOException {
        model.addAttribute("movies", movieService.getMovies());
        return "index";
    }

    @RequestMapping("/getImage")
    public @ResponseBody ResponseEntity<byte[]> getImage(String fileName) throws IOException {
        System.out.println("fileName: " + fileName);
        File file = new File("C:\\upload\\img\\goods", fileName);
        System.out.println(file);
        ResponseEntity<byte[]> result = null;
        try {
            HttpHeaders headers = new HttpHeaders();
            //probeContentType: 파라미터로 전달받은 파일의 타입을 문자열로 변환해 주는 메서드.
            //사용자에게 보여주고자 하는 데이터가 어떤 파일인지를 검사해서 응답 상태 코드를 다르게 리턴할 수도 있습니다.
            String contentType = Files.probeContentType(file.toPath());
            System.out.println("contentType = " + contentType);
            headers.add("Content-Type", contentType);
            //ResponseEntity<>(응답 객체에 담을 내용, 헤더에 담을 내용, 상태 메세지);
            //FileCopyUtils: 파일 및 스트림 데이터 복사를 위한 간단한 유틸리티 메서드의 집합체.
            //file객체 안에 있는 내용을 복사해서 byte배열로 변환해서 바디에 담아 화면에 전달.
            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }

}
