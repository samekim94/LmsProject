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
import com.dons.board.bean.FileBean;
import com.dons.board.bean.MemberBean;
import com.dons.board.bean.MemoBean;
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

	
	List<ScheduleBean> selectSchedule(ScheduleBean sb);

	boolean insertSchedule(ScheduleBean cb);

	boolean deleteSchedule(ScheduleBean cb);

	List<ClassBean> selectClassHome(String cl_idnum);

	
	@Select("SELECT * FROM co WHERE co_idnum = #{co_idnum}")
	List<CourseBean> selectCourseList(CourseBean cb);
	
	@Select("SELECT ROUND(AVG(gpa_gpa),1) FROM gpa WHERE gpa_idnum = #{cl_idnum}")
	double selectClassAvgNum(String cl_idnum);
	
	@Select("SELECT * FROM courseAttend WHERE co_idnum=#{co_idnum} AND aa_id = #{aa_id}")
	List<CourseBean> classLecture(CourseBean cob);
	
	@Select("SELECT * FROM classFileName WHERE fl_idnum=#{fl_idnum} AND fl_num=#{fl_num} AND fl_id=#{fl_id}")
	List<FileBean> selectLectureVideoPage(FileBean fl);
	@Insert("INSERT INTO memo values(#{mo_idnum},#{mo_lv},#{mo_num},#{mo_id},#{mo_contents})")
	boolean insertMemo(MemoBean mb);
	@Select("SELECT * FROM memo WHERE mo_idnum=#{mo_idnum} AND mo_num=#{mo_num} AND mo_id=#{mo_id}")
	List<MemoBean> selectMemo(MemoBean mb);
	@Update("UPDATE memo SET mo_contents = #{mo_contents} where mo_idnum=#{mo_idnum} AND mo_num=#{mo_num} AND mo_id = #{mo_id}")
	boolean updateMemo(MemoBean mb);



}
