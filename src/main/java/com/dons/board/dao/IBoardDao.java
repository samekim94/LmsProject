package com.dons.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.dons.board.bean.BoardBean;
import com.dons.board.bean.ClassBean;
import com.dons.board.bean.CourseBean;
import com.dons.board.bean.CourseBoardBean;
import com.dons.board.bean.FileBean;
import com.dons.board.bean.MemberBean;
import com.dons.board.bean.MemoBean;
import com.dons.board.bean.ProblemBean;
import com.dons.board.bean.ReplyBean;
import com.dons.board.bean.ScheduleBean;
import com.dons.board.bean.boardFileEntity;

public interface IBoardDao {
	List <BoardBean> getBoardList (int pageNum);

	BoardBean getContents(Integer bNum);

	boolean replyInsertion(ReplyBean reply);

	List<ReplyBean> getReplyList(int reply_boardNum);

	int getBoardCount();
	
	@Delete("DELETE FROM reply WHERE reply_boardNum=#{boardNum}")
	boolean deleteReply(Integer boardNum);
	@Delete("DELETE FROM board WHERE board_Num=#{boardNum}")
	boolean deleteBoard(Integer boardNum);
	@Delete("DELETE FROM boardfile WHERE boardfile_boardNum=#{boardNum}")
	boolean deleteBoardfile(Integer boardNum);

	boolean writeBoardInsertion(BoardBean boardBean);
	@Insert("INSERT INTO boardfile VALUES (boardfile_seq.NEXTVAL,#{bnum},#{oriFileName},#{sysFileName})")
	boolean fileInsert(Map<String, String> fMap);
	@Select("SELECT * FROM boardfile WHERE boardfile_boardNum = #{boardNum}")
	List<boardFileEntity> deleteBoardfileSelect(Integer boardNum);
	
	
	

	//List<MemberBean> mybatisTest(@Param("cName")String cName, @Param("point") Integer search);
	List<MemberBean> mybatisTest(Map<String, Object> hMap);

	
	//scheduel select, delete, insert 
	List<ScheduleBean> selectSchedule(ScheduleBean sb);

	boolean insertSchedule(ScheduleBean cb);

	boolean deleteSchedule(ScheduleBean cb);
	
	//classHome 들어왔을 때 
	List<ClassBean> selectClassHome(String cl_idnum);
	
	@Select("SELECT * FROM co WHERE co_idnum = #{co_idnum}")
	List<CourseBean> selectCourseList(CourseBean cb);
	@Select("SELECT ROUND(AVG(gpa_gpa),1) FROM gpa WHERE gpa_idnum = #{cl_idnum}")
	double selectClassAvgNum(String cl_idnum);
	
	//강의목록 들어갔을 때, 출석값, course 출력위해 
	@Select("SELECT * FROM courseAttend WHERE co_idnum=#{co_idnum} AND aa_id = #{aa_id}")
	List<CourseBean> classLecture(CourseBean cob);
	
	//classLecture video 재생하기 위해 
	@Select("SELECT * FROM classFileName WHERE fl_idnum=#{fl_idnum} AND fl_num=#{fl_num} AND fl_id=#{fl_id}")
	List<FileBean> selectLectureVideoPage(FileBean fl);
	
	//classLecture memo insert, update, select 
	@Insert("INSERT INTO memo values(#{mo_idnum},#{mo_lv},#{mo_num},#{mo_id},#{mo_contents})")
	boolean insertMemo(MemoBean mb);
	@Select("SELECT * FROM memo WHERE mo_idnum=#{mo_idnum} AND mo_num=#{mo_num} AND mo_id=#{mo_id}")
	List<MemoBean> selectMemo(MemoBean mb);
	@Update("UPDATE memo SET mo_contents = #{mo_contents} where mo_idnum=#{mo_idnum} AND mo_num=#{mo_num} AND mo_id = #{mo_id}")
	boolean updateMemo(MemoBean mb);
	
	//previewQui 게시글 랜덤으로 출력해서 가져가기 위해 
	@Select("SELECT * FROM course WHERE co_idnum = #{cl_idnum}")
	List<CourseBean> selectCourseNum(String cl_idnum);
	@Select("SELECT * FROM problem WHERE pb_idnum=#{pb_idnum} AND pb_num = #{pb_num}")
	List<ProblemBean> selectProblemNum(ProblemBean pb);
	@Select("SELECT * FROM problemView WHERE pb_idnum = #{pb_idnum} AND pb_num = #{pb_num} AND pb_pbnum = #{pb_pbnum}")
	List<ProblemBean> selectPreviewQuiz(ProblemBean pb);
	
