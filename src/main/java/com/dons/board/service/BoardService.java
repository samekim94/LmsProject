package com.dons.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dons.board.Exception.DbException;
import com.dons.board.bean.BoardBean;
import com.dons.board.bean.CourseBean;
import com.dons.board.bean.MemberBean;
import com.dons.board.bean.ReplyBean;
import com.dons.board.bean.ScheduleBean;
import com.dons.board.bean.boardFileEntity;
import com.dons.board.dao.IBoardDao;
import com.dons.board.userClass.FileManager;
import com.dons.board.userClass.Paging;
import com.google.gson.Gson;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service // @Service라고 써도 됨
public class BoardService {
	@Autowired
	private IBoardDao bDao;
	@Autowired
	private FileManager fm;
	ModelAndView mav;

	public ModelAndView getBoardList(Integer pageNum) {

		log.info("pageNum=" + pageNum);
		mav = new ModelAndView();
		List<BoardBean> bList = null;
		pageNum = (pageNum == null) ? 1 : pageNum;
		// intersepter
		bList = bDao.getBoardList(pageNum);
		if (bList != null && bList.size() != 0) {
			mav.addObject("bList2", new Gson().toJson(bList)); // jstl로 까는방법임
			mav.addObject("bList", bList);
			mav.addObject("paging", getPageing(pageNum));
			mav.setViewName("BoardList");

		}
		return mav;
	}

	public ModelAndView getContents(Integer bNum) {
		mav = new ModelAndView();
		String view = null;
		// 인터셉터 있어서 세션검사 생략
		BoardBean bb = bDao.getContents(bNum);
		mav.addObject("board", bb);
		mav.addObject("GsonBoard", new Gson().toJson(bb));
		// 댓글은 밥 먹고 나서
		view = "boardContentsAjax";
		mav.setViewName(view);
		return mav;
	}

//	public String replyInsertion(ReplyBean reply) {
//		String json = null;
//		List<ReplyBean> rList = null;
//		if (reply.getReply_contents() != "") {
//			if (bDao.replyInsertion(reply)) {
//				rList = bDao.getReplyList(reply.getReply_boardNum());
//				json = new Gson().toJson(rList);
//			} else {
//				json = "fail";
//			}
//		} else {
//			rList = bDao.getReplyList(reply.getReply_boardNum());
//			json = new Gson().toJson(rList);
//		}
//		System.out.println("json=" + json);
//		return json;
//	}
	public Map<String, List<ReplyBean>> replyInsertion(ReplyBean reply) {

		Map<String, List<ReplyBean>> rMap = null;
		if (reply.getReply_contents() != "") {
			if (bDao.replyInsertion(reply)) {
				List<ReplyBean> rList = bDao.getReplyList(reply.getReply_boardNum());
				rMap = new HashMap<>();
				rMap.put("rList", rList);
				System.out.println("rMap=" + rMap);
			} else {
				rMap = null;
			}
		} else {
			List<ReplyBean> rList = bDao.getReplyList(reply.getReply_boardNum());
			rMap = new HashMap<>();
			rMap.put("rList", rList);
		}
		System.out.println("rMap=" + rMap);
		return rMap;
	}

	private String getPageing(Integer pageNum) {
		int maxNum = bDao.getBoardCount();
		int listCount = 10; // 페이지당 글의 개수
		int pageCount = 2; // 그룹당 페이지 개수
		String boardName = "boardList"; // url
		Paging paging = new Paging(maxNum, pageNum, listCount, pageCount, boardName);

		return paging.makeHtmlPaging();
	}

	@Transactional // 작업을 다 성공하면 커밋, 실패하면 롤백
	public ModelAndView deleteBoard(Integer boardNum, RedirectAttributes attr) {
		mav = new ModelAndView();
		fm = new FileManager();
		List<boardFileEntity> bfList = null;
		bfList = bDao.deleteBoardfileSelect(boardNum);

		boolean drResult = bDao.deleteReply(boardNum); // 선댓글 삭제
		System.out.println("deleteReply t/f=" + drResult);
		boolean dbfResult = bDao.deleteBoardfile(boardNum);
		System.out.println("deleteBoardfile t/f=" + dbfResult);
		boolean dbResult = bDao.deleteBoard(boardNum);// 후 게시글 삭제
		System.out.println("deleteBoard t/f=" + dbResult);
		if (dbfResult) {
			fm.delete(bfList);
		}
		if (dbResult == false) { // 게시글 삭제가 안 됐다면? 다시 롤백
			throw new DbException();
		}
		if (dbResult) {
			attr.addFlashAttribute("ggg", boardNum);
			System.out.println("delete commit success");
		}
		mav.setViewName("redirect:/boardList");
		return mav;
	}

