<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ClassHome</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <style>
        .html, body{
            width:1400px;
            height:1000px;
        }
        .classMain{
            display:flex;
            margin:5px;
            border:1px solid black;
        }
        #classInfo{
            list-style: none;
            margin-top:40px;
            margin-left: 20px;
        }
        #className{
            list-style: none;
            margin-top:20px;
            margin-left: 20px;
        }
        #professorAnotherClass{
            list-style: none;
            margin-top:20px;
            margin-left:20px;
        }
        .classNav{
            margin:5px;
            border:1px solid black;
            width:1388px;
            height:65px;
            text-align: center;    
        }
        .li{
            list-style:none;
            display:inline-block;
            margin-left:20px;
            margin-top:10px;
            margin-right:20px;
        }
        .classAll{
            margin:5px;
            border:1px solid black;
            width:1388px;
            height:650px;
            text-align:center;
        }
        .classLeft{
            border:1px solid black;
            width:350px;
            height:650px;
            float: left;
        }
        .classRight{
            border:1px solid black;
            width:1034px;
            height:650px;
            float: left;
            text-align:center;
        }
        .classInfoTable{
            text-align: center;
            border-bottom:1px solid black;
            margin-left:50px;
            font-size: medium;
        }
        td{
            text-align:left;
            padding:14px;
        }
    </style>
</head>
<body>
    <div id='classMain' name='classMain' class='classMain'>
        <div id='classImg'>
        </div>
          <ul class='ul'>
            <li id='classInfo'></li>
            <li id='className'></li>
            <li id='professorAnotherClass' onclick='test()'><h5>강사의 다른 강의 list ajax</h5></li>
        </ul>
        	<input type='hidden' value='' name='cl_idnum' id='classPk' class='classPk'>
    </div>
    <div id='classNav' name='classNav' class='classNav'>
        <ul>
            <li id='classInfoAjax' class='li' onclick='classInfoAjax()'> 강의소개   </li>
            <li id='classVideoTableAjax' class='li' onclick='classLectureAjax()'> 강의목록 </li>
            <li id='classInfoBoard' class='li' onclick='test()'> 공지사항  </li>
            <li id='classQNA' class='li' onclick='test()'> Q&A </li>
            <li id='classPostscriot' class='li' onclick='test()'> 수강후기  </li>
            <li id='classReference' class='li' onclick='test()'> 자료실  </li>
        </ul>
    </div>
    <div id='classAll' name='classAll' class='classAll'>
        <div id='classLeft' name='classLeft' class="classLeft">
            <h4>강의정보</h4>
            <table class='classInfoTable' id='classInfoTable'>
            </table>
        </div>
        <div class='classRight' name='classRight' id='classRight'>
        </div>
    </div>
        
    </body>
    <script>
        //강의실 들어오자마자 강좌소개에 필요한 값 ajax 밑 div 찍어주기 위한 함수 실행 
        classInfoAjax();
    function test(){
        alert('성공');
    };
    function classInfoAjax(){ //강의소개 ajax
    	var el = ${classInfo}; //포워딩으로 보내준 Gson값 받음
    	var avg = ${avgNum};
    	var cInfo = $('#classInfoTable');
    	cInfo.html(""); // ajax 움직일 때 마다 초기화 why? append라서 
		// Gson으로 강의에 대한 강의 Info값 이미지, 관심사, 레벨, 강사이름 등 찍어주기 
		for(var i in el){
		//강의 head, aside 강의 정보 찍어주기 
		$('#classPk').val(el[i].cl_idnum);
    	$('#classImg').html("<img src='"+el[i].pi_pisysname+"'width='150px' height='200px'>");
    	$('#classInfo').html("<h5>"+el[i].cl_cc+" | LV "+el[i].cl_lv+" | "+el[i].mb_name+" 강사</h5>");
    	$('#className').html("<h2>"+el[i].cl_clName+"</h2>");
		cInfo.append("<tr><td>과목명</td><td>"+el[i].cl_clName+"</td></tr>");
		cInfo.append("<tr><td>학습레벨</td><td>LV "+el[i].cl_lv+"</td></tr>");
		cInfo.append("<tr><td>강수</td><td>"+el[i].cl_lcnum+"강</td></tr>");
		cInfo.append("<tr><td>강의평점</td><td>"+avg+"점</td></tr>");
		}
    	//ajax하기 전 초기화 
        $("#classRight").html("");
    	//classRight에 값 찍어주기, 수강후기는 ajax 타고 와야함 
        var str=$("#classRight");
        str.append("<div style='width:1036px; height:80px;'><h3>해당강의 맛보기 문제 풀어보기</h3><hr style='width:350px;'>");
        str.append("<div>해당강의의 맛보기 문제를 풀어볼 수 있습니다.</div><div>해당강의와 level이 맞지 않으면 맛보기 문제를 풀어주세요.</div>");
        str.append("<br><a href='x'><button>맛보기문제 풀러 가기 ---></button></a>");
        str.append("<br><br><hr style='width:350px;'></div>");
        // 수강후기 ajax 타고와서 table 찍어줌
        str.append("<div style='width:1036px; height:300px;'><br><br><div>수강후기 <input type='button' value='+더보기' onclick='test()'><hr style='width:100px;'></div><br><div>ajax로 수강후기 테이블 출력할 위치</div>");
        str.append("</div>");
    };
    
    function classLectureAjax(){ // 강의목록 ajax
    $("#classRight").html(""); //classRight 초기화 후 강의목록 테이블 찍어주기 위한 초기화 과정	
    var classPk= $('#classPk'); //class pk key input hidden name bean클래스랑 맞춰주기 
    $.ajax({ //강의 pk값으로 해당 강의 강좌list 가져오기 위한 ajax
    	type:'post',
    	url:'rest/classLectureAjax',
    	data: classPk,
    	dataType:'json',
    	success: function(json){
    		console.log(json);
    		var lectureList=$('#classRight'); //여기에 table 출력
    		if(json[0].aa_id ==null){
    			alert("로그인 후 이용해주세요.");
    			classInfoAjax();
    		}else{
    			
    		lectureList.append("<div id='lectureDiv' style='width:1036px; height:652px;'><table id='lectureTable' style='margin:auto; border-collapse:collapse;'></table></div>");
    		$('#lectureTable').append("<tr><td>회차</td><td>강좌명</td><td>수강여부</td></tr>");
    		for(var i in json){
    				 if(json[i].atd_atmk !=null){
    					$('#lectureTable').append("<tr style='border-bottom:1px solid black;'><td>"
    					+json[i].co_num+"강</td><td><a href='selectClassLectureVideoPage?co_idnum="
    					+json[i].co_idnum+"&co_num="+json[i].co_num+"' target='_blank'>"+json[i].co_name+"</a></td><td>수강완료</td></tr>");    				
    				}else{
    					$('#lectureTable').append("<tr style='border-bottom:1px solid black;'><td>"
    					+json[i].co_num+"강</td><td><a href='selectClassLectureVideoPage?co_idnum="
    					+json[i].co_idnum+"&co_num="+json[i].co_num+"' target='_blank'>"+json[i].co_name+"</a></td><td>미수강</td></tr>");
    				}	
    			}//for 
    		}// 로그인 if else에서 else문 end
    	}, error: function(err){
    		console.log(err);
    	}
    }); //classLecture 의 ajax END
    }; //function classLectureAjax 의 END
</script>
</html>