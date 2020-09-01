<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>글 상세보기</h2>
	<!-- gson으로 받아온 json으로 출력함 밑에 -->
	<div id='content'> 
	</div>
	<form name='rFrm' id='rFrm'>
		<!-- 댓글 작성 -->
		<table>
			<tr>
				<td><textarea rows="3" cols="40" name='reply_contents'
						id='reply_contents'></textarea></td>
				<td><input type='button' value='작성'
					onclick="replyInsert(${board.board_num})"></td>
			</tr>
		</table>
		<!-- 댓글 출력 -->
		<table id='rTable'>
			<thead id='thead'>
			</thead>
			<tbody id='tbody'>
			</tbody>
		</table>
	</form>
</body>
<script>
$(document).ready(function(){
	
	var json = ${GsonBoard};
	$('#content').append("게시글 번호:"+json.board_num);
	$('#content').append("<br>게시글 제목:"+json.board_subject);
	$('#content').append("<br>게시글 내용:"+json.board_contents);
	$('#content').append("<br>게시자:"+json.board_id);	
	$('#content').append("<br>게시글 날짜:"+json.board_date);
	$('#content').append("<br>조회수:"+json.board_views);
	$('#content').append("<br>게시글 삭제:"+"<a href='boardDelete?boardNum="+json.board_num+"'>삭제하기</a>");
	$('#content').append("<br>첨부된 파일:<br>");
	for (var i in json.bfList){
		$('#content').append("<a href='./download?sysfile="+json.bfList[i].boardfile_sysname+"and orifile="+
				json.bfList[i].boardfile_origname+"'>"+json.bfList[i].boardfile_origname+"</a>  ");
	}
	
}); // contents
$(document).ready(function(){
	var obj= $('#rFrm').serializeObject(); //파일태그가 없을 때 폼태그 안에있는 데이터들을 모두 js객체로 변환	
	obj.reply_boardNum=${board.board_num}; // 폼태그 누락된 데이터 넣어줌
	console.log("startObj=",obj);
	$.ajax({
		type:'post',
		url:'rest/replyInsertion',
		data: obj,  // json방식으로 보내기 json.stringfy(obj) 후 @RequestBody로 받는거 보기 
		dataType:'json',
		success:function(json){
			console.log(json);
			console.log(json.rList);
			console.log(json.rList[0]);
				$('#thead').append("<tr><td>작성자</td><td>내용</td><td>작성일</td></tr>")
				for(var i in json.rList){
					$('#tbody').append("<tr>");
					$('#tbody').append("<td>"+json.rList[i].reply_id+"</td>");
					$('#tbody').append("<td>"+json.rList[i].reply_contents+"</td>");
					$('#tbody').append("<td>"+json.rList[i].reply_date+"</td>");
					$('#tbody').append("</tr>");
				}
		},
		error:function(err){
			console.log(err);
		}
	}); //reply ajax
});//ready
function replyInsert(boardNum){
	if($('#reply_contents').val()!=""){
		$('#thead').html("");
		$('#tbody').html("");
		var obj= $('#rFrm').serializeObject(); //파일태그가 없을 때 폼태그 안에있는 데이터들을 모두 js객체로 변환	
		//var obj=$('#rFrm').serialize();
		obj.reply_boardNum=boardNum; // 폼태그 누락된 데이터 넣어줌
		 $.ajax({
			type:'post',
			url:'rest/replyInsertion',
			data: obj,
			dataType:'json',
			// 질문 두가지 
			// serialize 와 serializeObject 차이점 >> serialize는 form태그 안에 있는 값을 문자열로 나열해서 보내줌 따로 추가xx
			// serializeobject는 name값을 키로 주는지  >> name임
			success:function(json){
			console.log(json);
				$('#thead').append("<tr><td>작성자</td><td>내용</td><td>작성일</td></tr>")
				for(var i in json.rList){
					$('#tbody').append("<tr>");
					$('#tbody').append("<td>"+json.rList[i].reply_id+"</td>");
					$('#tbody').append("<td>"+json.rList[i].reply_contents+"</td>");
					$('#tbody').append("<td>"+json.rList[i].reply_date+"</td>");
					$('#tbody').append("</tr>");
				} $('#reply_contents').val(""); 
			},
			error:function(err){
				console.log(err);
			}
		});//ajax 
	}else{
		alert('댓글 내용을 입력하지 않았습니다.');
	}//if alert
	
}//func
</script>
</html>