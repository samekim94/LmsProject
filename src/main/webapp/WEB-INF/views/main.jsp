<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#center{
width:500px;
height:300px;
border:1px solid black;
text-align:center;
margin:auto;
margin-top: 150px;	
}
</style>
</head>
<body>
<div id='center'><br><br>
<h2>main.jsp</h2>
${msg}<br><br>
${session_login_id}님 안녕하세요. <br>
<input type='button' id='myInfo' value='내정보 보기' onclick=myInfo()>
<form action='logout' method='get'>
<button>로그아웃</button>
</form>
<div id='myinfo'></div>
${mb.member_id}<br>
${mb.member_name}<br>
${mb.grade_name}
</div>
<input >
</body>
<script>
var id= ${mb.member_id};

function myInfo(){
	myInfo("myInfo","#myInfo");
}
$.ajax(url, position){
	url: url,
	data: id ,
	dataType: json,
	
	success:function(json){
		console.log(json)
	}, 
	error:function(err){
		console.log(err)
	}
}
</script>
</html>