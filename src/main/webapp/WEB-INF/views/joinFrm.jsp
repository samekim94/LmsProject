<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#center {
	width: 500px;
	height: 300px;
	border: 1px solid black;
	text-align: center;
	margin: auto;
	margin-top: 150px;
}
</style>
</head>
<body>
	<div id='center'>
		<br>
		<br>
		<form action='joinFrmInsert' method='post'>
			<h2>joinFrm.jsp</h2>
			<br>
			<table style='margin:auto; text-align:center;'>
				<tr>
					<td>ID</td>
					<td><input type='text' name='member_id'
						placeholder='아이디를 입력해주세요.'></td>
				</tr>
				<tr>
					<td>PW</td>
					<td><input type='password' name='member_pw'
						placeholder='비밀번호를 입력해주세요.'></td>
				</tr>
				<tr>
				<td>NAME</td>
				<td>
			<input type='text' name='member_name' placeholder='이름을 입력해주세요.'><br>
				</td>
				</tr>
				<tr>
				<td colspan='2'>
			<button>회원가입하기</button>
			<input type="reset" value='다시작성'>
				</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>