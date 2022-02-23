<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의 댕댕 ｜ 가입 완료</title>
<link rel="stylesheet" type="text/css" href="/resources/css/welcomeJoin.css">
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>

	  <div class="form">
	    <form class="login-form">
		   <div class="icon_box">
		   	<img id="check_icon" src="/resources/images/check_icon.png"></img>
		   </div>
		   <br>
			 ${sessionScope.member.nickname}님 가입을 환영합니다!<br>
	    </form>
	  </div>
	  
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>