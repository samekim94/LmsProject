<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
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
<script>
window.onload=function(){
	var check='${check}';
	if(check==1){
	alert("joinFrm success");	
	}else if(check==2){
		alert("login fail");
	}
}
</script>
</head>
<body>
<div id='center'><br><br>
<h2>home.jsp-로그인페이지.</h2><br>

<form action='access' name='loginFrm' method='post'>
ID:<input type='text' name='member_id' placeholder='아이디를 입력해주세요.'><br>
PW:<input type='password' name='member_pw' placeholder='비밀번호를 입력해주세요.'><br><br><br>
${msg}<br>
<button>로그인</button>
<a href='joinFrm'>회원가입</a>
</form>
</div>
</body>
</html>