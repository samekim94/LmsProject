package com.dons.board.bean;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.gson.annotations.JsonAdapter;

import lombok.Data;
import lombok.experimental.Accessors;
@Accessors(chain=true)
@Alias("reply")
@Data
public class ReplyBean {

		private int reply_boardNum; //게시글 번호 
		private int reply_num; // 댓글 pk 
		private String reply_contents;// 댓글 내용 
		@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss") //jackson 사용 
		private Timestamp reply_date; // 댓글 작성 시간 
		private String reply_id; // 댓글 작성자 
}
// 메세지 컨버터 (jackson): 서버에서 클라이언트로 데이터를 변환해서 보내준다. 
// jackson, timestamp 둘이 호환되지 않음 그래서 내장 잭슨 말고 잭슨을 다운 받아서 넣어줘야