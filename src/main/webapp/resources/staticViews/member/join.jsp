<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의 댕댕 ｜ 회원가입</title>
<link rel="stylesheet" type="text/css" href="/resources/css/joinForm.css">
<link href='https://fonts.googleapis.com/css?family=Nunito:400,300' rel='stylesheet' type='text/css'>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js" 
integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
</head>
<body>
<div class="header"><%@ include file="/WEB-INF/views/mainPageView/mainHeader.jsp" %></div>

	<form action="/member/joinMember.do" method="post" enctype="multipart/form-data">
        <h2>회원가입</h2>
        <fieldset>
	         <div class="icon_box">
	          <img id="user_icon" src="/resources/images/user_icon.png"></img>
	         </div>
	          <img id="camera_icon" src="/resources/images/camera_icon.png" onclick="profileUpload()"></img>
	          <input type=file name='profileFile' style='display: none;' onchange="readURL(this);"> 
	
	          <label>아이디<a style="color:red">*</a></label>
	          <input type="text" name="memberId" id="memberId" placeholder="영문자로 시작하는 6~20자의 영문자 또는 숫자" style="margin-bottom:15px;">
	          <div id="idMsg" style="font-size:12px;"></div>
	          <br>
	          
	          <label>비밀번호<a style="color:red">*</a></label>
	          <input type="password" name="memberPwd" id="memberPwd" placeholder="비밀번호를 입력해 주세요." style="margin-bottom: 3px;">
	          <input type="password" name="memberPwd_re" id="memberPwd_re" placeholder="비밀번호를 한 번 더 입력해주세요." style="margin-bottom:15px;">
	          <div id="pwdMsg" style="font-size:12px;"></div>
	          <br>
	          
	          <label>이메일<a style="color:red">*</a></label>
	          <input type="email" name="email" id="email" placeholder="이메일을 입력해 주세요." style="margin-bottom:15px;">
	          <div id="emailMsg" style="font-size:12px;"></div>
	          <br>
	          
	          <label>닉네임<a style="color:red">*</a></label>
	          <input type="text" name="nickname" id="nickname" placeholder="닉네임을 입력해 주세요." style="margin-bottom:15px;">
	          <div id="nicknameMsg" style="font-size:12px;"></div>
	          <br>
	          
	          <label>성별<a style="color:red">*</a></label><br>
	          <input type="radio" value="M" name="gender" checked>
	          <label for="gender" class="light">남자</label>&emsp;
	          
	          <input type="radio" value="F" name="gender">
	          <label for="gender" class="light">여자</label>
	          <br><br>
			  
	          <label>생년월일</label><br>
		        <select name="yy" id="year" style="width:90px;" onchange="changeBirthdate();">
		        	<option value="" selected hidden>--</option>
		        	<option value="">--</option>
		        </select>년
				<select name="mm" id="month" style="width:90px;" onchange="changeBirthdate();">
					<option value="" selected hidden>--</option>
					<option value="">--</option>
				</select>월
				<select name="dd" id="day" style="width:90px;" onchange="changeBirthdate();">
					<option value="" selected hidden>--</option>
					<option value="">--</option>
				</select>일
				<input type="text" id="birthdate" name="birthdate" value="" style="display:none;">
	          <br>
	          
	          <label for="address">주소</label><br>
	          <input type="text" name="address" id="address_kakao" style="margin-bottom: 3px;" placeholder="주소">
	          <input type="text" name="addressDetail" placeholder="상세 주소">
	        
	        <button type="submit" onClick="return checkForm();">가입하기</button>
        </fieldset>
      </form>
