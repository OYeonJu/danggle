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

<link rel="stylesheet" type="text/css" href="/resources/css/dogInfoPage.css">

<!-- 반려견 정보 삭제 -->
<script>
window.onload=function(){
	$('.withdraw_btn').click(function(){
		var dogNo = $(this).attr('id');
															
		if(window.confirm('정말 삭제하시겠습니까?\n- 삭제시 복구 절대 불가 -')){
			$.ajax({
				url:"/myPage/deleteDogInfo.do",
				data:{"dogNo":dogNo},
				type:"post",
				success:function(result){
					if(result=='true'){
						alert("반려견 정보가 삭제 되었습니다");
						window.location.reload();
					}else{
						alert("반려견 정보 삭제에 실패하였습니다.\n- 지속적인 문제 발생시 관리자에게 문의해주세요 -");
						window.location.reload();
					}
				},
				error:function(){
					console.log('ajax 통신 실패');
				}
			});
		}
	});	
	
}

</script>



</head>
<body>

	<div class="wrap">

		<!--header(헤더)-->
		<%@ include file="/WEB-INF/views/common/header.jsp"%>

		<!--container(컨테이너)-->
		<div class="container">

			<!--사이드 네비-->
			<div class="naviSide">
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
				<p>반려견 정보</p>

				<div class="enrollDogInfo">
					<button type="button" class='enrollDogInfoBtn'>등록</button>
				</div>

				<!-- 반려견 정보 등록 페이지 호출 -->
				<script>
					$('.enrollDogInfoBtn').click(function(){
						location.replace("/myPage/insertDogInfoPage.do");
						
					});
				</script>


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
												<button class="modify_btn"><a href="/myPage/updateDogInfoPage.do?dogNo=${d.dogNo }&currentPage=${requestScope.currentPage}">수정</a></button>
												<button type="button" class="withdraw_btn" id="${d.dogNo }">삭제</button>
									
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
		<!-- footer(푸터) -->
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>


</body>
</html>