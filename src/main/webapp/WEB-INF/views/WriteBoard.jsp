<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>
<h3>글쓰기</h3>
	<form action='WriteBoard' id='frm' method='post' enctype='multipart/form-data'>
		<table border='1'>
			<tr>
				<td>제목:</td>
				<td><input type='text' name='board_subject' id='board_subject'></td>
			</tr>
			<tr>
				<td>내용:</td>
				<td><textarea row='20' cols="100" name='board_contents' id='board_contents'></textarea></td>
			</tr>
			<tr>
				<td>파일첨부:</td>
				<td>
				<input type='file' name='files' id='files' multiple>
				<input type='hidden' id='fileCheck' name='fileCheck' value='0'>
				</td>
			</tr>
			<tr>
				<td colspan='2' align='center'>
					<input type="submit" value='작성하기'>
					<input type='button' onclick="formData()" value='formData'>
					<input type='reset' value='다시작성하기'>
					<input type='button' onclick="location.href='./boardList'" value='리스트보기'>
				</td>
			</tr>
		</table>
	</form>
</body>
<script>
//formData() 객체 사용 목적 
//1.multipart/form-data 를 ajax 전송시 무조건 formData 사용해야함 (파일 업로드)
//2.ajax를 이용해 서버로 넘긴다. (restful에서 사용)
//3.formData 객체는 form의 일부데이터만 서버에 전송할 때 좋음
function formData(){
	var $obj = $('#files'); 
//	console.log($obj); //jquery 객체 but formdata는 자바객체가 필요함 
//	console.log($obj[0]); // 그래서 콘솔로 찍어보고 js객체 >> 배열로 변환 
	var obj = document.getElementById('files');
//	console.dir(obj); // 얘는 js객체 
//	console.dir($obj[0].files); // 첨부된 파일 리스트
//	console.dir($obj[0].files.length); //첨부된 파일 리스트 개수 
//	console.dir($obj[0].files[0]);
//	console.dir($obj[0].files[1]);
	//var formData = new FormData(document.getElementById("frm")); //formdata는 자바스크립트 그래서 jquery식으로 넣으면 안됨 
	//console.log(formData);
	//console.log(formData.get("board_title"));
	//console.log(formData.get("files")); //key는 name속성명 
	var formData = new FormData(); // 일단 빈속으로 만들기
	formData.append("board_subject",$("#board_subject").val());
	formData.append("board_contents",$("#board_contents").val());
	formData.append("fileCheck", $("fileCheck").val());
	var files= $obj[0].files;
	for(var i=0; i<files.length; i++){
		formData.append("files",files[i]); //맵과 달리 속성(키)값이 같아도 쌓인다
	}
	console.log(formData);	
	console.log(formData.get("board_subject"));	
	console.log(formData.getAll("files"));	
	
	$.ajax({
		url:'rest/boardWrite',
		type:'post',
		data:formData,
		processData:false,		//application/x-www-form-urlencoded(쿼리스트링 형식)
		contentType:false, //multipart의 경우 contentType을 false
		dataType:'json', //rest controller 이용 
		success:function(data){
			console.log(data);
		},
		error:function(err){
			console.log(err);
		}
	});
}
$('#files').on('change', function(){
	console.dir(this);
	console.dir(this.value);
	if(this.value==''){
		console.log("file empty");
		$('#fileCheck').val(0);
	} else{
		console.log('not file empty');
		$('#fileCheck').val(1);
	}
});
</script>
</html>