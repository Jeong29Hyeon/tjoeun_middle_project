package com.controller;

import com.dto.Goods;
import com.service.GoodsService;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/store")
public class StoreController {

    GoodsService goodsService;
    @Autowired
    public StoreController(GoodsService goodsService) {
        this.goodsService = goodsService;
    }

    @GetMapping("/main")
    public String storeMain(){
        return "store/main";
    }

    @GetMapping("/test")
    public String test(){
        return "store/insertTest";
    }

    @GetMapping("/display")
    public String display(Model model){
        List<Goods> goodsList;
        try {
            goodsList = goodsService.getGoodsList();
            model.addAttribute("goodsList",goodsList);
            model.addAttribute("setMenuList",goodsService.getCategoryList("setMenu"));
            model.addAttribute("popcornList",goodsService.getCategoryList("popcorn"));
            model.addAttribute("drinkList",goodsService.getCategoryList("drink"));
        }catch (Exception e){
            e.printStackTrace();
            //해결점
        }
        return "store/main";
    }

    @PostMapping("/insert-goods")
    public String insertGoods(@RequestParam("image")MultipartFile file, Goods goods,
        HttpServletRequest request){
        try{
            String uploadPath = "C:\\Users\\USER\\Documents\\github\\tjoeun_middle_project\\tjoeun_middle_project\\src\\main\\webapp\\resources\\img\\goods";
            System.out.println("uploadPath = " + uploadPath);
            File folder = new File(uploadPath);
            if(!folder.exists()){
                folder.mkdir();
            }
            String fileRealName = file.getOriginalFilename();
            UUID uuid = UUID.randomUUID();
            String uuids = uuid.toString().replace("-","");
            String fileExtension = fileRealName.substring(fileRealName.indexOf("."));
            String fileName = uuids+fileExtension;

            File saveFile = new File(uploadPath+"/"+fileName);
            file.transferTo(saveFile);
            goods.setFileName(fileName);
            goods.setFileRealName(fileRealName);
            goods.setUploadPath("/resources/img/goods");
            goodsService.insertGoods(goods);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/store/display";
    }
    @GetMapping("/detail")
    public String storeDetail(Model model,String gno){
        System.out.println(gno);
        Goods goods = goodsService.getSelectGoods(gno);
        model.addAttribute("selectGoods",goods);
        return "store/detail";
    }

    @PostMapping("/cart")
    public String cart(){
        return "store/cart";
    }

    @PostMapping("/cart-add")
    @ResponseBody
    public String cartAdd(String gno, HttpSession session){
        List<Goods> goodsList;
        try {
            Goods selectGoods = goodsService.getSelectGoods(gno);
            if(session.getAttribute("cart")==null){
                goodsList = new ArrayList<>();
                goodsList.add(selectGoods);
                session.setAttribute("cart",goodsList);
            }else{
                goodsList = (List<Goods>) session.getAttribute("cart");
                goodsList.add(selectGoods);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
        return "success";
    }
}