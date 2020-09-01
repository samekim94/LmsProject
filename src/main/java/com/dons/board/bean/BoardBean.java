package com.dons.board.bean;

import java.sql.Timestamp;
import java.util.List;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Alias("board")
@Accessors(chain = true)
public class BoardBean { //bList 기준 
	private int board_num;  
	private String board_subject;
	private String board_contents;
	private String board_id;
	private String member_name;
	@JsonFormat(pattern="yyyy-MM-dd HH:mm")
	private Timestamp board_date;
	private int board_views;
//	private List<String> boardfile_origname;
//	private List<String> boardfile_sysname;
	private List<boardFileEntity> bfList;
}	
