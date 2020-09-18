<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ClassHome</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="resources/js/jquery.serializeObject.js"></script>
    

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
            overflow:scroll;
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
        	<input type='hidden' value='' name='cob_kind' id='boardKind' class='boardKind'>
    </div>
    <div id='classNav' name='classNav' class='classNav'>
        <ul>
            <li id='classInfoAjax' class='li' onclick='classInfoAjax()'> 강의소개   </li>
            <li id='classVideoTableAjax' class='li' onclick='classLectureAjax()'> 강의목록 </li>
            <li id='classNotice' class='li' onclick='classNotice()'> 공지사항  </li>
            <li id='classQNA' class='li' onclick='classQNA()'> Q&A </li>
            <li id='classPostscript' class='li' onclick='classReview()'> 수강후기  </li>
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
        classInfoAjax();  //강의실 들어오자마자 강좌소개에 필요한 값 ajax 밑 div 찍어주기 위한 함수 실행
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
        str.append("<br><input type='button' onclick='previewQuiz()' value='맛보기문제 풀러가기'>");
        str.append("<br><br><hr style='width:350px;'></div>");
        // 수강후기 ajax 타고와서 table 찍어줌
        str.append("<div style='width:1036px; height:300px;'><br><br><div>수강후기 <input type='button' value='+더보기' onclick='test()'><hr style='width:100px;'></div><br><div>ajax로 수강후기 테이블 출력할 위치</div>");
        str.append("</div>");
    }//classInfoAjax() END
    
    function previewQuiz(){
    	var classPk=$('#classPk').val(); //cl_clname
    	window.open("selectPreviewQuiz?cl_idnum="+classPk,'_blank','width=800, height=600, top=200, left=200'); 
    	
    }// previewQuiz() END
    
    function classLectureAjax(){ // 강의목록 ajax
    $("#classRight").html(""); //classRight 초기화 후 강의목록 테이블 찍어주기 위한 초기화 과정	
    var classPk= $('#classPk'); //class pk key input hidden name bean클래스랑 맞춰주기 
    $.ajax({ //강의 pk값으로 해당 강의 강좌list 가져오기 위한 ajax
    	type:'post',
    	url:'rest/classLectureAjax',
    	data: classPk,
    	dataType:'json',
    	success: function(json){
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
    					+json[i].co_idnum+"&co_num="+json[i].co_num+"&atd_atmk="+json[i].atd_atmk+"' target='_blank'>"
    					+json[i].co_name+"</a></td><td>수강완료</td></tr>");    				
    				}else{
    					$('#lectureTable').append("<tr style='border-bottom:1px solid black;'><td>"
    					+json[i].co_num+"강</td><td><a href='selectClassLectureVideoPage?co_idnum="
    					+json[i].co_idnum+"&co_num="+json[i].co_num+"&atd_atmk="+json[i].atd_atmk+"' target='_blank'>"
    					+json[i].co_name+"</a></td><td>미수강</td></tr>");
    				}	
    			}//for 
    		}// 로그인 if else에서 else문 end
    	}, error: function(err){
    		console.log(err);
    	}
    }); //classLecture 의 ajax END
    }; //function classLectureAjax 의 END
    
    function classNotice(){
    	$('#boardKind').val(1);
    	var obj = {
    		'cob_idnum':$('#classPk').val(),
    		'cob_kind':$('#boardKind').val()
    	}
    	$.ajax({
    		type: 'post',
    		url: 'rest/selectClassNoticeAjax',
    		data: obj, 
    		dataType: 'json', 
    		success: function(json){
    			//console.log(json);
    			var notice = $('#classRight');
    			notice.html("");
    			notice.append("<div id='noticeDiv' style='width:1036px; height:652px;'><table id='noticeTable' style='margin:auto; border-collapse:collapse;'></table></div>");
    			var noticeTable = $('#noticeTable');
    			noticeTable.append("<tr><td>번호</td><td>구분</td><td>제목</td><td>등록일</td></tr>");
    			if(json != ""){
    				for(var i in json){
    					//console.log("1=",json[i]);
    					var boardInfo = JSON.stringify(json[i]);
    					//console.log(boardInfo);
    					noticeTable.append("<tr id='tr_"+i+"'></tr>");
    					var noticeTr = $('#tr_'+i);
    					noticeTr.append("<td>"+json[i].cob_bonum.substring(3)+"</td>");    					
    					noticeTr.append("<td>"+json[i].bk_boardName+"</td>");    					
    					noticeTr.append("<td><a href='#;' onclick='classNoticeDetail("+boardInfo+")'>"+json[i].cob_title+"</a></td>");    					
    					noticeTr.append("<td>"+json[i].cob_date+"</td>");    					
    				}
    			}else{
    				noticeTable.append("<tr><td colspan='4'>등록된 게시글이 없습니다.</td></tr>");
    			}
    		}, error: function(err){
    			console.log(err);
    		}
    	});//classNotice Ajax END
    }//function classNotice() END
    
    function classNoticeDetail(info){
    	classInfo = ${classInfo};
    	console.log(info);
    	//var boardInfo = JSON.parse(info);
    	var noticeDetail = $('#classRight');
    	noticeDetail.html("");
		noticeDetail.append("<div id='noticeDetailDiv' style='width:800px; height:300px; margin:auto; text-align:left;'></div>");    	
		//$('#noticeDetailDiv').append("<table style='margin:auto; border-collapse:collapse; border:1px;'><tr><td>"+info.bk_boardName+"</td><td>"+info.cob_title+"</td><td>"+info.cob_date+"</td></tr></table>")
    	$('#noticeDetailDiv').append("<h4>"+info.bk_boardName+"</h4><hr>");
		$('#noticeDetailDiv').append("<table id='noticeDetailTable' style='margin:auto; border-collapse:collapse; float:left;'><tr><td>제목:</td><td>"+info.cob_title+"</td></tr></table>");
		$('#noticeDetailTable').append("<tr><td>강사명</td><td>"+classInfo[0].mb_name+"</td></tr>");
		$('#noticeDetailTable').append("<tr><td>작성일</td><td>"+info.cob_date+"</td></tr>");
		$('#noticeDetailDiv').append("<div style='float:left; margin:auto; width:800px; height:300px;'><hr><br/>"+info.cob_cont+"</div>");
		$('#noticeDetailDiv').append("<input type='button' value='돌아가기' onclick='classNotice()'>");
    }
    
    function classQNA(){
    	$('#boardKind').val(2);
    	var obj = {
        		'cob_idnum':$('#classPk').val(),
        		'cob_kind':$('#boardKind').val()
        	}
    			$('#classRight').html("");
    			$('#classRight').append("<div id='QNADiv' style='width:1036px; height:652px;'></div>");
    			$('#QNADiv').append("<table id='QNATable' style='margin:auto; border-collapse:collapse;'></table>");
    			$('#QNATable').append("<tr><td>번호</td><td>구분</td><td>강좌</td><td>제목</td><td>등록일</td></tr>");
    			$('#QNADiv').append("<input type='button' value='Q&A 작성' onclick='classInsertViewQNA()'>");
    	$.ajax({
    		type: 'post',
    		url: 'rest/selectClassQNA', 
    		data: obj, 
    		dataType: 'json', 
    		success: function(json){
    			if(json!=""){
    				for(var i in json){
    					$('#QNATable').append("<tr id='tr_"+i+"'></tr>");
						var QNATr = $('#tr_'+i);
						QNATr.append("<td>"+json[i].cob_bonum.substring(2)+"</td>");    					
						QNATr.append("<td>"+json[i].bk_boardName+"</td>");
						QNATr.append("<td>"+json[i].cob_num+"강</td>");
						QNATr.append("<td><a href='#;' onclick=\"classQnaDetail('"+json[i].cob_bonum+"')\">"+json[i].cob_title+"</a></td>");    					
						QNATr.append("<td>"+json[i].cob_date+"</td>");
    				}
    			}else{
    				$('#QNATable').append("<tr><td colspan='5'>등록된 게시글이 없습니다.</td></tr>");
    			}
    		}, error: function(err){
    			console.log(err);
    		}
    	});
    }//function classQNA()END
    
    function classInsertViewQNA(){
        var classPk= $('#classPk');
    	$.ajax({
    		type: 'post', 
    		url: 'rest/classLectureAjax', 
    		data: classPk, 
    		dataType: 'json', 
    		success: function(json){
    			var cr = $('#classRight'); 
    			cr.html("");
    			cr.append("<div id='insertQNADiv' style='width:500px; height:652px; margin:auto;'></div>");
    			var iDiv = $('#insertQNADiv');
    			var str=""; 
    			
    			str += "<form name='insertFrmQNA' id='insertFrmQNA'>";
    			str += "<input type='hidden' name='cob_idnum' value='"+classPk.val()+"'>";
    			str += "<input type='hidden' name='cob_lv' value='"+json[0].co_lv+"'><br/>"
    			str += "<input type='hidden' name= cob_kind value='"+$('#boardKind').val()+"'>"; 
    			str += "<select id='cob_num' name='cob_num'><option value=''>강좌를 선택해주세요.</option>";
    			for(var i in json){
    				str += "<option value='"+json[i].co_num+"'>"+json[i].co_name+"</option>";
    			}
    			str += "</select><br/><hr>";
    			str += "<input type='text' placeholder='제목을 입력해주세요.' name='cob_title'><br/><br/>";
    			str += "<textarea id='cob_cont' name='cob_cont' cols='40' rows='20'></textarea><br/>";
    			
    			str += "<input type='button' value='작성하기' onclick='insertQNA()'></form>";
    			iDiv.append(str);
    		}, error: function(err){
    			console.log(err);
    		} 
    	})//course select Ajax END
    }//function classInsertQNA() END
    
    function insertQNA(){
    	var $confirm = confirm("Q&A를 작성하시겠습니까?");
    	if($confirm == true){
    		var obj = $('#insertFrmQNA').serializeObject();
    		console.log(obj);
    		
    		$.ajax({
    			type: 'post',
    			url: 'rest/insertMyClassQnaAjax',
    			data: obj,
    			dataType: 'json',
    			success: function(json){
    					console.log(json);
    					if(json != ""){
    						var i = json.length - 1; 
    						alert("Q&A 작성이 완료되었습니다.");
    						classQnaDetail(json[i].cob_bonum);
    					}else{
    						alert("Q&A 작성에 실패했습니다.");
    						classInsertViewQNA()
    					}
    				},error: function(err){
    				console.log(err);
    				}
    			}); // insertQNA ajax END
    		}else{//confirm if
    			return;
    		}
    }//function insertQNA() END
    
    function classQnaDetail(bonum){
		var obj = {
				'cob_idnum' : $('#classPk').val(),
				'cob_bonum' : bonum,
				'cob_kind' : $('#boardKind').val()
		}
		$.ajax({
			type: 'post',
			url: 'rest/selectClassQnaDetail',
			data: obj,
			dataType:'json',
			success: function(json){
				var QnaDetail = $('#classRight');
		    	QnaDetail.html("");
				QnaDetail.append("<div id='QnaDetailDiv' style='width:800px; height:300px; margin:auto; text-align:left;'></div>");
				$('#QnaDetailDiv').append("<h4>"+json[0].bk_boardName+"</h4><hr>");
				$('#QnaDetailDiv').append("<table id='QnaDetailTable' style='margin:auto; border-collapse:collapse; float:left;'><tr><td>제목:</td><td>"+json[0].cob_title+"</td></tr></table>");
				$('#QnaDetailTable').append("<tr><td>작성자</td><td>"+json[0].cob_id+"</td></tr>");
				$('#QnaDetailTable').append("<tr><td>작성일</td><td>"+json[0].cob_date+"</td></tr>");
				console.log(json[0].cob_cont);
				$('#QnaDetailDiv').append("<div style='float:left; margin:auto; width:800px; height:300px;'><hr><br/>"+json[0].cob_cont+"</div>");
				$('#QnaDetailDiv').append("<div style='float:left; marign:auto width:800px; height:300px;' id='replyDiv'></div>");
				$('#replyDiv').append("<hr><h4>댓글</h4><hr>");
				console.log(json[0].reply);
					var str ="";
				if(json[0].cr_reply != undefined){
					for(var i in json){
						str += "<div><div style='margin:10px;'><b>"+json[i].cr_id+"</b></div>";
						str += "<div style='margin:10px;'>"+json[i].cr_reply+"</div>";
						str += "<div style='margin:10px;'>"+json[i].cr_date+"</div>";
						str += "<hr></div>";
					}
				}
				str +="<form id='replyFrm' name='replyFrm'>";
				str +="<div style='float:left'>sessionID</div><br/>";
				str +="<textarea rows='3px' cols='80px' name='cr_reply'></textarea><br/>";
				str +="<input type='hidden' value='"+json[0].cob_bonum+"' name='cob_bonum'>";
				str +="<input type='button' value='댓글 작성' onclick='insertQnaReply()'><br/><br/><br/></form>";
				$('#QnaDetailDiv').append("<input type='button' value='돌아가기' onclick='classQNA()'>");
				$('#replyDiv').append(str);
			}, error: function(err){
				console.log(err);
			}
		})//ajax END
    }//function classQnaDetail() END
    
    function insertQnaReply(){
		var obj = $('#replyFrm').serializeObject();
		console.log(obj);
		$.ajax({
			type: 'post',
			url: 'rest/insertQnaReply',
			data: obj,
			dataType: 'json',
			success: function(json){
				classQnaDetail(json);
				//classQnaDetail()
			}, error: function(err){
				console.log(err);
			}
		});// ajax insertQnaReply END
    }// function insertQnaReply() END
    
    function classReview(){
    	$('#boardKind').val(3);
    	var obj = {
    			'cob_idnum': $('#classPk').val(),
    			'cob_kind': $('#boardKind').val()
    	}
    	$('#classRight').html("");
		$('#classRight').append("<div id='reviewDiv' style='width:1036px; height:652px;'></div>");
		$('#reviewDiv').append("<table id='reviewTable' style='margin:auto; border-collapse:collapse;'></table>");
		$('#reviewTable').append("<tr><td>번호</td><td>구분</td><td>제목</td><td>평점</td><td>작성자</td><td>등록일</td></tr>");
		$('#reviewDiv').append("<input type='button' value='리뷰 작성' onclick='classReviewInsertPage()'>");
		$.ajax({
			type: 'post',
			url: 'rest/selectClassReview',
			data: obj,
			dataType: 'json',
			success: function(json){
				var str="";
				if(json !=""){
					for(var i in json){
					str+="<tr><td>"+json[i].cob_bonum.substring(2)+"</td>";
					str+="<td>"+json[i].bk_boardName+"</td>";
					str+="<td><a href='#;' onclick=\"classReviewDetail('"+json[i].cob_bonum+"','"+json[i].gpa_gpa+"')\">"+json[i].cob_title+"</a></td>";
					str+="<td>"+json[i].gpa_gpa+"점</td>";
					if(json[i].cob_id.length>2){
						var name = json[i].cob_id.split('');
						for(var j in name){
							if(j==0 || j==name.length -1){
								name[j]=name[j];
							}else{
								name[j]='*';	
							}
						}
						var rename = name.join('');
					}else{
						var name = json[i].cob_id.split('');
						for(var j in name){
							if(j==0 && name.length -1 !=0){
								name[j]=name[j];
							}else{
								name[j]='*';
							}
						}
						var rename = name.join('');
					}
					str+="<td>"+rename+"</td>";
					str+="<td>"+json[i].cob_date+"</td></tr>";
					}
					$('#reviewTable').append(str);
				}else{
					str += "<tr><td colspan='6' style='margin:auto'>등록된 수강후기가 없습니다.</td></tr>";
					$('#reviewTable').append(str);
				}
			}, error: function(err){
				console.log(err);
			}
		});//ajax classReview END
    }//function classReview() END
    
    function classReviewInsertPage(){
    	var cl = ${classInfo};
    	var obj= {
    			'cob_idnum':$('#classPk').val()
    	}	
    	$.ajax({
    		type:'post',
    		url:'rest/selectMyClassAvg',
    		data: obj,
    		dataType:'json',
    		success: function(json){
    			if(json >= 1){
    				var str="";
    				var reviewDetail = $('#classRight');
    		    	reviewDetail.html("");
    				reviewDetail.append("<div id='reviewDiv' style='width:500px; height:652px; margin:auto; text-align:left;'></div>");
       				str += "<h4>강의후기 작성</h4><hr>"
        			str += "<form name='insertFrmReview' id='insertFrmReview'>";
        			str += "<input type='hidden' name='cob_idnum' value='"+cl[0].cl_idnum+"'>";
        			str += "<input type='hidden' name='cob_lv' value='"+cl[0].cl_lv+"'>";
        			str += "<input type='hidden' name= cob_kind value='"+$('#boardKind').val()+"'>"; 
        			str += "<input type='hidden' name='gpa_gpa' value='"+json+"'>";
        			str += "<div style='margin:10px;'>강의명: "+cl[0].cl_clName+" </div>";
        			str += "<div style='margin:10px;'>교수명: "+cl[0].mb_name+"</div>";
        			str += "<div style='margin:10px;'>내 강의평점: "+json+"</div><hr>";
        			str += "<input type='text' placeholder='제목을 입력해주세요.' name='cob_title'><br/><br/>";
        			str += "<textarea id='cob_cont' name='cob_cont' cols='40' rows='20'></textarea><br/>";        			
        			str += "<input type='button' value='작성하기' onclick=\"insertReview('"+json+"')\"></form>";
        			$('#reviewDiv').append(str);
    					
    			}else if(-1 >= json){
    				alert("강의평가를 진행할 수 없습니다. (미수강)");
    			}else{
    				alert("수강신청 후 강의를 모두 들으셔야 작성하실 수 있습니다.");
    			}
    		}, error: function(err){
    			console.log(err);
    		}
    	});// ajax classReviewInsertPage END
    }//function classReviewInsertPage() END
   	
    function insertReview(myGpa){
    	var myAvg=myGpa;
    	console.log(myAvg);
    	var obj = $('#insertFrmReview').serializeObject();
    	console.log(obj);
    	$.ajax({
    		type: 'post',
    		url: 'rest/insertClassReview',
    		data: obj,
    		dataType: 'json',
    		success: function(json){
				classReviewDetail(json, myAvg);
    		},error: function(err){
    			console.log(err);
    		}
    	}); // ajax insertReview END
    }//function insertReview() END
    
    function classReviewDetail(bonum, gpa){
    	var obj = {
				'cob_idnum' : $('#classPk').val(),
				'cob_bonum' : bonum,
				'cob_kind' : $('#boardKind').val()
		}
    	var myAvg = gpa;
    	var cl = ${classInfo};

    	 
		$.ajax({
			type: 'post',
			url: 'rest/selectClassReviewDetail',
			data: obj,
			dataType:'json',
			success: function(json){
				var reviewDetail = $('#classRight');
		    	reviewDetail.html("");
				reviewDetail.append("<div id='reviewDetailDiv' style='width:800px; height:300px; margin:auto; text-align:left;'></div>");
				$('#reviewDetailDiv').append("<h4>"+json[0].bk_boardName+"</h4><hr>");
				$('#reviewDetailDiv').append("<table id='reviewDetailTable' style='margin:auto; border-collapse:collapse; float:left;'><tr><td>제목:</td><td>"+json[0].cob_title+"</td></tr></table>");
				$('#reviewDetailTable').append("<tr><td>평점</td><td>"+myAvg+"</td></tr>");
				if(json[0].cob_id.length>2){
					var name = json[0].cob_id.split('');
					for(var j in name){
						if(j==0 || j==name.length -1){
							name[j]=name[j];
						}else{
							name[j]='*';	
						}
					}
					var rename = name.join('');
				}else{
					var name = json[0].cob_id.split('');
					for(var j in name){
						if(j==0 && name.length -1 !=0){
							name[j]=name[j];
						}else{
							name[j]='*';
						}
					}
					var rename = name.join('');
				}
				$('#reviewDetailTable').append("<tr><td>작성자</td><td>"+rename+"</td></tr>");
				$('#reviewDetailTable').append("<tr><td>작성일</td><td>"+json[0].cob_date+"</td></tr>");
				$('#reviewDetailDiv').append("<div style='float:left; margin:auto; width:800px; height:300px;'><hr><br/>"+json[0].cob_cont+"</div>");
				$('#reviewDetailDiv').append("<div style='float:left; marign:auto width:800px; height:300px;' id='replyDiv'></div>");
				$('#replyDiv').append("<hr><h4>댓글</h4><hr>");
					var str ="";
				if(json[0].cr_reply != undefined){
					var rename;
					for(var i in json){
						if(json[i].cob_id == json[i].cr_id){
							rename ="작성자";
						}else if( json[i].cob_id ==cl[0].cl_id){
							rename= cl[0].mb_name;
						}else{
							rename=json[i].cr_id
						}
						str += "<div><div style='margin:10px;'><b>"+rename+"</b></div>";
						str += "<div style='margin:10px;'>"+json[i].cr_reply+"</div>";
						str += "<div style='margin:10px;'>"+json[i].cr_date+"</div>";
						str += "<hr></div>";
					}
				}
				str +="<form id='replyFrm' name='replyFrm'>";
				str +="<div style='float:left'>sessionID</div><br/>";
				str +="<textarea rows='3px' cols='80px' name='cr_reply'></textarea><br/>";
				str +="<input type='hidden' value='"+json[0].cob_bonum+"' name='cob_bonum'>";
				str +="<input type='button' value='댓글 작성' onclick='insertReviewReply()'><br/><br/><br/></form>";
				$('#reviewDetailDiv').append("<input type='button' value='돌아가기' onclick=\"classReview('"+myAvg+"')\">");
				$('#replyDiv').append(str);
			}, error: function(err){
				console.log(err);
			}
		})//ajax END    	
    }//function classReviewDetail() END
    
    function insertReviewReply(gpa){
    	var boardGpaAvg=gpa;
    	var obj = $('#replyFrm').serializeObject();
		console.log(obj);
		$.ajax({
			type: 'post',
			url: 'rest/insertReviewReply',
			data: obj,
			dataType: 'json',
			success: function(json){
				classReviewDetail(json, boardGpaAvg);
			}, error: function(err){
				console.log(err);
			}
		});// ajax insertReviewReply END
    }//function insertReviewReply()END
</script>
</html>