	public ModelAndView writeBoardInsertion(MultipartHttpServletRequest multi) {
		// multipartfile도 확인
		mav = new ModelAndView();
		String view = null;
		String subject = multi.getParameter("board_subject");
		String contents = multi.getParameter("board_contents");
		String id = multi.getSession().getAttribute("id").toString();
		int fileCheck = Integer.parseInt(multi.getParameter("fileCheck"));
		BoardBean boardBean = new BoardBean();
		boardBean.setBoard_subject(subject).setBoard_contents(contents).setBoard_id(id);

		boolean boardInsertResult = bDao.writeBoardInsertion(boardBean);
		System.out.println("select한 board_num=" + boardBean.getBoard_num());
		if (boardInsertResult) {
			view = "redirect:/boardList";
		} else {
			view = "goWriteBoard";
		}
		boolean f = false;
		if (fileCheck == 1) {
			f = fm.fileUp(multi, boardBean.getBoard_num());
			if (f) {
				System.out.println("fileup success");
				view = "redirect:/boardList";
			} else {
				view = "goWriteBoard";
			}
		}
		mav.setViewName(view);
		return mav;
	}

	public void downloadFile(Map<String, Object> params) throws Exception {
		String oriFileName = (String) params.get("origFileName");
		String sysFileName = (String) params.get("sysFileName");
		String root = (String) params.get("root");
		String fullPath = root + "/upload/" + sysFileName;

		System.out.println("fullPath=" + fullPath);
		System.out.println("sysFile=" + sysFileName);
		System.out.println("oriFile=" + oriFileName);
		HttpServletResponse response = (HttpServletResponse) params.get("response");
		fm.download(fullPath, oriFileName, response); // 다운로드할 path 이름 응답 셋
	}

//	public ModelAndView mybatisTest(String cName, Integer search) {
//		List<MemberBean> list = bDao.mybatisTest(cName, search);
//		mav.addObject("list", list);
//		mav.setViewName("test");
//		return null;
//	}

	public ModelAndView mybatisTest(Map<String, Object> hMap) {
		List<MemberBean> list = bDao.mybatisTest(hMap);
		mav.setViewName("test");
		return mav;
	}

	public List<ScheduleBean> selectSchedule(ScheduleBean sb, HttpSession session) {
		// sb.setSc_id(session.getAttribute("id").toString());
		sb.setSc_id("dons");
		System.out.println(sb.getSc_id());
		System.out.println(sb.getSc_year());
		System.out.println(sb.getSc_month());
		System.out.println(sb.getSc_date());
		List<ScheduleBean> sList = bDao.selectSchedule(sb);
		if(sList!=null) {
			return sList;			
		} else {			
			return null;
		}
	}

	public List<ScheduleBean> insertSchedule(ScheduleBean sb, HttpSession session) {
		// sb.setSc_id(session.getAttribute("id").toString());
		sb.setSc_id("dons");
		List<ScheduleBean> sList = null;
		if (bDao.insertSchedule(sb)) { // insert가 된 경우
			sList = bDao.selectSchedule(sb); // 년 월 일 필요
			System.out.println("달력 insert 성공 후 select까지 성공");
		} else {
			sList = bDao.selectSchedule(sb);
			System.out.println("달력 insert 실패 후 select는 성공");
		}

		return sList;
	}

	public List<ScheduleBean> deleteSchedule(ScheduleBean sb, HttpSession session) {
		// sb.setSc_id(session.getAttribute("id").toString());
		sb.setSc_id("dons");
		List<ScheduleBean> sList = null;
		if (bDao.deleteSchedule(sb)) {
			sList = bDao.selectSchedule(sb);
			System.out.println("calendar delete success after select calendar");
		} else {
			sList = bDao.selectSchedule(sb);
			System.out.println("calendar delete fail after select calendar");
		}
		return sList;
	}

	public ModelAndView classHomeTest() {
		List<BoardBean> bList;
		int board_num = 13;
		bList = bDao.classHomeTest(board_num);
		System.out.println(bList);

		String view = "ClassHome";
		mav.addObject("test", new Gson().toJson(bList));
		mav.setViewName(view);
		return mav;
	}

	public List<BoardBean> classLecture(BoardBean bb) {
		System.out.println(bb);
		List<BoardBean> cList = bDao.classLecture(bb);
		System.out.println(cList);
		return cList;
	}

	public List<CourseBean> selectCourseList(CourseBean cb) {
		List<CourseBean> cList; 
		cList = bDao.selectCourseList(cb);
		if(cList !=null) {
			return cList;
		}
		return null;
	}

	

}
