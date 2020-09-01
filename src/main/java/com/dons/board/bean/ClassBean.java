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
private int cl_pt; //point
private String cl_cc; // 관심사
}
