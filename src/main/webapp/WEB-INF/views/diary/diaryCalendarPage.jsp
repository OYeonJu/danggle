<%@page import="java.awt.print.Printable"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.todaydaeng.diary.model.vo.Diary"%>
<%@page import="java.util.Calendar"%>
<%@page import="kr.co.todaydaeng.common.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- JSTL 라이브러리 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 반려견 일기</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <!-- JQuery 라이브러리 -->
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="/resources/css/diaryCalendarPage.css">
    
    <style>
        

    </style>
    
    <script>
    	function today(){
    		var yearNow=${requestScope.cal.yearNow};
    		var monthNow=${requestScope.cal.monthNow};
    		var dateNow=${requestScope.cal.dateNow};
    		var dogNo=${requestScope.dog.dogNo};
    		
    		location.replace("/diary/diaryCalendarPage.do?dogNo="+dogNo);
    		
    	}
    </script>

	<!-- 달력 크기 조절 이벤트 -->
    <script>
        $(document).ready(function() {
        	
        	// 오늘 날짜에 표시
        	var yearNow=${requestScope.cal.yearNow};
    		var monthNow=${requestScope.cal.monthNow};
    		var dateNow=${requestScope.cal.dateNow};
    		
    		var year=${requestScope.cal.year};
    		var month=${requestScope.cal.month};
    		var dogNo=${requestScope.dog.dogNo};
        	
        	if(yearNow==year&&monthNow==month){
        		select(document.getElementById('${requestScope.cal.dateNow}'));
        	}
        	
        	
        	
            $('.eventBtn').click(function() {
                if ($(this).attr('name') == 'open') {
                    $('.calendar').css("width", "100%");
                    $('.content').css("display", "none");
                    $(this).attr('name', 'close')
                } else {
                    $('.calendar').css("width", "70%");
                    $('.content').css("display", "block");
                    $(this).attr('name', 'open')
                }
            });
        });

    </script>
    
    <!-- 일기 기록 가져 오기 -->
	<script>
		function select(val) {
			var year = ${requestScope.cal.year}
			var month = ${requestScope.cal.month}
			var date=val.innerText;
			var dogNo=${requestScope.dog.dogNo};
				
			$('.date').css('border', 'none');
			$(val).css('border', '1px solid #FD6F22');
				
			$.ajax({
				url:"/diary/selectDiary.do",
				data:{"year":year,"month":month, "date":date,"dogNo":dogNo},
				type:"get",
				success:function(diary){
					if(diary.length!=0){	// 작성한 일기가 있을때
						$('input[name=weight]').val(diary.weight);
						$('input[name=feedName]').val(diary.feedName);
						if(diary.feedType !='\u0000'){
							$('input[name=feedType][value='+diary.feedType+']').prop('checked', true);
						}else{
							$('input[name=feedType]').prop('checked', false);
						}
						$('input[name=feedAmount]').val(diary.feedAmount);
						$('input[name=waterAmount]').val(diary.waterAmount);
						if(diary.snackYN != '\u0000'){
							$('input[name=snackYN][value='+diary.snackYN+']').prop('checked', true);							
						}else{
							$('input[name=snackYN]').prop('checked', false);
						}
						
						if(diary.healthFoodYN != '\u0000'){
							
							$('input[name=healthFoodYN][value='+diary.healthFoodYN+']').prop('checked', true);
						}else{
							$('input[name=healthFoodYN]').prop('checked', false);
						}
						$('input[name=walk]').val(diary.walk);
						$('textarea').val(diary.memo);
						
						$('#submit').attr("onclick", 'updateDiary()');
						$('#submit').attr("diaryNo", ""+diary.diaryNo+"");
						$('#submit').attr("date", ""+date+"");
						$('#submit').html('수정');
						$('#delete').css('display','inline');
						
						
					}else{	// 작성한 일기가 없을때
						$('input[name=weight]').val('');
						$('input[name=feedName]').val('');
						$('input[name=feedType]').prop('checked', false);
						$('input[name=feedAmount]').val('');
						$('input[name=waterAmount]').val('');
						$('input[name=snackYN]').prop('checked', false);
						$('input[name=healthFoodYN]').prop('checked', false);
						
						$('input[name=walk]').val('');
						$('textarea').val('');
						
						$('#submit').attr("onclick", 'insertDiary()');
						$('#submit').attr("date", ""+date+"");
						$('#submit').html('등록');
						$('#delete').css('display','none');
					}
				},
				error:function(){
					console.log('ajax통신 실패');
				}
			});
		};
	</script>
	
	<script>
		/* 일기 기록이 있는 경우 -> 기존 일기 수정*/
		function updateDiary(){
			var weight=$('input[name=weight]').val();
			var feedName=$('input[name=feedName]').val();
			var feedType=$('input[name=feedType]:checked').val();
			var feedAmount=$('input[name=feedAmount]').val();
			var waterAmount=$('input[name=waterAmount]').val();
			var snackYN=$('input[name=snackYN]:checked').val();
			var healthFoodYN=$('input[name=healthFoodYN]:checked').val();
			var walk=$('input[name=walk]').val();
			var memo=$('textarea').val();
			var diaryNo=$('#submit').attr('diaryNo');
			
			var data={
				"weight":weight,
				"feedName":feedName,
				"feedType":feedType,
				"feedAmount":feedAmount,
				"waterAmount":waterAmount,
				"snackYN":snackYN,
				"healthFoodYN":healthFoodYN,
				"walk":walk,
				"memo":memo,
				"diaryNo":diaryNo
			};
			
			
			$.ajax({
				url:"/diary/updateDiary.do",
				type:"post",
				data:data,
				success:function(result){
					if(result=='true'){
						alert('일기 수정 완료');
						window.location.reload();
					}else{
						alert('일기 수정 실패\n- 지속적인 문제 발생시 관리자에게 문의해주세요 -');
					}
					
				},
				error:function(){
					console.log('ajax 통신 실패');
				}
			});
		}
		
		/* 일기 기록이 없는 경우 -> 일기 삽입*/
		function insertDiary(){
			var year = ${requestScope.cal.year}
			var month = ${requestScope.cal.month}
			var date=$('#submit').attr('date');
			
			var weight=$('input[name=weight]').val();
			var feedName=$('input[name=feedName]').val();
			var feedType=$('input[name=feedType]:checked').val();
			var feedAmount=$('input[name=feedAmount]').val();
			var waterAmount=$('input[name=waterAmount]').val();
			var snackYN=$('input[name=snackYN]:checked').val();
			var healthFoodYN=$('input[name=healthFoodYN]:checked').val();
			var walk=$('input[name=walk]').val();
			var memo=$('textarea').val();
			var dogNo=${requestScope.dog.dogNo};
			
			
			var feedTypeCheck=$('input[name=feedType]:checked').length;
			var snackYNCheck=$('input[name=snackYN]:checked').length;
			var healthFoodYNCheck=$('input[name=healthFoodYN]:checked').length;
			
			
			
			if(weight==''&&feedName==''&&feedTypeCheck==0&&feedAmount==''&&waterAmount==''&&snackYNCheck==0&&healthFoodYNCheck==0&&walk==''&&memo==''){
				alert('하나는 입력해주셔야 합니다.');
				return false;
			}
			
			var data={
				"year":year,
				"month":month,
				"date":date,
				"weight":weight,
				"feedName":feedName,
				"feedType":feedType,
				"feedAmount":feedAmount,
				"waterAmount":waterAmount,
				"snackYN":snackYN,
				"healthFoodYN":healthFoodYN,
				"walk":walk,
				"memo":memo,
				"dogNo":dogNo
			};
			
			$.ajax({
				url:"/diary/insertDiary.do",
				type:"post",
				data:data,
				success:function(result){
					if(result=='true'){
						alert('일기 등록 완료');
						window.location.reload();
					}else{
						alert('일기 등록 실패\n- 지속적인 문제 발생시 관리자에게 문의해주세요 -');
					} 
				},
				error:function(){
					console.log('ajax 통신 실패');
				}
			});
		} 
		
		/* 일기 삭제 */
		function deleteDairy(){
			var year = ${requestScope.cal.year}
			var month = ${requestScope.cal.month}
			var date=$('#submit').attr('date');
			var diaryNo=$('#submit').attr('diaryNo');
			
			var data={
				"year":year,
				"month":month,
				"date":date,
				"diaryNo":diaryNo
			};
			
			
			if(confirm('정말로 삭제 하시겠습니까?\n- 삭제시 절대 복구 불가 -')){
				$.ajax({
					url:"/diary/deleteDiary.do",
					type:"post",
					data:data,
					success:function(result){
						if(result=='true'){
							alert('일기 삭제 완료');
							window.location.reload();
						}else{
							alert('일기 삭제 실패\n- 지속적인 문제 발생시 관리자에게 문의해주세요 -');
						} 
					},
					error:function(){
						console.log('ajax 통신 실패');
					}
				});
			};
		}
	</script>
    <jsp:useBean id="util" class="kr.co.todaydaeng.common.Util"/>
