<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의 댕댕 ｜ 비밀번호 찾기</title>
<link rel="stylesheet" type="text/css" href="/resources/css/searchPwdPage.css">
<script src="https://code.jquery.com/jquery-3.5.1.js" 
integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

	  <div class="form">
	      <h2 id="title">비밀번호 찾기</h2>
	      <input type="text" id="memberId" placeholder="아이디를 입력하세요"/>
	      <input type="email" id="email" style="margin-bottom:1px;" placeholder="이메일을 입력하세요"/>
	      <button class="longBtn" id="sendEmailCodeBtn"><b>인증번호 받기</b></button>
	      <br id="br">
	      
	      <input type="text" id="findPwdCode" placeholder="6자리 코드 입력" style="display:none; margin:0px; width:205px;"/>
	      <button class="smallBtn" id="resendBtn" style="display:none;">재전송</button>
	      <div id="timer" style="display:none;"></div>
	      <button class="longBtn" id="findPwdBtn" style="display:none;">비밀번호 찾기</button>
	      
	      <input type="password" id="memberPwd" style="display:none;" placeholder="비밀번호를 입력해주세요."/>
	      <input type="password" id="memberPwd_re" style="display:none;" placeholder="비밀번호를 한 번 더 입력해주세요."/>
	      <button class="longBtn" id="changePwdBtn" style="display:none;">비밀번호 변경</button>
	      
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
		$('#findPwdCode').attr("placeholder", "6자리 코드 입력 " + " ["+min + "분 " + sec + "초]");
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
		var memberId = $('#memberId').val();
		var email = $('#email').val();
		$.ajax({
			url:"/findPwd/sendEmailPwdCode.do",
			data:{"memberId":memberId, "email":email},
			type:"POST",
			success:function(result){
				if(result=="true"){
					alert('이메일로 인증번호가 발송되었습니다.');
					$('#memberId').css("display","none");
					$('#email').css("display","none");
					$('#sendEmailCodeBtn').css("display","none");
					$('#br').css("display","none");
					
					timer();
					$('#findPwdCode').show();
					$('#timer').show();
					$('#resendBtn').show();
					$('#findPwdBtn').show();
				}else{
					alert('아이디와 이메일이 맞는지 다시 한번 확인해 주세요.');
				}
			},
			error:function(){
				console.log('ajax통신 실패');
			}
		})
	})
	
	//인증번호 입력
	$('#findPwdBtn').click(function(){
		var memberId = $('#memberId').val();
		var email = $('#email').val();
		var findPwdCode = $('#findPwdCode').val();
		$.ajax({
			url:"/findPwd/checkPwdCode.do",
			data:{"memberId":memberId, "email":email, "findPwdCode":findPwdCode},
			type:"POST",
			success:function(data){
				switch (data) {
				case 'null':
					alert('인증번호가 일치하지 않습니다.');
					$('#findPwdCode').val("");
					break;
				case '0':
					alert('인증 시간을 초과하였습니다. 다시 시도해 주세요.');
					$('#findPwdCode').val("");
					break;
				case '1':
					clearInterval(x);
					$('#title').text("비밀번호 재설정");
					$('#findPwdCode').css("display","none");
					$('#timer').css("display","none");
					$('#resendBtn').css("display","none");
					$('#findPwdBtn').css("display","none");
					
					$('#memberPwd').show();
					$('#memberPwd_re').show();
					$('#changePwdBtn').show();
					break;
				}
			},
			error:function(){
				console.log('ajax 통신 실패');
			}
		})
	})
	
	//비번 재설정
	$('#changePwdBtn').click(function(){
		var memberId = $('#memberId').val();
		var memberPwd = $('#memberPwd').val();
		var memberPwd_re = $('#memberPwd_re').val();
		var rule = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,20}$/;
		
		if(!(rule.test(memberPwd)) && !(rule.test(memberPwd_re))){
			alert('영문/숫자/특수문자를 조합하여 8~15자로 입력 해주세요.');
    	}else if(memberPwd != memberPwd_re){
    		alert('비밀번호가 서로 일치하지 않습니다.');
   		}else{
			$.ajax({
				url:"/findPwd/changeMemberPwd.do",
				data:{"memberId":memberId, "memberPwd":memberPwd},
				type:"POST",
				success:function(result){
					if(result=="true"){
						alert('비밀번호가 변경되었습니다.');
						location.replace('/resources/staticViews/member/login.jsp');
					}else{
						alert('비밀번호를 재확인 해주세요.');
						$('#memberPwd').val('');
						$('#memberPwd_re').val('');
					}
				},
				error:function(){
					console.log('ajax 통신 실패');
				}
			})
   		}
	})
	
	//인증번호 재전송 + 타이머 리셋
	$('#resendBtn').click(function(){
		var memberId = $('#memberId').val();
		var email = $('#email').val();
		
		$.ajax({
			url:"/findPwd/sendEmailPwdCode.do",
			data:{"memberId":memberId, "email":email},
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