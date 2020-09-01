package com.dons.board.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.dons.board.bean.MemberBean;

public class MemberDao {
	
	private SqlSessionTemplate tpl;
	
	
	public boolean getLoginResult(MemberBean mb) {
		return tpl.selectOne("memberMapper.getLoginResult", mb);
	}
}
