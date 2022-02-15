<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의 댕댕 ｜ 휴면계정</title>
<link rel="stylesheet" type="text/css" href="/resources/css/dormantMember.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

	  <div class="form">
	    <form class="login-form" action="/wakeUpDormantMember.do" method="post">
	      <h2>휴면 계정 안내</h2>
	      ${requestScope.member.memberId}님은 1년 이상 로그인하지 않아<br> 휴면 상태로 전환되었습니다.<br><br>
	      <input type="hidden" name="memberId" value="${requestScope.member.memberId}">
	      <input type="hidden" name="memberPwd" value="${requestScope.member.memberPwd}">
	      	<!--  마지막 접속일 :${requestScope.m.loginDate} <br>--> 
	      	휴면 해제 후 서비스를 이용하실 수 있습니다.
	      <button type="submit">휴면 해제하기</button><br>
	    </form>
	  </div>
	  
	  <%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>