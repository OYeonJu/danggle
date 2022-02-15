<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- JSTL 라이브러리 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반려견 정보 등록</title>
<!-- JQuery 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/resources/css/updateDogInfoPage.css">

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

<!-- 생년월일 -->
<script>
	$(document)
			.ready(
					function() {
						var now = new Date();
						var year = now.getFullYear();
						var mon = (now.getMonth() + 1) > 9 ? ''
								+ (now.getMonth() + 1) : '0'
								+ (now.getMonth() + 1);
						var day = (now.getDate()) > 9 ? '' + (now.getDate())
								: '0' + (now.getDate());
						//년도 selectbox만들기               
						for (var i = 1900; i <= year; i++) {
							$('#year').append(
									'<option value="' + i + '">' + i
											+ '</option>');
						}

						// 월별 selectbox 만들기            
						for (var i = 1; i <= 12; i++) {
							var mm = i > 9 ? i : "0" + i;
							$('#month').append(
									'<option value="' + mm + '">' + mm
											+ '</option>');
						}

						// 일별 selectbox 만들기
						for (var i = 1; i <= 31; i++) {
							var dd = i > 9 ? i : "0" + i;
							$('#day').append(
									'<option value="' + dd + '">' + dd
											+ '</option>');
						}

						// 기존 정보 가져와서 기본 값으로 설정
						var birthdate = $('input[name=b_birthdate]').val();
						var year = birthdate.substring(0, 4);
						var mon = birthdate.substring(4, 6);
						var day = birthdate.substring(6, 8);

						$("#year  > option[value=" + year + "]").attr(
								"selected", "true");
						$("#month  > option[value=" + mon + "]").attr(
								"selected", "true");
						$("#day  > option[value=" + day + "]").attr("selected",
								"true");

						/* $('#birthdate').attr('value',year+mon+day); */
					})
</script>


<script>
	$(document).ready(
			function() {
				var dogSize = $('#dogSizeBefore').val();
				$("#dogSize  > option[value=" + dogSize + "]").attr("selected",
						"true");
				
				<!-- 취소 버튼 클릭시 반려견 정보 페이지 호출 -->
				$('.cancelBtn')
				.click(
						function() {
							location
									.replace("/myPage/dogInfoPage.do?currentPage=${requestScope.currentPage}");
						});
			});
</script>

