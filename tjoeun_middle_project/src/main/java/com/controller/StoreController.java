package com.controller;

import com.aop.AjaxUserIdCheck;
import com.aop.UserIdCheck;
import com.dto.Goods;
import com.dto.User;
import com.service.CouponService;
import com.service.GoodsService;
import com.service.PaymentService;
import java.io.File;
import java.util.*;
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

    CouponService couponService;

    PaymentService paymentService;
    @Autowired
    public StoreController(GoodsService goodsService, CouponService couponService,
        PaymentService paymentService) {
        this.goodsService = goodsService;
        this.couponService = couponService;
        this.paymentService = paymentService;
    }

    @GetMapping("/main")
    public String storeMain() {
        return "store/main";
    }

    @GetMapping("/add-store")
    public String add_store(Model model) {
        ArrayList<Goods> list = (ArrayList<Goods>)goodsService.getCategoryList("0");
        model.addAttribute("categoryImg",list);
        return "store/adminAddStore";
    }

    @GetMapping("/display")
    public String display(Model model) {
        List<Goods> goodsList;
        try {
            goodsList = goodsService.getGoodsList();
            model.addAttribute("goodsList", goodsList);
            model.addAttribute("setMenuList", goodsService.getCategoryList("1"));
            model.addAttribute("popcornList", goodsService.getCategoryList("2"));
            model.addAttribute("drinkList", goodsService.getCategoryList("3"));
        } catch (Exception e) {
            e.printStackTrace();
            //해결점
        }
        return "store/main";
    }

    @PostMapping("/insert-goods")
    public String insertGoods(@RequestParam("image") MultipartFile file, Goods goods) {
        try {
            String uploadPath = "C:\\Users\\USER\\Documents\\github\\tjoeun_middle_project\\tjoeun_middle_project\\src\\main\\webapp\\resources\\img\\goods";
            System.out.println("uploadPath = " + uploadPath);
            File folder = new File(uploadPath);
            if (!folder.exists()) {
                folder.mkdir();
            }
            String fileRealName = file.getOriginalFilename();
            UUID uuid = UUID.randomUUID();
            String uuids = uuid.toString().replace("-", "");
            String fileExtension = fileRealName.substring(fileRealName.indexOf("."));
            String fileName = uuids + fileExtension;

            File saveFile = new File(uploadPath + "/" + fileName);
            file.transferTo(saveFile);
            goods.setFileName(fileName);
            goods.setFileRealName(fileRealName);
            goods.setUploadPath("/resources/img/goods");
            goodsService.insertGoods(goods);
        } catch (Exception e) {
            e.printStackTrace();
            return "store/adminAddStore";
        }

        return "redirect:/store/display";
    }

    @GetMapping("/detail")
    public String storeDetail(Model model, String gno) {
        System.out.println(gno);
        Goods goods = goodsService.getSelectGoods(gno);
        model.addAttribute("selectGoods", goods);
        return "store/detail";
    }

    @GetMapping("/cart")
    @UserIdCheck
    public String cart() {
        return "store/cart";
    }

    @PostMapping("/cart-quantity-change")
    @AjaxUserIdCheck
    @ResponseBody
    public String quantityChange(String gno, Integer quantity, HttpSession session) {
        Map<String, Goods> goodsList = (Map<String, Goods>) session.getAttribute("cart");
        goodsList.get(gno).setQuantity(quantity);
        return "success";
    }


    @PostMapping("/cart-add")
    @AjaxUserIdCheck
    @ResponseBody
    public String cartAdd(String gno, HttpSession session) {
        Map<String, Goods> goodsList;
        try {
            Goods selectGoods = goodsService.getSelectGoods(gno);
            if (session.getAttribute("cart") == null) {
                goodsList = new HashMap<>();
                goodsList.put(gno, selectGoods);
                session.setAttribute("cart", goodsList);
            } else {
                goodsList = (Map<String, Goods>) session.getAttribute("cart");
                Goods goods = goodsList.get(gno);
                if (goods != null) {
                    if (goods.getQuantity() == 4) {
                        return "quantityError";
                    }
                    goods.setQuantity(goods.getQuantity() + 1);
                } else {
                    goodsList.put(gno, selectGoods);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
        return "success";
    }

    @GetMapping("/purchase")
    @UserIdCheck
    public String purchase() {
        return "store/purchase";
    }

    @PostMapping("/purchase")
    @ResponseBody
    public String purchasePost(HttpSession session, String imp_uid, Integer paid_amount) {
        Map<String, Goods> cart = (Map<String, Goods>) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");
        try {
            couponService.insertCoupon(cart, imp_uid, paid_amount, user.getId());
        } catch (Exception e) {
            e.printStackTrace();
            String accessToken = paymentService.getAccessToken();
            paymentService.payCancel(accessToken,imp_uid);
            return "fail";
        }
        session.removeAttribute("cart");  //카트 세션 삭제
        return "success";
    }

    @PostMapping("/delete")
    @AjaxUserIdCheck
    @ResponseBody
    public String delete(String gno, HttpSession session) {
        Map<String, Goods> cart = (Map<String, Goods>) session.getAttribute("cart");
        cart.remove(gno);
        if (cart.size() == 0) {
            session.removeAttribute("cart");
        }
        return "success";
    }


    @GetMapping("/purchase-complete")
    public String complete() {
        return "store/purchaseComplete";
    }
}