</head>
<body>
   <div class="wrap">

        <!--header(헤더)-->
		<%@ include file="/WEB-INF/views/common/header.jsp"%>

        <!--container(컨테이너)-->
        <div class="container">
            <p>내 반려견 일기</p>
            

            <div class="dogInfo">
                <div class="imgDiv">
                    <div class="img">
                    	<c:set var="dogProfile" value="${requestScope.dog.dogProfile }"/>
						<c:choose>
							<c:when test="${fn:contains(dogProfile,'null') }">
								<img src="/resources/upload/dogProfile/dog_default.jpg"></img>
							</c:when>
							<c:otherwise>
								<img src="/resources/upload/dogProfile/${requestScope.dog.dogProfile }"></img>
							</c:otherwise>
						</c:choose>
                    </div>
                </div>
                <div class="infoDiv">
                    <table class="info">
                        <tr>
                            <td>이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름 : </td>
                            <td>${requestScope.dog.dogName }</td>
                            <td>성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;별 : </td>
                            <td>
								<c:choose>
									<c:when test="${requestScope.dog.gender=='M'.charAt(0) }">
										남아			
									</c:when>
									<c:otherwise>
										여아
									</c:otherwise>
								</c:choose>
							</td>
                            <td>생&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;일 : </td>
                            <td>
                            	<c:set value="${requestScope.dog.birthdate }" var="birthdate"/>
								${fn:substring(birthdate,0,4) }/${fn:substring(birthdate,4,6) }/${fn:substring(birthdate,6,8) }
                            </td>
                        </tr>
                        <tr>
                            <td>품&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;종 : </td>
                            <td>${requestScope.dog.breed }</td>
                            <td>사&nbsp;&nbsp;&nbsp;&nbsp;이&nbsp;&nbsp;&nbsp;&nbsp;즈 : </td>
                            <td>${requestScope.dog.dogSize }</td>
                            <td>중성화 유무 : </td>
                            <td>
								<c:choose>
									<c:when test="${requestScope.dog.neutralizationYN =='Y'.charAt(0)}">
										완료
									</c:when>
									<c:otherwise>
										미완료
									</c:otherwise>
								</c:choose>
							</td>
                            <td>접종 &nbsp;&nbsp;유무 : </td>
                            <td>
                            	<c:choose>
									<c:when test="${requestScope.dog.vaccinationYN =='Y'}">
										완료
									</c:when>
									<c:when test="${requestScope.dog.vaccinationYN =='N'}">
										미완료
									</c:when>
									<c:otherwise>
										진행중
									</c:otherwise>
								</c:choose>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="diary">
                <div class="calendar">
                    <div class="btn">
                    	<div class="today" onclick="today()">Today</div>
                        <div class="eventBtnDiv" name="open">
                            <img src="/resources/images/menu.png" class="eventBtn">
                        </div>
                    </div>
                    <div class="calendarInfo">
                    	<div class="yearDate">
							<a href="/diary/diaryCalendarPage.do?year=${requestScope.cal.year-1}&month=${requestScope.cal.month}&dogNo=${requestScope.dog.dogNo}">◁</a>
							<a href="/diary/diaryCalendarPage.do?year=${requestScope.cal.year}&month=${requestScope.cal.month-1}&dogNo=${requestScope.dog.dogNo}">◀</a>
							<span>${requestScope.cal.year}년 ${requestScope.cal.month}월</span>
							<a href="/diary/diaryCalendarPage.do?year=${requestScope.cal.year}&month=${requestScope.cal.month+1}&dogNo=${requestScope.dog.dogNo}">▶</a>
							<a href="/diary/diaryCalendarPage.do?year=${requestScope.cal.year+1}&month=${requestScope.cal.month}&dogNo=${requestScope.dog.dogNo}">▷</a>
						</div>
						<table  id="calendar">
							
							<tr>
								<th>일</th>
								<th>월</th>
								<th>화</th>
								<th>수</th>
								<th>목</th>
								<th>금</th>
								<th>토</th>
							</tr>
							<tr>
								<%-- 달력에 시작하는 공백 출력 --%>
								<%-- 공백 출력하는 for 문 --%>
								<c:forEach var="i" begin="1" end="${requestScope.cal.dayOfWeek-1 }">
									<td>&nbsp;</td>
								</c:forEach>
								
								<%-- 날짜 출력하는 for 문 --%>
								<c:forEach var="i" begin="1" end="${requestScope.cal.lastDay }">
									<td>
										<div class="date" onclick="select(this)" id="${i }">
											${i }
											
											<%-- 일기 있는 날짜에 표시 --%>
											<c:set var="list" value="${requestScope.list }"/>
											<%
											ArrayList<Diary> list=(ArrayList<Diary>)request.getAttribute("list");
											int i=(int)pageContext.getAttribute("i");
											
											
											out.print(util.getCalViewList(i, list));
											%>
											
										</div>
									</td>
									
									<%-- 행을 바꿔주기 -> 현재일(i)이 토요일인지 확인 : (공백수+현재날짜)의 값이 7로 나눠 떨어지면 7의 배수 --%>
									<c:if test="${((requestScope.cal.dayOfWeek-1+i)%7)==0 }">
										</tr><tr>
									</c:if> 
									
									
								</c:forEach>
								
								
								<%-- 나머지 공백 출력하는 for문  --%>
								<c:set var="countNbsp" value="${(7-(requestScope.cal.dayOfWeek-1+requestScope.cal.lastDay)%7)%7 }"/>
								
								<c:forEach begin="0" end="${countNbsp }">
								
									<td>&nbsp;</td>
								</c:forEach> 
							</tr>
						</table>
                    </div>
                </div>
                <div class="content">
                    <div class="btn"></div>
                    <table class="contentInfo">
                        <tr>
                            <td>몸무게</td>
                            <td><input type="text" name="weight"> kg</td>
                        </tr>
                        <tr>
                            <td>사료이름</td>
                            <td><input type="text" name="feedName"></td>
                        </tr>
                        <tr>
                            <td>사료 타입 </td>
                            <td><label><input type="radio" name="feedType" value="W"> 습식</label> <label><input type="radio" name="feedType" value="D"> 건식</label></td>
                        </tr>
                        <tr>
                            <td>사료량</td>
                            <td><input type="text" name="feedAmount"> g</td>
                        </tr>
                        <tr>
                            <td>음수량</td>
                            <td><input type="text" name="waterAmount"> ml</td>
                        </tr>
                        <tr>
                            <td>간식 여부 </td>
                            <td><label><input type="radio" name="snackYN" value="Y"> 급여</label> <label><input type="radio" name="snackYN" value="N"> 미급여</label></td>
                        </tr>
                        <tr>
                            <td>영양제 여부</td>
                            <td><label><input type="radio" name="healthFoodYN" value="Y"> 급여</label> <label><input type="radio" name="healthFoodYN" value="N"> 미급여</label></td>
                        </tr>
                        <tr>
                            <td>산책 시간</td>
                            <td><input type="text" name="walk"> 분</td>
                        </tr>
                        <tr>
                            <td colspan="2">일기</td>
                        </tr>
                        <tr>
                            <td colspan="2"><textarea rows="5" cols="45" name="memo"></textarea></td>
                        </tr>
                    </table>
                    <div class="btnDiv">
                        <button type="button" id="submit">등록</button>
                        <button type="button" id="delete" onclick="deleteDairy()">삭제</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- footer(푸터) -->
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
    </div>
</body>
</html>