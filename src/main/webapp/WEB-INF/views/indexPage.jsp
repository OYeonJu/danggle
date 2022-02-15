<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의 댕댕</title>
<link rel="stylesheet" type="text/css"
	href="/resources/css/indexPage.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<!-- JQuery 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>

</head>
<body>
	<div class="wrap">

		<!--header(헤더)-->
		<%@ include file="/WEB-INF/views/common/header.jsp"%>

		<!--container(컨테이너)-->
		<div class="container">
			<div class="content" id="cal"></div>
			<div class="content" id="community"></div>
			<div class="content" id="hospital"></div>

		</div>
		
		<!-- footer(푸터) -->
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
</body>
</html>