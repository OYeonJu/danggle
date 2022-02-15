<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JQuery 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<!-- JSTL 라이브러리 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<link rel="stylesheet" type="text/css" href="/resources/css/updateMemberInfoPage.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
 
  <!-- 사진 클릭 시 파일 업로드창 생성 -->
<script>
	function profileUpload() {
		document.all.profileFile.click();
	}
</script>

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

<script>
	/* 필수 값 유효성 검사 가이드 텍스트 보여주기 */
	function input_txt(val) {
		$(val).next().css("display", "block");
	}

	/* 타이핑과 함께 유효성 검사 진행 -> 검사 여부에 따라 가이드 텍스트 색상 변경 */
	function check(val) {
		if ($(val).attr('name') == 'nickname') {
			var nickname = $(val).val();
			var nicknameRule = /^([a-zA-Zㄱ-ㅎ|ㅏ-ㅣ|가-힣]).{1,7}$/;
			if (!nicknameRule.test(nickname)) {
				$('#nicknameCheck').css("color", "red");

			} else {
				$('#nicknameCheck').css("color", "green");
			}
		} else {
			var email = $(val).val();
			var emailRule = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
			if (!emailRule.test(email)) {
				$('#emailCheck').css("color", "red");
			} else {
				$('#emailCheck').css("color", "green");
			}

		}

	}
</script>

<script>
	function updateMemberInfo() {
		// 플래그값 관리
		var flag = 0;
		// 필수입력값 체크
		var nickname = $('input[name=nickname]').val();
		var email = $('input[name=email]').val();

		// 유효성 검사 항목
		var nicknameRule = /^([a-zA-Zㄱ-ㅎ|ㅏ-ㅣ|가-힣]).{1,8}$/;
		var emailRule = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;

		if (nickname == '' || nickname == null || nickname == undefined)
			flag = 1;
		if (email == '' || email == null || email == undefined)
			flag = 1;

		if (flag == 1) {
			alert("필수 입력값을 채워주세요.");
			return false;
		} else if (!nicknameRule.test(nickname)) {
			alert("닉네임 양식에 맞게 입력해주세요.");
			return false;
		} else if (!emailRule.test(email)) {
			alert("이메일 양식에 맞게 입력해주세요.");
			return false;
		} else {
			return true;
		}

	}
</script>

<!-- 카카오 주소 API -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	
	window.onload = function() {
		//주소입력칸을 클릭하면 카카오 지도 발생
		document.getElementById("address_kakao").addEventListener("click",function() {
			new daum.Postcode({
				oncomplete : function(data) { //선택시 입력값 세팅
					document.getElementById("address_kakao").value = data.address; //주소 넣기
					document.querySelector("input[name=addressDetail]").focus(); //상세입력 포커싱
				}
			}).open();
		});
	}
</script>
<!-- 생년월일 -->
<script>
	$(document).ready(function() {
		var now = new Date();
		var year = now.getFullYear();
		var mon = (now.getMonth() + 1) > 9 ? ''+ (now.getMonth() + 1) : '0'+ (now.getMonth() + 1);
		var day = (now.getDate()) > 9 ? '' + (now.getDate()) : '0' + (now.getDate());
		//년도 selectbox만들기               
		for (var i = 1900; i <= year; i++) {
			$('#year').append('<option value="' + i + '">' + i+ '</option>');
		}

		// 월별 selectbox 만들기            
		for (var i = 1; i <= 12; i++) {
			var mm = i > 9 ? i : "0" + i;
			$('#month').append('<option value="' + mm + '">' + mm+ '</option>');
		}

		// 일별 selectbox 만들기
		for (var i = 1; i <= 31; i++) {
			var dd = i > 9 ? i : "0" + i;
			$('#day').append('<option value="' + dd + '">' + dd+ '</option>');
		}

		// 기존 정보 가져와서 기본 값으로 설정
		var birthdate = $('input[name=b_birthdate]').val();
		var year = birthdate.substring(0, 4);
		var mon = birthdate.substring(4, 6);
		var day = birthdate.substring(6, 8);

		$("#year  > option[value=" + year + "]").attr("selected", "true");
		$("#month  > option[value=" + mon + "]").attr("selected", "true");
		$("#day  > option[value=" + day + "]").attr("selected","true");

		/* $('#birthdate').attr('value',year+mon+day); */
	});
</script>



