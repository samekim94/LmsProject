package com.dons.board.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dons.board.Exception.DbException;
import com.dons.board.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService bs;
	
	ModelAndView mav;
	
	@RequestMapping(value="/boardList")
	public ModelAndView getBoardList(Integer pageNum) {
		mav= bs.getBoardList(pageNum);
		return mav;
	}
	@RequestMapping(value="/contents")
	public ModelAndView getContents(Integer bNum) {
		mav= bs.getContents(bNum);
		return mav;
	}
	@RequestMapping(value="/boardDelete")
	public ModelAndView deleteBoard(Integer boardNum, RedirectAttributes attr) throws DbException{ // dbexception으로 던짐 예외처리
		mav= bs.deleteBoard(boardNum, attr);
		return mav;
	}
	@RequestMapping(value="/goWriteBoard")
	public ModelAndView goWriteBoard(){ 
		mav.setViewName("WriteBoard");
		return mav;
	}
	@RequestMapping(value="/WriteBoard")
	public ModelAndView writeBoardInsertion(MultipartHttpServletRequest multi){
		mav= bs.writeBoardInsertion(multi);
		return mav;
	}
//	@RequestMapping(value="/download")
//	public void downloadFile(@RequestParam Map<String, Object> params ){
//		
//	}
	@GetMapping(value="/test")
	public ModelAndView mybatisTest(@RequestParam Map<String, Object>hMap) {
		//public ModelAndView mybatisTest(String cName , Integer search) { 두개 이상 파라메터 값 가져오
		// requestparam 없으면 데이터를 못 받음 (Map의 경우) 
		System.out.println("cName="+hMap.get("cName"));
		System.out.println("search="+hMap.get("search"));
		System.out.println("search="+hMap.toString());
		mav=bs.mybatisTest(hMap);
		return mav;
	}
	@GetMapping(value="/classHome")
	public ModelAndView selectClassHome(String cl_idnum) {
		//강의 일련번호로 classInfo view 출력해서 해당 강의로 이동 
		mav=bs.selectClassHomePage(cl_idnum);
		
		return mav;
	}
	@GetMapping(value="/selectClassLectureVideoPage")
	public ModelAndView selectClassLectureVideoPage(String co_idnum, int co_num) {
		//강의 일련번호로 classInfo view 출력해서 해당 강의로 이동 
		mav=bs.selectClassLectureVideoPage(co_idnum, co_num);
		
		return mav;
	}
}
