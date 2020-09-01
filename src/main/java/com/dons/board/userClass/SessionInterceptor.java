package com.dons.board.userClass;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SessionInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("preHandler call");
		if(request.getSession().getAttribute("id")==null) {
			response.sendRedirect("./"); // 결과적으로 전페이지로 이동킴
		}
		return true; //controller로 보내줌
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception { // 뷰 가기 직전에 해봄 
		System.out.println("postHandler call");
		super.postHandle(request, response, handler, modelAndView);
	} 
	
}
