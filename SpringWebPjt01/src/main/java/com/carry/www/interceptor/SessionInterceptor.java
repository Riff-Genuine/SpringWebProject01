package com.carry.www.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SessionInterceptor extends HandlerInterceptorAdapter {
	
	private HttpSession session;
	private PrintWriter out;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		session = request.getSession();
		
		if(session != null) {
			Object obj = session.getAttribute("user");
			if(obj != null) {
				return true;	
			}
		}
		response.setContentType("text/html; charset=UTF-8");
		out = response.getWriter();
		out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
		out.flush();
		
		return false;
	}
}
