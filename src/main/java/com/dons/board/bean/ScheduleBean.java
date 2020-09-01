package com.dons.board.bean;


import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;
@Data
@Alias("schedule")
@Accessors(chain = true)
public class ScheduleBean {
	private String Sc_year;
	private String Sc_month;
	private String Sc_date;
	private Integer Sc_num; // 강의 회차
	private String Sc_id;
	private String Sc_idnum; // 강의 일련번호
	private Integer Sc_lv; 
	private String Sc_contents;
	private String Cl_clName; // viewPage clsc 
	private String Co_name;//회차 이름
}
