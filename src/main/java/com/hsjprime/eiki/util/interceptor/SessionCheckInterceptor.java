package com.hsjprime.eiki.util.interceptor;

import com.hsjprime.eiki.member.vo.MemberSessionVO;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class SessionCheckInterceptor extends HandlerInterceptorAdapter {

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {

        HttpSession session = request.getSession();
        MemberSessionVO memberSessionVO = null;
        memberSessionVO = (MemberSessionVO) session.getAttribute("User");

        if (memberSessionVO == null) {
            response.sendRedirect("/");
            return false;
        }

        return true;

    }

}
