package com.dons.board.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class SampleValueObject {
//VO = 값을 저장하는 용도로 쓰는 것 value object 
//db 기준entity client DTO 88410652
private Integer mno;
private String firstName;
private String lastName;

}
