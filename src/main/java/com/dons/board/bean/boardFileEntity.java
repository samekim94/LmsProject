package com.dons.board.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Alias("boardFile")
@Accessors(chain = true )
public class boardFileEntity {
	private int	boardfile_num; //pk 
	private int boardfile_boardNum; //fk
	private String boardfile_origname;
	private String boardfile_sysname;
}