	//공지사항 게시판 들어갔을 때 게시글 출력 위해
	@Select("SELECT * FROM courseBoardKind WHERE cob_idnum=#{cob_idnum} AND cob_kind=#{cob_kind}")
	List<CourseBoardBean> selectClassNotice(CourseBoardBean cNB);
	
	//Q&A게시판 들어갔을 때, 게시글 출력 위해
	@Select("SELECT * FROM courseBoardKind WHERE cob_idnum=#{cob_idnum} AND cob_kind=#{cob_kind} AND cob_id = #{cob_id}")
	List<CourseBoardBean> selectClassQNA(CourseBoardBean QNA);
	
	//Q&A 게시글 insert 위한
	boolean insertMyClassQna(CourseBoardBean QNA);
	
	//detail page 갔을 때, 게시글, 댓글 출력 위한 
	@Select("SELECT COUNT(*) FROM courseReplyView WHERE cob_idnum = #{cob_idnum} AND cob_bonum = #{cob_bonum} AND cob_kind = #{cob_kind}")
	int selectDetailViewReplyCount(CourseBoardBean PK);
	@Select("SELECT * FROM courseReplyView WHERE cob_idnum = #{cob_idnum} AND cob_kind = #{cob_kind} AND cob_bonum = #{cob_bonum}")
	List<CourseBoardBean> selectClassDetailViewReply(CourseBoardBean PK);
	@Select("SELECT * FROM courseBoardKind WHERE cob_idnum=#{cob_idnum} AND cob_kind=#{cob_kind} AND cob_bonum=#{cob_bonum}")
	List<CourseBoardBean> selectClassDetailView(CourseBoardBean PK);
	
	//classQnaDetail reply insert 
	@Select("SELECT cob_idnum, cob_num, cob_bonum FROM cob WHERE cob_bonum = #{cob_bonum}")
	CourseBoardBean selectReplyNumInfo(CourseBoardBean QR);
	@Insert("INSERT INTO cr VALUES(#{cob_idnum}, #{cob_num}, #{cob_id}, #{cob_bonum}, #{cr_reply}, default)")
	boolean insertQnaReply(CourseBoardBean qR);
	
	//classReview page 갔을 때, 강의 후기 값 출력하기 위해 
	@Select("SELECT * FROM cobKindAndGpa WHERE cob_idnum=#{cob_idnum} AND cob_kind=#{cob_kind}")
	List<CourseBoardBean> selectClassReview(CourseBoardBean review);

	//classReview view page 가기전 평균값 구하기 
	@Select("SELECT count(*) FROM gpa WHERE gpa_idnum=#{cob_idnum} AND gpa_id=#{cob_id}")
	int selectGpaCount(CourseBoardBean review);
	@Select("SELECT count(*) FROM co WHERE co_idnum=#{cob_idnum}")
	int selectCourseCount(CourseBoardBean review);
	@Select("SELECT count(*) FROM AA WHERE aa_idnum=#{cob_idnum} AND aa_id=#{cob_id}")
	int selectClassAdmi(CourseBoardBean review);
	@Select("SELECT ROUND(AVG(gpa_gpa),1) FROM gpa WHERE gpa_idnum=#{cob_idnum} AND gpa_id=#{cob_id}")
	double selectMyClassAvg(CourseBoardBean review);
	
	//classReview 작성 insert 
	@Select("SELECT COUNT(*) FROM gpa WHERE gpa_idnum=#{cob_idnum} AND gpa_id=#{cob_id} AND gpa_num=#{cob_num}")
	int selectClassReviewCnt(CourseBoardBean review);
	@Insert("INSERT INTO cob VALUES(#{cob_idnum}, #{cob_lv}, #{cob_num},#{cob_id}, #{cob_bonum}||LPAD(CR_seq.NEXTVAL,5,0), #{cob_title}, #{cob_cont}, default, #{cob_kind})")
	boolean insertClassReviewBoard(CourseBoardBean review);
	@Insert("INSERT INTO gpa VALUES(#{cob_num}, #{cob_idnum}, #{cob_lv}, #{cob_id}, #{gpa_gpa})")
	boolean insertClassReviewGpa(CourseBoardBean review);
	@Select("SELECT cob_bonum FROM cobKindAndGpa WHERE cob_idnum=#{cob_idnum} AND cob_id=#{cob_id}")
	String selectClassReviewBoardNum(CourseBoardBean review);


	//classReviewDetail 게시글, 댓글 출력


}
