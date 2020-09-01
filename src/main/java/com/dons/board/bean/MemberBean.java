package com.dons.board.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;
@Alias("member")
@Data
@Accessors(chain=true)
public class MemberBean {
	private String member_id;
	private String member_pw;
	private String member_name;
	private String member_birth;
	private String member_addr;
	private String member_phone;
	private int member_point;
	private String grade_name;

}
