<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/resources/css/header.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function index() {
		location.replace('/');
	}

</script>


</head>
<body>

        <div class="header">
	        <div class="headerfixed">
	            <div class="logo">
	                <div class="logoImg" onclick="index()"></div>
	            </div>
	            <div class="navi">
	                <div class="empty"></div>
	                <div class="naviText">
	                    <ul>
	                        <li><a href='/myPage/diaryPage.do'>내 반려견 일기</a></li>
	                        <li><a href='/board/community.do'>커뮤니티</a></li>
	                        <li><a href='/hospital/hospitalInfo.do'>동물병원 찾기</a></li>
	                    </ul>
	                </div>
	                <div class="empty">
	                	<c:choose>
	                		<c:when test="${sessionScope.member != null }">
	                			<ul>
			                        <li>
			                            <div class='login'><a href="/myPage/memberInfoPage.do">${sessionScope.member.nickname }</a></div>
			                        </li>
			                        <li>
			                            <div class='enroll'><a href="/member/logout.do">로그아웃</a></div>
			                        </li>
			                    </ul>
	                		</c:when>
	                		<c:otherwise>
	                			<ul>
			                        <li>
			                            <div class='login'><a href="/resources/staticViews/member/login.jsp">로그인</a></div>
			                        </li>
			                        <li>
			                            <div class='enroll'><a href="/resources/staticViews/member/join.jsp">회원 가입</a></div>
			                        </li>
			                    </ul>
	                		</c:otherwise>
	                	</c:choose>
	                    
	                </div>
	            </div>
            </div>
        </div>

</body>
</html>