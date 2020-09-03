package com.dons.board.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Alias("class")
@Accessors(chain=true)
public class ClassBean {
private String cl_idnum;
private int cl_lv;
private String cl_clName;
private String cl_id;
private String cl_fnDay;//
private String cl_stDay;// date로 반환해줘야함
private Integer cl_pt; //point
private Integer cl_lcnum; // 강수 
private String cl_cc; // 관심사

private String pi_pisysname;
private String mb_name; // view로 인해 추가 
}
