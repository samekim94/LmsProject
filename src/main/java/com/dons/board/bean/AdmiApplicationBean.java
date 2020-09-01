package com.dons.board.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Alias("admiApplication")
@Accessors(chain=true)
public class AdmiApplicationBean {
private String cl_idnum;
private int cl_lv;
private String aa_id;
private String cl_clName;
// cl + aa = aaCl view Page BeanClass
}
