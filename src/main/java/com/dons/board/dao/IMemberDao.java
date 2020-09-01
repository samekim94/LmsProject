package com.dons.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.dons.board.bean.AdmiApplicationBean;
import com.dons.board.bean.ClassBean;
import com.dons.board.bean.MemberBean;
import com.dons.board.bean.ScheduleBean;

public interface IMemberDao {
	public boolean getLoginResult(MemberBean mb); // 로그인용 이전 

	public boolean joinFrmInsert(MemberBean mb); //회원가입용 

	public String getSecurityPw(String member_id); //비밀번호 확인용 

	public MemberBean getMemberInfo(String member_id); //개인정보 출력용 

	@Select("SELECT * FROM aaCl WHERE aa_id = #{aa_id}")
	public List<AdmiApplicationBean> selectMyCalendar(AdmiApplicationBean ab);
	



	
}
