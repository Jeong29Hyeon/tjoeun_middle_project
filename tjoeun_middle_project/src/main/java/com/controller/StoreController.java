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
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

    @PostMapping(value = "/insert-goods", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public ResponseEntity<Map<String,Object>> insertGoods(@RequestParam("image") MultipartFile file, Goods goods) {
        Map<String,Object> map = new HashMap<>();
        System.out.println("goods = " + goods);
        try {
            String uploadPath = "C:\\upload\\img\\goods";
            File folder = new File(uploadPath);
            if (!folder.exists()) {
                boolean mkdirs = folder.mkdirs();
            }
            String fileRealName = file.getOriginalFilename();
            UUID uuid = UUID.randomUUID();
            String uuids = uuid.toString().replace("-", "");
            String contentType = file.getContentType();
            String extension = "";
            if(StringUtils.hasText(contentType)){
                if(contentType.equals("image/jpeg")){
                    extension = ".jpg";
                }
                else if(contentType.equals("image/png")){
                    extension = ".png";
                }
                else if(contentType.equals("image/gif")){
                    extension = ".gif";
                }
                else{
                    map.put("errorMsg","이미지파일만 업로드할 수 있습니다.");
                    return ResponseEntity.badRequest().body(map);
                }
            }else {
                map.put("errorMsg","파일에 확장자가 존재하지 않습니다.");
                return ResponseEntity.badRequest().body(map);
            }
            String fileName = uuids + extension;
            File saveFile = new File(uploadPath + "/" + fileName);
            file.transferTo(saveFile);
            goods.setFileName(fileName);
            goods.setFileRealName(fileRealName);
            goods.setUploadPath(uploadPath);
            goodsService.insertGoods(goods);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("errorMsg","굿즈 생성 DB 에러");
            return ResponseEntity.badRequest().body(map);
        }
        map.put("msg","굿즈 생성완료");
        return ResponseEntity.ok(map);
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

    @GetMapping("/mobile-purchase")
    public String mobilePurchase(HttpSession session, String imp_uid, Integer paid_amount,boolean imp_success,
        RedirectAttributes ra) {
        Map<String, Goods> cart = (Map<String, Goods>) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");
        try {
            if(imp_success){

                couponService.insertCoupon(cart, imp_uid, paid_amount, user.getId());
            }else{
                ra.addFlashAttribute("msg","결제를 취소하셨습니다.");
                return "redirect:/store/purchase";
            }
        } catch (Exception e) {
            e.printStackTrace();
            String accessToken = paymentService.getAccessToken();
            paymentService.payCancel(accessToken,imp_uid);
            ra.addFlashAttribute("msg","서버 장애로 인해 결제가 취소되었습니다, 다시 시도해주세요.");
            return "redirect:/store/purchase";
        }
        session.removeAttribute("cart");  //카트 세션 삭제
        return "redirect:/store/purchase-complete";
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
