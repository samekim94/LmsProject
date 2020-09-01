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
<h1>restClient</h1>
</body>
<script>
$.ajax({
	//url: 'rest/getSample' ,
	url:'rest/check?h=160&w=100',
	method: 'get', //type:put 은 안되는 경우가 있음  method: 'delete' 'patch' 'put' >>method:'post',data:{_method:"put"} <<fm
	//method:'post',
	//data:{}
	dataType: 'json',
	success:function(data, qqq, www){
		console.log(data);
		console.log(qqq);
		console.log(www);
	}, 
	error:function(err){
		console.log(err);
	}
});
</script>
</html>