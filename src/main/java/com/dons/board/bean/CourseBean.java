package com.dons.board.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Alias("course")
@Accessors(chain=true)
public class CourseBean {
private int co_num; // 회차번
private int co_lv;
private String co_name;
private String co_idnum;

private Integer atd_atmk;
private String aa_id;
}
