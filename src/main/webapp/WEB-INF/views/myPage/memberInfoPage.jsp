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

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">


<style>
* {
	box-sizing: border-box;
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 15px;
	font-weight: bold;
	color: #919CA7;
}

.wrap {
	border: 1px solid black;
	width: 100%;
	height: 1517px;
	background: #FAFBFE;
}

/*header(헤더)*/
.header {
	border: 1px solid black;
	width: 100%;
	height: 240px;
	background: #FFFFFF;
}

/*container(컨테이너)*/
.container {
	/*border: 1px solid black;*/
	width: 1440px;
	height: 1042px;
	margin: 0 auto;
}

/*사이드 네비*/
.navi {
	border: 1px solid #eef2f7;
	width: 268px;
	height: 825px;
	position: relative;
	top: 105px;
	border-radius: 5px;
	float: left;
	background: #FFFFFF;
	filter: drop-shadow(4px 4px 4px rgba(0, 0, 0, 0.10));
}

.side_menu {
	margin-top: 64px;
}

.side_menu>li {
	margin-bottom: 45px;
	list-style: none;
}

.side_menu>li>a {
	color: #919CA7;
	text-decoration: none;
}

.side_menu>li:first-child>a {
	color: #000000;
}

.side_menu>li:hover>a {
	color: #000000;
}

.side_menu>li:hover ul {
	display: block;
}

.side_submenu {
	padding-left: 15px;
	display: none;
}

.side_submenu>li {
	list-style: none;
	margin: 10px 0 10px 0;
}

.side_submenu>li>a {
	color: #919CA7;
	text-decoration: none;
	font-size: 13px;
}

.side_submenu>li:hover>a {
	color: #000000;
}

/*컨텐츠*/
.content {
	border: 1px solid #eef2f7;
	width: 1152px;
	height: 825px;
	position: relative;
	top: 105px;
	border-radius: 5px;
	float: right;
	background: #FFFFFF;
	text-align: center;
	filter: drop-shadow(4px 4px 4px rgba(0, 0, 0, 0.10));
}

.content>p {
	font-size: 25px;
	margin: 0;
	position: relative;
	top: 64px;
	color: #000000;
}

.img {
	border: 1px solid #eef2f7;
	background-color: #FD6F22;
	width: 121px;
	height: 116px;
	border-radius: 100%;
	position: relative;
	top: 130px;
	left: 515px;
}

img {
	width: 100%;
	height: 100%;
	object-fit: fill;
	border-radius: 100%;
	
}

/*출력 폼*/
.user_info_table {
	/* border: 1px solid red;*/
	width: 400px;
	height: 420px;
	position: relative;
	top: 157px;
	text-align: left;
	margin: 0 auto;
}

table tr td {
	height: 50px;
	/* vertical-align: top;*/
}

table tr td:last-child {
	padding-left: 34px;
}

.pwd_change_btn {
	border: 1px solid #FD6F22;
	background-color: #ffffff;
	width: 120px;
	height: 40px;
	border-radius: 5px;
	cursor: pointer;
	filter: drop-shadow(4px 4px 4px rgba(0, 0, 0, 0.10));
}

.modify_btn, .withdraw_btn {
	border: 1px solid #FD6F22;
	background-color: #ffffff;
	border-radius: 5px;
	cursor: pointer;
	filter: drop-shadow(4px 4px 4px rgba(0, 0, 0, 0.10));
}

.btn {
	/*border: 1px solid #FD6F22;*/
	position: relative;
	bottom: -180px;
}

.modify_btn {
	width: 67px;
	height: 35px;
	margin: 0 15px;
	filter: drop-shadow(4px 4px 4px rgba(0, 0, 0, 0.10));
}

.withdraw_btn {
	width: 80px;
	height: 35px;
	left: 1076px;
	margin: 0 15px;
	filter: drop-shadow(4px 4px 4px rgba(0, 0, 0, 0.10));
}

/*footer(풋터)*/
.footer {
	border: 1px solid black;
	width: 100%;
	height: 235px;
	background-color: dimgrey;
}
</style>

<script>
        /*수정 폼으로 변경*/
        function change_form() {

            var popupWidth = 500;
            var popupHeight = 300;

            var popupX = (window.screen.width / 2) - (popupWidth / 2);
            var popupY = (window.screen.height / 2) - (popupHeight);

            
            window.open("/myPage/checkPwdPage.do", '_blank', 'status=no,width=' + popupWidth + ', height=' + popupHeight + ',left=' + popupX + ',top=' + popupY);

        }

        /*비밀 번호 변경 팝업*/
        function pwd_change_page() {
            var popupWidth = 500;
            var popupHeight = 500;

            var popupX = (window.screen.width / 2) - (popupWidth / 2);
            var popupY = (window.screen.height / 2) - (popupHeight / 2);

            
            window.open("/myPage/pwdChangePage.do", '_blank', 'status=no,width=' + popupWidth + ', height=' + popupHeight + ',left=' + popupX + ',top=' + popupY);
        }
        
        /* 회원 탈퇴  */
        function withdraw_form(){
        	
        	if(window.confirm('탈퇴하시겠습니까? \n- 탈퇴시 복구 절대 불가능 -')){
        		 var popupWidth = 500;
                 var popupHeight = 300;

                 var popupX = (window.screen.width / 2) - (popupWidth / 2);
                 var popupY = (window.screen.height / 2) - (popupHeight);

                 
                 window.open("/myPage/withdrawCheckPage.do", '_blank', 'status=no,width=' + popupWidth + ', height=' + popupHeight + ',left=' + popupX + ',top=' + popupY);
        	}
        
        }

    </script>


</head>
<body>

	<div class="wrap">
		<div class="header"></div>
		<div class="container">
			<div class="navi">
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
						<c:when test="${fn:contains(memberProfile,'null') }">
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
						<tr>
							<td>비밀번호</td>
							<td><button class="pwd_change_btn"
									onclick="pwd_change_page()">비밀번호 변경</button></td>
						</tr>
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
							<td>생년월일</td>
							<td>
								<c:set value="${sessionScope.member.birthdate }" var="birthdate"/>
								${fn:substring(birthdate,0,4) }/${fn:substring(birthdate,4,6) }/${fn:substring(birthdate,6,8) }
							</td>
						</tr>
						<tr>
							<td>이메일</td>
							<td>${sessionScope.member.email }</td>
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
		<div class="footer"></div>
	</div>



</body>
</html>