<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!-- JQuery 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>
<link rel="stylesheet" type="text/css" href="/resources/css/memberInfoPage.css?d">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">


<style>

</style>

<script>
        /*수정 폼으로 변경*/
        function change_form() {

        	var authProvider='${sessionScope.member.authProvider }';
        	if(authProvider==''){
        		var popupWidth = 500;
                var popupHeight = 300;

                var popupX = (window.screen.width / 2) - (popupWidth / 2);
                var popupY = (window.screen.height / 2) - (popupHeight);

                
                window.open("/myPage/checkPwdPage.do", '_blank', 'status=no,width=' + popupWidth + ', height=' + popupHeight + ',left=' + popupX + ',top=' + popupY);
	
        	}else{
        		location.replace("/myPage/updateMemberInfoPage.do");	
        	}
            
            
        }

        /*비밀 번호 변경 팝업*/
        function pwd_change_page() {
            var popupWidth = 550;
            var popupHeight = 500;

            var popupX = (window.screen.width / 2) - (popupWidth / 2);
            var popupY = (window.screen.height / 2) - (popupHeight / 2);

            
            window.open("/myPage/pwdChangePage.do", '_blank', 'status=no,width=' + popupWidth + ', height=' + popupHeight + ',left=' + popupX + ',top=' + popupY);
        }
        
        /* 회원 탈퇴  */
        function withdraw_form(){
        	
        	var authProvider='${sessionScope.member.authProvider }';
        	
        	if(authProvider==''){
        		if(window.confirm('탈퇴하시겠습니까? \n- 탈퇴시 복구 절대 불가능 -')){
           		 	var popupWidth = 500;
                    var popupHeight = 300;

                    var popupX = (window.screen.width / 2) - (popupWidth / 2);
                    var popupY = (window.screen.height / 2) - (popupHeight);

                    
                    window.open("/myPage/withdrawCheckPage.do", '_blank', 'status=no,width=' + popupWidth + ', height=' + popupHeight + ',left=' + popupX + ',top=' + popupY);
	           	}
	
        	}else{
        		alert('소셜 로그인 고객은 해당 소셜에서 탈퇴 진행해주세요.');
        	}
        	
        	        
        }

    </script>


</head>
<body>

	<div class="wrap">
		<!--header(헤더)-->
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="container">
			<div class="naviSide">
				<ul class="side_menu">
					<li><a href="">마이 페이지</a>
						<ul class="side_submenu">
							<li><a href="/myPage/memberInfoPage.do">회원 정보</a></li>
							<li><a href="/myPage/dogInfoPage.do">반려견 정보</a></li>
						</ul></li>
					<li><a href="/myPage/diaryPage.do">내 반려견 일기</a></li>
				</ul>

			</div>
			<div class="content">
				<p>회원 정보</p>
				<div class="img" id="${sessionScope.member.memberProfile }">
					<c:set var="memberProfile"
						value="${sessionScope.member.memberProfile }" />
					<c:choose>
						<c:when test="${memberProfile==null ||fn:contains(memberProfile,'null') }">
							<img src="/resources/images/user_icon.png"></img>
						</c:when>
						<c:otherwise>
							<img src="/resources/upload/memberProfile/${sessionScope.member.memberProfile }"></img>
						</c:otherwise>
					</c:choose>
				</div>

				<!--출력 폼-->
				<div class="user_info_table">
					<table>
						<tr>
							<td width='90px'>아이디</td>
							<td>${sessionScope.member.memberId }</td>
						</tr>
						<c:if test="${sessionScope.member.authProvider=='' || sessionScope.member.authProvider==null}">
							<tr>
								<td>비밀번호</td>
								<td><button class="pwd_change_btn" onclick="pwd_change_page()">비밀번호 변경</button></td>
							</tr>
						</c:if>
						
						<tr>
							<td>닉네임</td>
							<td>${sessionScope.member.nickname }</td>
						</tr>
						<tr>
							<td>성별</td>
							<td>
								<c:choose>
									<c:when test="${sessionScope.member.gender=='M' }">
                            			남성
                            		</c:when>
									<c:otherwise>
	                            		여성
                            		</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td>이메일</td>
							<td>${sessionScope.member.email }</td>
						</tr>
						<tr>
							<td>생년월일</td>
							<td>
								<c:set value="${sessionScope.member.birthdate }" var="birthdate"/>
								<c:choose>
									<c:when test="${birthdate==null or birthdate==''}">
										<c:out value="${birthdate }"/>
									</c:when>
									<c:otherwise>
										${fn:substring(birthdate,0,4) }/${fn:substring(birthdate,4,6) }/${fn:substring(birthdate,6,8) }
									</c:otherwise>
								</c:choose>
								
							</td>
						</tr>
						<tr>
							<td>주소</td>
							<td>${sessionScope.member.address }</td>
						</tr>
						<tr>
							<td>상세주소</td>
							<td>${sessionScope.member.addressDetail }</td>
						</tr>
					</table>
				</div>

				<div class="btn">
					<button class="modify_btn" onclick="change_form()">수정</button>
					<button class="withdraw_btn" onclick="withdraw_form()">계정삭제</button>
				</div>
			</div>
		</div>
		<!-- footer(푸터) -->
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>



</body>
</html>