</head>
<body>

    <div class="wrap">
        <!--header(헤더)-->
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
        <div class="container">
            <div class="naviSide">
                <ul class="side_menu">
                    <li><a href="/myPage/memberInfoPage.do">마이 페이지</a>
                        <ul class="side_submenu">
                            <li><a href="/myPage/memberInfoPage.do">회원 정보</a></li>
                            <li><a href="/myPage/dogInfoPage.do">반려견 정보</a></li>
                        </ul>
                    </li>
                    <li><a href="/myPage/diaryPage.do">내 반려견 일기</a></li>
                </ul>

            </div>
            <div class="content">
                <p>회원 정보 수정</p>
                <form action="/myPage/updateMemberInfo.do" method="post" onsubmit="return updateMemberInfo();" enctype="multipart/form-data"  >
                
	                <div class="img">
	                	<c:set var="memberProfile" value="${sessionScope.member.memberProfile }" />
						<c:choose>
							<c:when test="${memberProfile==null ||fn:contains(memberProfile,'null') }">
								<img id="user_icon" src="/resources/images/user_icon.png" onclick="profileUpload()"></img>
							</c:when>
							<c:otherwise>
								<img id="user_icon" src="/resources/upload/memberProfile/${sessionScope.member.memberProfile }" onclick="profileUpload()"></img>
							</c:otherwise>
						</c:choose>
	                </div>
	                <input type=file name='profileFile' style='display: none;' onchange="readURL(this);">
	          				 
	          		
	                <!--수정 폼-->
	                <div class="user_info_modify_table">
	                    <table>
	                        <tr>
	                            <td width='90px'>아이디</td>
	                            <td>${sessionScope.member.memberId }</td>
	                        </tr>
	                        <tr>
	                            <td>닉네임<span>*</span></td>
	                            <td>
	                            	<input type="text" onfocus="input_txt(this)" onkeyup="check(this)"  name="nickname" value="${sessionScope.member.nickname }">
	                            	<p class="txt_guide">
	                                    <span id="nicknameCheck">* 한글 또는 영문 최대 8글자로 입력해 주세요.</span><br>
	                                </p>
	                            </td>
	                        </tr>
	                        <tr>
	                            <td>성별<span>*</span></td>
	                            <td>
	                            	
	                            	<c:choose>
	                            		<c:when test="${sessionScope.member.gender=='M' }">
	                            			<label><input type="radio" name="gender" value="M" checked>남</label> <label><input type="radio" name="gender" value="F" >여</label>	
	                            		</c:when>
	                            		<c:otherwise>
	                            			<label><input type="radio" name="gender" value="M" >남</label> <label><input type="radio" name="gender" value="F"  checked>여</label>
	                            		</c:otherwise>
	                            	</c:choose>
	                            	
	                            </td>
	                        </tr>
	                        <tr>
	                            <td>이메일<span>*</span></td>
	                            <td>
	                            	<input type="email" name="email" onfocus="input_txt(this)" onkeyup="check(this)" value="${sessionScope.member.email }">
	                            	<p class="txt_guide">
	                                    <span id="emailCheck">* 이메일 형식으로 입력해주세요.</span><br>
	                                </p>
	                            </td>
	                        </tr>
	                        <tr>
	                            <td>생년월일</td>
	                            <td>
	                            	<select name="yy" id="year" class="birthdate">
	                            		<option value="" selected hidden>--</option>
		        						<option value="">--</option>
		        					</select>년 &nbsp;
           							<select name="mm" id="month" class="birthdate">
	                            		<option value="" selected hidden>--</option>
		        						<option value="">--</option>           							
           							</select>월 &nbsp;
            						<select name="dd" id="day" class="birthdate">
	                            		<option value="" selected hidden>--</option>
		        						<option value="">--</option>            						
            						</select>일 &nbsp;
            						<!-- <input type="text" id="birthdate" name="birthdate" value="" style="display:none;"> -->
            						<input type="text" id="birthdate" name="b_birthdate" value="${sessionScope.member.birthdate }" style="display:none;">
	                            </td>
	                        </tr>
	                        
	                        <tr>
	                            <td>주소</td>
	                            <td><input type="text" id="address_kakao" name="address" value="${sessionScope.member.address }"></td>
	                        </tr>
	                        <tr>
	                            <td>상세주소</td>
	                            <td><input type="text" name="addressDetail" value="${sessionScope.member.addressDetail }"></td>
	                        </tr>
	                    </table>
	                </div>
	
	                <div class="btn">
	                	<input type="submit" class="modify_fin_btn" value="수정">
	                    <button type="button" class="cancel_btn"><a href="/myPage/memberInfoPage.do">취소</a></button>
	                </div>
	                
                </form>
            </div>
        </div>
        <!-- footer(푸터) -->
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
    </div>

</body>
</html>