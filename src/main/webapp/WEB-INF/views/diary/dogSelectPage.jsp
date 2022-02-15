<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- JSTL 라이브러리 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반려견 정보</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<!-- JQuery 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>	

<style>
* {
	box-sizing: border-box;
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 15px;
	font-weight: bold;
	color: #919CA7;
}

.wrap {
	/*border: 1px solid red;*/
	width: 100%;
	height: 1592px;
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
	border: 1px solid black;
	width: 1440px;
	height: 1117px;
	margin: 0 auto;
}

/*사이드 네비*/
.navi {
	border: 1px solid #eef2f7;
	width: 268px;
	height: 900px;
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

.side_menu>li:nth-child(2)>a {
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
	height: 900px;
	position: relative;
	top: 105px;
	border-radius: 5px;
	float: right;
	background: #FFFFFF;
	text-align: center;
	filter: drop-shadow(4px 4px 4px rgba(0, 0, 0, 0.10));
}

/*제목*/
.content>p {
	font-size: 25px;
	margin: 0;
	position: relative;
	top: 64px;
	color: #000000;
}


/*메인 컨텐츠 div*/
.contentCenter {
	/*border: 1px solid red;*/
	width: 890px;
	height: 700px;
	margin: 0 auto;
	position: relative;
	top: 110px;
}

.contentCenterInner {
	/*border: 1px solid yellow;*/
	width: 100%;
	height: 90%;
	/* text-align: center;*/
	display: flex;
	justify-content: center;
}

.dogInfo {
	width: 400px;
	height: 589px;
	border: 1px solid #919CA7;
	box-shadow: 4px 4px 4px rgba(0, 0, 0, 0.1);
	border-radius: 5px;
	/*float: left;*/
	margin: 0 20px;
	/*display: inline-block;*/
}

.dogImg {
	width: 100%;
	height: 190px;
	border: 1px solid #919CA7;
	border-radius: 5px 5px 0px 0px;
}

img{
	width: 100%;
	height: 100%;
	object-fit: fill;
	border-radius: 5px 5px 0px 0px;
}

.dogInfoText {
	/*border: 1px solid blue;*/
	width: 100%;
	height: 398px;
	border-radius: 0px 0px 5px 5px;
}

table {
	margin: 0 auto;
	position: relative;
	top: 10px;
}

td {
	text-align: left;
	height: 40px;
}

tr>td:first-child {
	width: 150px;
}

tr>td:last-child {
	/*padding-left: 15px;*/
	
}

.btn {
	/*border: 1px solid #FD6F22;*/
	position: relative;
	bottom: -30px;
	clear: both;
}

.select_btn {
	width: 67px;
	height: 40px;
	border: 1px solid #FD6F22;
	background-color: #FD6F22;
	border-radius: 5px;
	cursor: pointer;
	filter: drop-shadow(4px 4px 4px rgba(0, 0, 0, 0.10));
	margin: 0 13px;
}
.select_btn>a{
	color:#ffffff;
}

/*페이지 네비 div*/
.pageNavi {
	/* border: 1px solid blue; */
	position: relative;
	bottom: 0px;
	height: 50px;
	clear: both;
	text-align: center;
}

.pageNavi>span {
	font-size: 16px;
	line-height: 80px;
}

a{
	text-decoration: none;
}

/*footer(풋터)*/
.footer {
	border: 1px solid black;
	width: 100%;
	height: 235px;
	background-color: dimgrey;
}
</style>



</head>
<body>

	<div class="wrap">

		<!--header(헤더)-->
		<div class="header"></div>

		<!--container(컨테이너)-->
		<div class="container">

			<!--사이드 네비-->
			<div class="navi">
				<ul class="side_menu">
					<li><a href="/myPage/memberInfoPage.do">마이 페이지</a>
						<ul class="side_submenu">
							<li><a href="/myPage/memberInfoPage.do">회원 정보</a></li>
							<li><a href="/myPage/dogInfoPage.do">반려견 정보</a></li>
						</ul></li>
					<li><a href="/myPage/diaryPage.do">내 반려견 일기</a></li>
					
				</ul>

			</div>

			<!--컨텐츠-->
			<div class="content">
				<p>일기의 주인공을 선택해 주세요.<br>오늘은 무슨 일이 있었나요?</p>
				<!--메인 컨텐츠-->
				<div class='contentCenter'>
					<div class="contentCenterInner">

						<c:choose>
							<c:when test="${!requestScope.map.list.isEmpty() }">
								<c:forEach items="${requestScope.map.list }" var="d">
									<!--출력-->
									<div class='dogInfo'>
										<div class='dogImg'>
											<c:set var="dogProfile" value="${d.dogProfile }"/>
											<c:choose>
												<c:when test="${fn:contains(dogProfile,'null') }">
													<img src="/resources/upload/dogProfile/dog_default.jpg"></img>
												</c:when>
												<c:otherwise>
													<img src="/resources/upload/dogProfile/${d.dogProfile }"></img>
												</c:otherwise>
											</c:choose>
										</div>
										<div class='dogInfoText'>
											<table>
												<tr>
													<td>이름</td>
													<td>${d.dogName }</td>
												</tr>
												<tr>
													<td>성별</td>
													<td>
														<c:choose>
															<c:when test="${d.gender=='M'.charAt(0) }">
																남아			
															</c:when>
															<c:otherwise>
																여아
															</c:otherwise>
														</c:choose>
													</td>
												</tr>
												<tr>
													<td>생일</td>
													<td>
														<c:set value="${d.birthdate }" var="birthdate"/>
														${fn:substring(birthdate,0,4) }/${fn:substring(birthdate,4,6) }/${fn:substring(birthdate,6,8) }
													</td>
												</tr>
												<tr>
													<td>품종</td>
													<td>${d.breed }</td>
												</tr>
												<tr>
													<td>사이즈</td>
													<td>${d.dogSize }</td>
												</tr>
												<tr>
													<td>접종 유무</td>
													<td>
														<c:choose>
															<c:when test="${d.vaccinationYN =='Y'}">
																완료
															</c:when>
															<c:when test="${d.vaccinationYN =='N'}">
																미완료
															</c:when>
															<c:otherwise>
																진행중
															</c:otherwise>
														</c:choose>
													</td>
												</tr>
												<tr>
													<td>중성화 유무</td>
													<td>
														<c:choose>
															<c:when test="${d.neutralizationYN =='Y'.charAt(0)}">
																완료
															</c:when>
															<c:otherwise>
																미완료
															</c:otherwise>
														</c:choose>
													</td>
												</tr>
											</table>
											<div class="btn">
												<button class="select_btn"><a href="/diary/diaryCalendarPage.do?dogNo=${d.dogNo }">선택</a></button>
											</div>
										</div>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<h2>등록된 반려견 정보가 없습니다. 반려견 정보를 등록해주세요.</h2>
							</c:otherwise>
						</c:choose>

					</div>

					<div class="pageNavi">
						<span> ${map.pageNavi } </span>
					</div>


				</div>
			</div>
		</div>
		<div class="footer"></div>
	</div>


</body>
</html>