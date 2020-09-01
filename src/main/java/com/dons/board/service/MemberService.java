package com.dons.board.service;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import com.dons.board.bean.AdmiApplicationBean;
import com.dons.board.bean.ClassBean;
import com.dons.board.bean.MemberBean;
import com.dons.board.bean.ScheduleBean;
import com.dons.board.dao.IMemberDao;
import com.google.gson.Gson;

@Component
public class MemberService {
	
	@Autowired //의존성주입
	private IMemberDao mDao;

	public ModelAndView access(MemberBean mb, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();
		String pwEncode = mDao.getSecurityPw(mb.getMember_id());
		System.out.println("pw="+pwEncode);
		if(pwEncode!=null) {
			if(pwEncoder.matches(mb.getMember_pw(), pwEncode)) {
				session.setAttribute("id", mb.getMember_id());
				mb=mDao.getMemberInfo(mb.getMember_id());
				session.setAttribute("mb", mb);
//				mav.setViewName("forward:/boardList"); url get-get post-post				
				mav.setViewName("redirect:/boardList");	// url get, post >> get			
			}else {
				mav.addObject("check",2);
				mav.setViewName("loginFrm");				
			}
			
		}else {
			mav.addObject("msg","login fail");
			mav.setViewName("loginFrm");
		}
		return mav;
	}

	public ModelAndView joinFrm(MemberBean mb) {
		// Encoder (암호화) <------> Decoder(복호화)
		// 스프링은 복호화가 불가능 
		BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();
		boolean result;
		ModelAndView mav = new ModelAndView();
		mb.setMember_pw(pwEncoder.encode(mb.getMember_pw()));
		result = mDao.joinFrmInsert(mb);
		if(result) {
			System.out.println("joinFrm insert success");
			mav.addObject("check",1);
			mav.setViewName("loginFrm");
		}else {
			System.out.println("joinFrm insert fail");
			mav.setViewName("joinFrm");
		}
		return mav;
	}

	public ModelAndView selectMyCalendar(AdmiApplicationBean ab, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		//sb.setSc_id(session.getAttribute("id").toString());  
		ab.setAa_id("dons"); // 아직 더미데이터로 작업해야해서 아이디 주고 시작 ; 
		List<AdmiApplicationBean> aList; 
		aList = mDao.selectMyCalendar(ab); //수강신청값 받아옴 
		if(aList!=null){
			System.out.println("selectMyCalendar select success");
			mav.setViewName("MyScheduel");
			mav.addObject("classList", new Gson().toJson(aList));
		}else {
			System.out.println("selectMyCalendar select fail");
		}
		return mav;
	}
	
}
