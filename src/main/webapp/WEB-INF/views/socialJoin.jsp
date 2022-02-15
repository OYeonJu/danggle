<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의 댕댕 ｜ 회원가입</title>
<link rel="stylesheet" type="text/css" href="/resources/css/socialJoinForm.css">
<link href='https://fonts.googleapis.com/css?family=Nunito:400,300' rel='stylesheet' type='text/css'>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
	<form action="/socialJoin.do" method="post">
        <h2>추가 입력 사항</h2>
        <fieldset>
        <c:choose>
        	<c:when test="${requestScope.userInfo.profile_image != null}">
	          <img id="user_icon" name="memberProfile" src="${requestScope.userInfo.profile_image}"></img>
        	</c:when>
        	<c:otherwise>
	          <img id="user_icon" src="/resources/images/user_icon.png"></img>
        	</c:otherwise>
        </c:choose>
          <br>
          
          <input type="hidden" name="authProvider" value="${requestScope.userInfo.authProvider}">
          <input type="hidden" name="memberId" value="${requestScope.userInfo.socialId}">
          
          <label>이메일<a style="color:red">*</a></label>
          <c:choose>
	          <c:when test="${requestScope.userInfo.email != null }">
	            <input type="email" id="email" name="email" placeholder="${requestScope.userInfo.email}" value="${requestScope.userInfo.email}" readonly>
	          </c:when>
	          <c:otherwise>
	          	<input type="email" id="email" name="email" placeholder="이메일을 입력해 주세요.">
	          	<div id="emailMsg" style="font-size:12px;"></div>
	          </c:otherwise>
          </c:choose>
          
          <label>닉네임<a style="color:red">*</a></label>
          <input type="text" id="nickname" name="nickname" placeholder="${requestScope.userInfo.nickname}" value="${requestScope.userInfo.nickname}"readonly>
          
          <label>성별<a style="color:red">*</a></label>
          <input type="radio" value="M" name="gender" checked>
          <label for="gender" class="light">남자</label>&emsp;
          
          <input type="radio" value="F" name="gender">
          <label for="gender" class="light">여자</label>
          <br><br>
          
          <label>생년월일</label>
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
          
          <label for="address">주소</label>
	      <input type="text" name="address" style="margin-bottom: 3px;"placeholder="주소">
	      <input type="text" name="detailAddress" placeholder="상세 주소">
       
        <button type="submit" onClick="checkForm()">가입하기</button>
        </fieldset>
      </form>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
   
      <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
		window.onload = function(){
			//주소입력칸을 클릭하면 카카오 지도 발생
		    document.getElementById("address_kakao").addEventListener("click", function(){ 
		        new daum.Postcode({
		            oncomplete: function(data) { //선택시 입력값 세팅
		                document.getElementById("address_kakao").value = data.address; //주소 넣기
		                document.querySelector("input[name=address_detail]").focus(); //상세입력 포커싱
		            }
		        }).open();
		    });
		}
		</script>


		<script>
		//이메일 정규식
	      $('#email').blur(function(){
	    	var email = $('#email').val();
	    	var emailRule = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
			if(!emailRule.test(email)){
				$('#email').css('margin-bottom','0px');
				$('#emailMsg').html("이메일 형식으로 입력해주세요.").css('color','red');
				$('#emailMsg').html("이메일 형식으로 입력해주세요.").css('margin-bottom','15px');
			}else{
				$('#emailMsg').html("");
			}
	      })
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
	
	<script>
		function checkForm() {
			var emailText = $('#emailMsg').text();
			if (emailText != ''){
    			alert("이메일을 확인해주세요.");
    			return false;
    		}
		}
	</script>
</body>
</html>