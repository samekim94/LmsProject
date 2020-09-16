package com.dons.board.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.dons.board.bean.BoardBean;
import com.dons.board.bean.ClassBean;
import com.dons.board.bean.CourseBean;
import com.dons.board.bean.CourseBoardBean;
import com.dons.board.bean.MemoBean;
import com.dons.board.bean.ReplyBean;
import com.dons.board.bean.SampleValueObject;
import com.dons.board.bean.ScheduleBean;
import com.dons.board.service.BoardService;
import com.google.gson.Gson;

//@RequestMapping(value="/rest") 매핑에서 공통된 경로를 생략함, 브라우저 마다 되는게 있고 안되느게 있음, get, post방식도 방식마다 다 다름 
@RestController // restcontroller로 선언해서 responsebody를 안 해줘도, 알아서 ajax success로 반환함 
public class BoardRestController {
	@Autowired
	private BoardService bs;
	
	//@ResponseBody 
//	@PostMapping(value="/rest/replyInsertion")
//	public 	String insertBoardReply(ReplyBean reply, HttpSession session) {
//		// responseBody란? 일단 댕충 적음 gson json생략가능 그리고 json객체로 보내줌 ;
//		reply.setReply_id(session.getAttribute("id").toString());
//		System.out.println("reply_id="+reply.getReply_id());
//		System.out.println("reply_contents="+reply.getReply_contents());
//		System.out.println("reply_boardNum="+reply.getReply_boardNum());
//		String json = bs.replyInsertion(reply); // id + boardNum, contents
//		
//		return json; //내장에 등록된 잭슨을 통해 자동으로 json으로 넘어감    
//					 //jackson: 속도가 빠름, 가장 많이 사용 
//					 //역할: Map >> json으로 변환 	
//	}
	@PostMapping(value="/rest/replyInsertion")
	public Map <String, List<ReplyBean>> insertBoardReply(ReplyBean reply, HttpSession session){
		reply.setReply_id(session.getAttribute("id").toString());
		Map<String, List<ReplyBean>> rMap = bs.replyInsertion(reply);
		
		return rMap;
	}
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	@PostMapping(value="/rest/selectScheduleAjax")
	public  List<ScheduleBean> SelectSchedule(ScheduleBean sb, HttpSession session) {
		List<ScheduleBean> sList = bs.selectSchedule(sb, session);
		return sList;
	}
	@PostMapping(value="/rest/insertScheduleAjax")
	public List<ScheduleBean> InsertSchedule(ScheduleBean sb, HttpSession session){
		 List<ScheduleBean> sList = bs.insertSchedule(sb, session);
		 return sList;
	}
	@PostMapping(value="/rest/deleteScheduleAjax")
	public  List<ScheduleBean> deleteSchedule(ScheduleBean sb, HttpSession session) {
		List<ScheduleBean> sList = bs.deleteSchedule(sb, session);
		return sList;
	}
	@PostMapping(value="/rest/selectCourseListAjax")
	public  List<CourseBean> selectCourseList(CourseBean cb) {
		List<CourseBean> cList = bs.selectCourseList(cb);
		return cList;
	}
	@PostMapping(value="/rest/classLectureAjax")
	public List<CourseBean> classLecture(ClassBean cb){
		List<CourseBean> cList = bs.classLecture(cb);
		return cList;
	}
	@PostMapping(value="/rest/selectMemoForStart")
	public List<MemoBean> selectMemoForStart(MemoBean mb){
		List<MemoBean> mList = bs.selectMemoForStart(mb);
			return mList;			
		
	}
	@PostMapping(value="/rest/insertMemoAjax")
	public List<MemoBean> insertMemo(MemoBean mb){
		List<MemoBean> mList = bs.insertMemo(mb);
		return mList;
	}
	@PostMapping(value="/rest/selectClassNoticeAjax")
	public List<CourseBoardBean> selectClassNotice(CourseBoardBean CNB){
		List<CourseBoardBean> CNBList = bs.selectClassNotice(CNB);
		return CNBList;
	}
	@PostMapping(value="/rest/selectClassQNA")
	public List<CourseBoardBean> selectClassQNA(CourseBoardBean QNA){
		List<CourseBoardBean> QNAList = bs.selectClassQNA(QNA);
		
		return QNAList;
	}
	@PostMapping(value="/rest/insertMyClassQnaAjax")
	public List<CourseBoardBean> insertMyClassQNA(CourseBoardBean QNA) {
		List<CourseBoardBean> QNAList = bs.insertMyClassQNA(QNA);
		return QNAList;
	}
	////////////////////////////////////////////////////
	@PostMapping(value="/rest/boardWrite")
	public String boardWrite(MultipartHttpServletRequest multi){
		System.out.println("subject="+multi.getParameter("board_subject"));
		System.out.println("filecheck="+multi.getParameter("fileCheck"));
		List<MultipartFile> files = multi.getFiles("files");
		System.out.println("files="+files.get(0));
		System.out.println("files="+files.get(1).getOriginalFilename());
		return new Gson().toJson(files);
	}
	@GetMapping(value="/rest/getSample")
	public SampleValueObject getSample() {
		
	return new SampleValueObject(112,"김","동일");
	}
	@GetMapping(value="/rest/check")
	public ResponseEntity<SampleValueObject> check(double h,double w) {
		SampleValueObject vo = new SampleValueObject(0,""+h,""+w );
		ResponseEntity<SampleValueObject> result = null;
		if (h<150) {
			result=ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
		}else {
			//result=ResponseEntity.status(HttpStatus.OK).body(vo);
			result = ResponseEntity.ok(vo);
		}
		return result;
	}
}//classEnd
