package com.dons.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.dons.board.bean.BoardBean;
import com.dons.board.bean.CourseBean;
import com.dons.board.bean.MemberBean;
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

	List<BoardBean> classHomeTest(int board_num);

	@Select("SELECT * FROM board WHERE board_num=#{board_num}")
	List<BoardBean> classLecture(BoardBean bb);
	@Select("SELECT * FROM co WHERE co_idnum = #{co_idnum}")
	List<CourseBean> selectCourseList(CourseBean cb);



}