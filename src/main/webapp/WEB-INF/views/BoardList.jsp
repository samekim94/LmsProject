<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#table{
text-align:center;
border:1px solid black;
}
#center {
	width: 500px;
	height: 300px;
	border: 1px solid black;
	text-align: center;
	margin: auto;
	margin-top: 150px;
	overflow: auto;
}
html, body {
   height: 100%;
   margin: 0
}

#articleView_layer {
   display: none;
   position: fixed;
   position: absolute;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%
}

#articleView_layer.open {
   display: block;
   color: red;
}

#articleView_layer #bg_layer {
   position: absolute;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%;
   background: #000;
   opacity: .5;
   filter: alpha(opacity = 50);
   z-index: 100
}

#contents_layer {
   position: absolute;
   top: 40%;
   left: 40%;
   width: 800px;
   height: 800px;
   margin: -150px 0 0 -194px;
   padding: 28px 28px 0 28px;
   border: 2px solid #555;
   background: #fff;
   font-size: 12px;
   z-index: 200;
   color: #767676;
   line-height: normal;
   white-space: normal;
   overflow: scroll
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="resources/js/jquery.serializeObject.js"></script>
</head>
<body>
<script>
var bList = ${bList2};
$(document).ready(function(){
	for(var i=0; i<bList.length; i++){
	$('tbody').append("<tr>");	
	$('tbody').append("<td align='center'>"+bList[i].board_num+"</td>");	
	$('tbody').append("<td align='center'>"+bList[i].board_id+"</td>");	
	$('tbody').append("<td align='center'><a href='#' onclick='articleView("+bList[i].board_num+
			")'>"+bList[i].board_subject+"</a></td>");	
	$('tbody').append("<td align='center'>"+bList[i].board_date+"</td>");	
	$('tbody').append("<td align='center'>"+bList[i].board_views+"</td>");	
	$('tbody').append("</tr>");
	}
	var result = '${ggg}';
	if(result===''){
		return;
	}else if(parseInt(result)>0){
		alert('${ggg}'+"번 글을 삭제함");
	}
}); 
/* $(document).ready(function(){
	var i=1;
	bList = ${bList2};
	console.log(bList.length);
	while(true){
		if(bList !=null){
			$('#pageNum2').append("<a href='boardList?pageNum="+i+"'>"+i+"</a>");
		}
		if(bList.length != 10){
			break;
		}
		i++;
	}//while
});//func */
</script>

<!-- body 시작임   -->
<c:if test="${!empty id}">
	<div align='right'>
	<form action='logout' id='logout' method='post'>
		${id}님 환영합니다.
		<a href='javascript:logout()'>로그아웃</a>
	</form>
	<form action='goWriteBoard'>
	<button>글쓰기</button>
	</form>
	</div>
</c:if>

<div id = 'center'>
<h3>게시판</h3>
<table id= 'table'>
	<thead>
	<tr>
	<td align='center'>게시글번호</td>
	<td align='center'>작성자</td>
	<td align='center'>제목</td>
	<td align='center'>작성날짜</td>
	<td align='center'>조회수</td>
	</tr>
	</thead>
	<tbody>
	</tbody>
	
</table>
<!-- 페이징 -->
<div id='pageNum'>${paging}</div>
</div >
<div id='pageNum2'></div>
<!-- 모달박스 -->
<div id='articleView_layer'>
<div id='bg_layer'></div>
<div id='contents_layer'></div>
</div>
<form action="test">
컬럼명: <input type='text' name='cName'><br>
검색: <input type='text' name='search'><br>
<button>검색</button>
</form>
</body>
<script>
function logout(){
	$('#logout').submit();
};
function articleView(num){
	$('#articleView_layer').addClass('open'); //modal show
	$.ajax({
		type:'get',
		url:'contents',
		data:{bNum:num},
		dataType:'html', //생략가능 
		
		success:function(data){
			$('#contents_layer').html(data);
		},
		error:function(err){
			console.log(err);
		}
	});
};
var $layerWindow=$('#articleView_layer'); //modal close 
$layerWindow.find('#bg_layer').on('mousedown',function(evt){
		console.log(evt);
		$layerWindow.removeClass('open');
});
$(document).keydown(function(evt){
	if(evt.keyCode !=27) return;
	else if ($layerWindow.hasClass('open')){
		$layerWindow.removeClass('open');
	}
}); //esc로 팝업창 닫기
</script>
</html>