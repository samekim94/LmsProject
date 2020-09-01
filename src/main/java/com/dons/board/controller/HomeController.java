package com.dons.board.controller;


import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.dons.board.bean.AdmiApplicationBean;
import com.dons.board.bean.MemberBean;
import com.dons.board.bean.ScheduleBean;
import com.dons.board.service.MemberService;
@Controller
public class HomeController {
	@Autowired
	MemberService ms; 
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	ModelAndView mav;
	
	@RequestMapping(value = "/")
	public String home() {
		return "loginFrm";
	}
	@RequestMapping(value = "/access")
	public ModelAndView home(MemberBean mb ,HttpSession session) {
		 mav = ms.access(mb, session);
		return mav;
	}
	@RequestMapping(value = "/logout")
	public String home(HttpSession session) {
		 session.invalidate();
		return "redirect:/";
	}
	@RequestMapping(value = "/joinFrm")
	public String joinFrm() {
		return "joinFrm";
	}
	@RequestMapping(value = "/joinFrmInsert")
	public ModelAndView joinFrm(MemberBean mb) {
		mav = ms.joinFrm(mb);
		return mav;
	}
	@RequestMapping(value = "/selectMyCalendarPage")
	public ModelAndView testRest(AdmiApplicationBean ab, HttpSession session) {
		mav = ms.selectMyCalendar(ab, session);
		return mav;
	}
}
