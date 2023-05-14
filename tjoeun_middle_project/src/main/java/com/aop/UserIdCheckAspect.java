package com.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Component
@Aspect
public class UserIdCheckAspect {


    @Around("@annotation(com.aop.UserIdCheck)")
    public Object idCheck(ProceedingJoinPoint joinPoint) throws Throwable {
        HttpServletRequest request =((ServletRequestAttributes)(RequestContextHolder.currentRequestAttributes()))
            .getRequest();

        HttpSession session = request.getSession();

        if(session.getAttribute("user")==null){
            return "redirect:/user/login?toUrl="+request.getRequestURI()+(request.getQueryString() == null?"":"?"+request.getQueryString());
        }

            return joinPoint.proceed();
    }
    @Around("@annotation(com.aop.AjaxUserIdCheck)")
    public Object ajaxIdCheck(ProceedingJoinPoint joinPoint) throws Throwable {
        HttpServletRequest request =((ServletRequestAttributes)(RequestContextHolder.currentRequestAttributes()))
            .getRequest();

        HttpSession session = request.getSession();

        if(session.getAttribute("user")==null){
            return "LOGIN_ERR";
        }
        return joinPoint.proceed();
    }
}
