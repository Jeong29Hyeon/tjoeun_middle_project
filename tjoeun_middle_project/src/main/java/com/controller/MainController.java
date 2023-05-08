package com.controller;

import com.dto.Movie;
import com.service.MovieService;
import java.io.IOException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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

}