<!-- 유효성 검사 -->
<script>
	function checkForm() {
		var dogName = $('input[name=dogName]').val();
		var breed = $('input[name=breed]').val();

		if (dogName == "") {
			alert('이름을 입력해 주세요.');
			$('input[name=dogName]').css('border', '2px solid #FD6F22');
			return false;
		}
		if (breed == "") {
			alert('품종을 입력해 주세요.');
			$('input[name=breed]').css('border', '2px solid #FD6F22');
			return false;
		}
	}

	$('input[name=dogName]').click(function() {
		$(this).css('border', '1px solid #919CA7');
	});
	$('input[name=breed]').click(function() {
		$(this).css('border', '1px solid #919CA7');
	});
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
				<p>반려견 정보 등록</p>

				<!--메인 컨텐츠-->
				<div class='contentCenter'>
					<div class="contentCenterInner">

						<!--등록-->
						<div class='dogInfo'>
							<form action="/myPage/updateDogInfo.do" method="post"
								enctype="multipart/form-data" onsubmit="return checkForm();">
								<div class='dogImg'>
									<c:set var="dogProfile" value="${requestScope.dog.dogProfile }" />
									<c:choose>
										<c:when test="${fn:contains(dogProfile,'null') }">
											<img id="user_icon"
												src="/resources/upload/dogProfile/dog_default.jpg"
												onclick="profileUpload()"></img>
										</c:when>
										<c:otherwise>
											<img id="user_icon"
												src="/resources/upload/dogProfile/${requestScope.dog.dogProfile }"
												onclick="profileUpload()"></img>
										</c:otherwise>
									</c:choose>
								</div>

								<input type=file name='profileFile' style='display: none;'
									onchange="readURL(this);">

								

								<div class='dogInfoText'>
									<table>
										<tr>
											<td>이름</td>
											<td><input type="text" name="dogName"
												value="${requestScope.dog.dogName }"> <input
												type="text" name="dogNo" value="${requestScope.dog.dogNo }"
												style="display: none;"> <input type="text"
												name="currentPage" value="${requestScope.currentPage }"
												style="display: none;"></td>
										</tr>
										<tr>
											<td>성별</td>
											<td><c:choose>
													<c:when test="${requestScope.dog.gender=='M'.charAt(0) }">
														<label><input type="radio" name="gender" value="M"
															checked>남</label>
														<label><input type="radio" name="gender" value="F">여</label>
													</c:when>
													<c:otherwise>
														<label><input type="radio" name="gender" value="M">남</label>
														<label><input type="radio" name="gender" value="F"
															checked>여</label>
													</c:otherwise>
												</c:choose></td>
										</tr>
										<tr>
											<td>생일</td>
											<td><select name="yy" id="year" class="birthdate"></select>년
												&nbsp; <select name="mm" id="month" class="birthdate"></select>월
												&nbsp; <select name="dd" id="day" class="birthdate"></select>일
												&nbsp; <!-- <input type="text" id="birthdate" name="birthdate" value="" style="display:none;"> -->
												<input type="text" id="birthdate" name="b_birthdate"
												value="${requestScope.dog.birthdate }"
												style="display: none;"></td>
										</tr>
										<tr>
											<td>품종</td>
											<td><input type="text" name="breed"
												value="${requestScope.dog.breed }"></td>
										</tr>
										<tr>
											<td>사이즈</td>
											<td><select name="dogSize" id="dogSize">
													<option value="소형견">소형견 (10kg 이하)</option>
													<option value="중형견">중형견 (11kg ~ 25kg)</option>
													<option value="대형견">대형견 (26kg 이상)</option>
											</select> <input type="text" value="${requestScope.dog.dogSize }"
												id="dogSizeBefore" style="display: none;"></td>
										</tr>

										<tr>
											<td>접종 유무</td>
											<td><c:choose>
													<c:when test="${requestScope.dog.vaccinationYN=='Y' }">
														<label><input type="radio" name="vaccinationYN"
															value="Y" checked>완료</label>
														<label><input type="radio" name="vaccinationYN"
															value="ING">진행중</label>
														<label><input type="radio" name="vaccinationYN"
															value="N">미완료</label>
													</c:when>
													<c:when test="${requestScope.dog.vaccinationYN=='N' }">
														<label><input type="radio" name="vaccinationYN"
															value="Y">완료</label>
														<label><input type="radio" name="vaccinationYN"
															value="ING">진행중</label>
														<label><input type="radio" name="vaccinationYN"
															value="N" checked>미완료</label>
													</c:when>
													<c:otherwise>
														<label><input type="radio" name="vaccinationYN"
															value="Y">완료</label>
														<label><input type="radio" name="vaccinationYN"
															value="ING" checked>진행중</label>
														<label><input type="radio" name="vaccinationYN"
															value="N">미완료</label>
													</c:otherwise>
												</c:choose></td>
										</tr>
										<tr>
											<td>중성화 유무</td>
											<td><c:choose>
													<c:when
														test="${requestScope.dog.neutralizationYN=='Y'.charAt(0) }">
														<label><input type="radio" name="neutralizationYN"
															value="Y" checked>완료</label>
														<label><input type="radio" name="neutralizationYN"
															value="N">미완료</label>
													</c:when>
													<c:otherwise>
														<label><input type="radio" name="neutralizationYN"
															value="Y">완료</label>
														<label><input type="radio" name="neutralizationYN"
															value="N" checked>미완료</label>
													</c:otherwise>
												</c:choose></td>
										</tr>

									</table>

								</div>

								<div class="btn">
									<input type="submit" value="등록" class="enrollBtn">
									<button type="button" class="cancelBtn">취소</button>
								</div>


							</form>
						</div>

					</div>

				</div>
			</div>
		</div>
		<!-- footer(푸터) -->
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>

</body>
</html>