<div class="footer"><%@ include file="/WEB-INF/views/mainPageView/mainFooter.jsp" %></div>

      <script>
      //아이디 중복 체크
      	$('#memberId').focusout(function(){
      		var memberId = $('#memberId').val();
      		var exp = /^[a-z]+[a-z0-9]{5,19}$/g;
      		
      		if(exp.test(memberId)){
      			$.ajax({
      				url:"/member/memberIdCheck.do",
      				data:{"memberId":memberId},
      				type:"get",
      				success:function(result){
      					if(result=="true"){
      						$('#memberId').css('margin-bottom','0px');
      						$('#idMsg').html("이미 사용 중인 아이디입니다.").css('color','red');
      					}else{
      						$('#memberId').css('margin-bottom','0px');
      						$('#idMsg').html("사용 가능한 아이디입니다.").css('color','green');
      					}
      				},
      				error:function(){
      					console.log('ajax통신 실패');
      				}
      			})
      		}else{
      			$('#memberId').css('margin-bottom','0px');
      			$('#idMsg').html("영문자로 시작하는 6~20자의 영문자 또는 숫자로 입력하세요.").css('color','red');
      		}
      	})
      	
      	//비밀번호 정규식 및 일치 여부
       	$("#memberPwd_re").focusout(function(){
    		var pw1 = $('#memberPwd').val();
    		var pw2 = $('#memberPwd_re').val();
    		var rule = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,20}$/;
          		
        	if(!(rule.test(pw1)) && !(rule.test(pw2))){
        		$('#memberPwd_re').css('margin-bottom','0px');
        		$('#pwdMsg').html("영문/숫자/특수문자를 조합하여 8~15자로 입력 해주세요. ").css('color','red');
        	}else if(pw1 != pw2){
        		$('#memberPwd_re').css('margin-bottom','0px');
       			$('#pwdMsg').html("비밀번호가 서로 일치하지 않습니다.").css('color','red');
       		}else{
       			$('#memberPwd_re').css('margin-bottom','0px');
       			$('#pwdMsg').html("");
       		}
		});
      
      //이메일 정규식
      $('#email').blur(function(){
    	var email = $('#email').val();
    	var emailRule = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
		if(!emailRule.test(email)){
			$('#email').css('margin-bottom','0px');
			$('#emailMsg').html("이메일 형식으로 입력해주세요.").css('color','red');
		}else{
			$('#emailMsg').html("");
		}
      })
      
      //닉네임 정규식
      $('#nickname').focusout(function(){
    	var nickname = $('#nickname').val();
    	var nicknameRule = /^([a-zA-Zㄱ-ㅎ|ㅏ-ㅣ|가-힣]).{1,7}$/;
		if(!nicknameRule.test(nickname)){
			$('#nickname').css('margin-bottom','0px');
			$('#nicknameMsg').html("한글 또는 영문 최대 8글자로 입력해 주세요.").css('color','red');
		}else{
			$('#nicknameMsg').html("");
		}
      })
      </script>
      
      
       <!-- 카카오 주소 API -->
      <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
		window.onload = function(){
			//주소입력칸을 클릭하면 카카오 지도 발생
		    document.getElementById("address_kakao").addEventListener("click", function(){ 
		        new daum.Postcode({
		            oncomplete: function(data) { //선택시 입력값 세팅
		                document.getElementById("address_kakao").value = data.address; //주소 넣기
		                document.querySelector("input[name=detailAddress]").focus(); //상세입력 포커싱
		            }
		        }).open();
		    });
		}
		</script>
      
      <!-- 카메라 아이콘 클릭시 파일 업로드창 -->
      <script>
      	function profileUpload() {
      	 document.all.profileFile.click();
    	}
      </script>
      
      <!-- 업로드한 파일 미리보기 -->
      <script>
	     function readURL(input) {
	   	  if (input.files && input.files[0]) {
	   	    var reader = new FileReader();
	   	    reader.onload = function(e) {
	   	    document.getElementById('user_icon').src = e.target.result;
	   	    };
	   	    reader.readAsDataURL(input.files[0]);
	   	  } else {
	   	    document.getElementById('user_icon').src = "";
	   	  }
	   	}
      </script>
      
      <!-- 생년월일 -->
      <script>
		 $(document).ready(function(){            
		    var now = new Date();
		    var year = now.getFullYear();
		    var mon = (now.getMonth() + 1) > 9 ? ''+(now.getMonth() + 1) : '0'+(now.getMonth() + 1); 
		    var day = (now.getDate()) > 9 ? ''+(now.getDate()) : '0'+(now.getDate());           
		    //년도 selectbox만들기               
		    for(var i = 2022 ; i >= 1900 ; i--) {
		        $('#year').append('<option value="' + i + '">' + i + '</option>');    
		    }
		
		    // 월별 selectbox 만들기            
		    for(var i=1; i <= 12; i++) {
		        var mm = i > 9 ? i : "0"+i ;            
		        $('#month').append('<option value="' + mm + '">' + mm + '</option>');    
		    }
		    
		    // 일별 selectbox 만들기
		    for(var i=1; i <= 31; i++) {
		        var dd = i > 9 ? i : "0"+i ;            
		        $('#day').append('<option value="' + dd + '">' + dd+ '</option>');    
		    }
		    
		    if (($('#year').val() != null && $('#year').val() != '') && 
		    		($('#month').val() != null && $('#month').val() != '') && 
		    			($('#day').val() != null && $('#day').val() != '')) {
		    	$('#birthdate').attr('value',year+mon+day);	
		    }
		})
		
		 function changeBirthdate() {
			 var year = $('#year').val();
			 var mon  = $('#month').val();
		     var day  = $('#day').val();
			 
			 if ((year != null && year != '') && (mon != null && mon != '') && (day != null && day != '')) {
			   $('#birthdate').attr('value', year + mon + day);	
			 }
		 }
	</script>
	
	<!-- 가입 전 최종점검 -->
	<script>
		function checkForm() {
			// 플래그값 관리
			var flag = 0;
			// 필수입력값 체크
			var memberId     = $('#memberId').val();
			var pw1          = $('#memberPwd').val();
    		var pw2          = $('#memberPwd_re').val();
    		var email        = $('#email').val();
    		var nickname     = $('#nickname').val();
    		var memberIdText = $('#idMsg').text();
    		var pwdText      = $('#pwdMsg').text();
    		var emailText    = $('#emailMsg').text();
    		var nicknameText = $('#nicknameMsg').text();
    		
    		// 필수입력값 체크
    		if (memberId == "" || memberId == null || memberId == undefined) flag = 1;
    		if (pw1 == ""      || pw1 == null      || pw1 == undefined)      flag = 1;
    		if (pw2 == ""      || pw2 == null      || pw2 == undefined)      flag = 1;
    		if (email == ""    || email == null    || email == undefined)    flag = 1;
    		if (nickname == "" || nickname == null || nickname == undefined) flag = 1;
	    		
    		// 유효성검증 체크(메시지가 없는 것만 패스)
    		if (memberIdText != '사용 가능한 아이디입니다.') {
    			alert("아이디를 확인해주세요.");
    			return false;
    		}
    		if (pwdText != ''){
    			alert("비밀번호를 확인해주세요.");
    			return false;
    		}
    		if (emailText != ''){
    			alert("이메일을 확인해주세요.");
    			return false;
    		}
    		if (nicknameText != '') {
    			alert("닉네임을 확인해주세요.");
    			return false;
    		}
    		
    		if (flag == 1) {
    			alert("필수 입력값을 채워주세요.");
    			return false;
    		} else {
    			return true;
    		}
		}
	</script>
	
	
</body>
</html>