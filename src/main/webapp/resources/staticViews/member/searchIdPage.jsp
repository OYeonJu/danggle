<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의 댕댕 ｜ 아이디 찾기</title>
<link rel="stylesheet" type="text/css" href="/resources/css/searchIdPage.css">
<script src="https://code.jquery.com/jquery-3.5.1.js" 
integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

	  <div class="form">
	      <h2 style="color:black;">아이디 찾기</h2>
	      <input type="email" id="email" style="margin-bottom:1px;" placeholder="이메일을 입력하세요"/>
	      <button class="longBtn" id="sendEmailCodeBtn">인증번호 받기</button>
	      <br id="br">
	      
	      <input type="text" id="findIdCode" placeholder="6자리 코드 입력" style="display:none; margin:0px;"/>
	      <button class="smallBtn" id="resendBtn" style="display:none;">재전송</button>
	      <div id="timer" style="display:none;"></div>
	      <button class="longBtn" id="findIdBtn" style="display:none;">아이디 찾기</button>
	      
	      <div id="showId" style="display:none;">아이디는 <b id="memberId"></b> 입니다. </div>
	      <div id="showEnrollDate" style="display:none; font-size:12px;">가입일 :  <b id="enrollDate"> </b></div>
	      <a href="/resources/views/login.jsp" class="longBtn" id="loginBtn" style="display:none;">로그인하기</a>
	  </div>
	  
<%@ include file="/WEB-INF/views/common/footer.jsp"%>

<script>
let x; // 전역 timer 변수

function timer(){
	var time = 180;
	var min = "";
	var sec = "";
	
	// Interval 초기화
	clearInterval(x);
	
	x = setInterval(function(){
		min = parseInt(time/60); //몫
		sec = time%60; //나머지
		$('#findIdCode').attr("placeholder", "6자리 코드 입력 " + " ["+min + "분 " + sec + "초]");
		time--;
		
		//타임아웃시
		if(time < 0){
			clearInterval(x);
			alert('인증 시간이 초과되었습니다. 다시 전송해 주세요');
			$('#timer').val("");
		}
	}, 1000);
}
</script>

<script>
	//인증번호 받기
	$('#sendEmailCodeBtn').click(function(){
		var email = $('#email').val();
		$.ajax({
			url:"/findId/sendEmailIdCode.do",
			data:{"email":email},
			type:"POST",
			success:function(result){
				if(result=="true"){
					alert('이메일로 인증번호가 발송되었습니다.');
					$('#email').css("display","none");
					$('#sendEmailCodeBtn').css("display","none");
					$('#br').css("display","none");
					
					timer();
					$('#findIdCode').show();
					$('#timer').show();
					$('#resendBtn').show();
					$('#findIdBtn').show();
				}else{
					alert('가입 시 입력한 이메일이 맞는지 다시 한번 확인해 주세요.');
				}
			},
			error:function(){
				console.log('ajax 통신 실패');
			}
		})
	})
	
	//인증번호 입력하여 아이디 찾기 
	$('#findIdBtn').click(function(){
		var findIdCode = $('#findIdCode').val();
		var email = $('#email').val();
		$.ajax({
			url:"/findId/checkIdCode.do",
			data:{"findIdCode":findIdCode, "email":email},
			type:"POST",
			success:function(data){
				var info = JSON.parse(data);
				var resultCode = info.resultCode;
				var memberId;
				var enrollDate;
				if(info.MEMBERID   != null){
					memberId = info.MEMBERID; 
				}
				if(info.ENROLLDATE != null){
					enrollDate = info.ENROLLDATE;
				}
				
				switch (resultCode) {
				case 'fail_key':
					alert("인증번호가 일치하지 않습니다.");
					$('#findIdCode').val("");
					break;
				case 'fail_timeover':
					alert("인증 시간을 초과하였습니다. 다시 시도해 주세요.");
					$('#findIdCode').val("");
					break;
				case 'success':
					clearInterval(x);
					$('#findIdCode').css("display","none");
					$('#resendBtn').css("display","none");
					$('#timer').css("display","none");
					$('#findIdBtn').css("display","none");
					
					$('#showId').show();
					$('#memberId').html(memberId);
					$('#showEnrollDate').show();
					$('#enrollDate').html(enrollDate);
					break;
				}
			},
			error:function(){
				console.log('ajax통신 실패');
			}
		})
	})							
	
	//인증번호 재전송 + 타이머 리셋
	$('#resendBtn').click(function(){
		var email = $('#email').val();
		$.ajax({
			url:"/findId/sendEmailIdCode.do",
			data:{"email":email},
			type:"POST",
			success:function(result){
				if(result=="true"){
					alert('이메일로 인증번호가 재발송되었습니다.');
					timer();
				}else{
					alert('재전송에 실패하였습니다.');
				}
			},
			error:function(){
				console.log('ajax 통신 실패');
			}
		})
	})
</script>
</body>
</html>