<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="crossorigin="anonymous"></script>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>

    <!-- App favicon -->
    <link rel="shortcut icon" href="/resources/images/favicon.ico">
    <!-- App css -->
    <link href="/resources/css/icons.min.css" rel="stylesheet" type="text/css"/>
    <link href="/resources/css/app-creative.min.css" rel="stylesheet" type="text/css" id="light-style"/>
	
</head>

<style>
    * {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #FAFBFE;
        font-weight: bold;
        color: #919CA7;
    }

    .wrap {
        width: 100%;
        margin: 0 auto;
        background-color: #FAFBFE;
        margin-bottom: 150px;
    }
    
    #select {
        border: 1px solid #FD6F22;
        border-radius: 5px;
        height: 27px
    }

    #search {
        border: 1px solid #FD6F22;
        box-sizing: border-box;
        border-radius: 5px;
        width: 200px;
        height: 27px;
    }

    #btn {
        background: #FD6F22;
        color: white;
        border-radius: 5px;
        height: 27px;
        border: 0px;
        outline: 0px;
        filter: drop-shadow(4px 4px 4px rgba(0, 0, 0, 0.10));
    }

    #writeBtn {
        float: left;
        border: 1px solid #FD6F22;
        box-sizing: border-box;
        border-radius: 5px;
        height: 27px;
    }

    #commutable {
        width: 1000px;
        margin: 0 auto;
        margin-top: 10px;
        text-align: center;
        background-color: white;
        filter: drop-shadow(4px 4px 4px rgba(0, 0, 0, 0.10));
    }

    #commutitle {
        padding-top: 64px;
        padding-bottom: 35px;
        font-size: 25px;
        color: black;
        text-align: center;
    }

    a {
        color: #919CA7;
    }

    #searchdiv {
        width: 1000px;
        margin: auto;
        text-align: right;
    }

    #paging {
        padding-top: 30px;
        text-align: center;
    }

</style>
<body>

<!--header(??????)-->
<%@ include file="/WEB-INF/views/board/boardHeader.jsp"%>

<div style="height: 105px;"></div>
<div class="wrap">

    <p id="commutitle">???????????? ?????????</p>

    <div id="searchdiv">
    
            <script>
 
			//????????? ????????? ??????
			$(function(){    
			        $("#writeBtn").click(function(){
			            location.href="/board/post.do";
			        });
			});
			</script>
			
            <button id="writeBtn">?????????</button>
            
            <form name="form" method="get" action="/board/community.do">
            <select id="select" name="searchOption">
                <option style="text-align: left;" value="subject">
               		<c:if test="${map.searchOption=='subject'}">selected</c:if>
               		 ??????</option>
                <option style="text-align: left;" value="memberId">
					<c:if test="${map.searchOption=='memberId'}">selected</c:if>
               		 ?????????</option>
               	<option style="text-align: left;" value="all">
					<c:if test="${map.searchOption=='all'}">selected</c:if>
               		 ??????+?????????</option>	 
            </select>

            <input id="search" name="keyword" value="${map.keyword }"/>
            <button id="btn" type="submit">??????</button>
        </form>
    </div>

    <table id="commutable" class="table">
        <thead>
        <tr>
            <th style="width: 10%">??????</th>
            <th style="width: 50%">??????</th>
            <th style="width: 12%">?????????</th>
            <th style="width: 15%">?????????</th>
            <th style="width: 13%">??????/??????</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${requestScope.noticelist }" var="n">
        <tr>
            <td class="table-user">
                ${n.noticeNo }
            </td>
            <td><a href="/board/selectContent.do?noticeNo=${n.noticeNo }">${n.subject }</a></td>
            <td>?????????</td>
            <td>${n.regDateString }</td> 
            <td>
                
            </td>
        </tr>
        </c:forEach>
        
        <c:forEach items="${requestScope.boardlist }" var="b">
        <tr>
            <td class="table-user">
                ${b.boardNo }
            </td>
            <td><a href="/board/selectContent.do?boardNo=${b.boardNo }">${b.subject }</a></td>
            <td>${b.memberId }</td>
            <td>${b.regDateString }</td>
            <td>

                <button onclick='go(this)'  class="action-icon" id="${b.boardNo }" style="border:0;"> <i class="mdi mdi-pencil"></i></button> 
                <a href="" class="action-icon"><button class="deleteBtn" id="${b.boardNo }"  style="border:0;"> <i class="mdi mdi-delete"></i></button></a>
            </td>
        </tr>
        </c:forEach>

		<script>
			function go(val){
				var boardNo=val.getAttribute("id");
				window.open("/board/updateCheckPage.do?boardNo="+boardNo,"???????????? ??????" );
			}
		</script>


        </tbody>
    </table>

    <div id="paging">
    	<c:if test="${ preNavi > 0 }">
        	<a style="color: #FD6F22;" href="/board/community.do?currentPage=${preNavi}&searchOption=${searchOption}&keyword=${keyword}">Prev</a>
        </c:if>
        <c:forEach items="${navi }" var="n">
        <a style="color: #919CA7;" href="/board/community.do?currentPage=${n }&searchOption=${searchOption}&keyword=${keyword}">${n }</a>
        </c:forEach>
        <c:if test="${ nextNavi >0 }">
        	<a style="color: #FD6F22;" href="/board/community.do?currentPage=${nextNavi}&searchOption=${searchOption}&keyword=${keyword}">Next</a>
        </c:if>
    </div>
</div>

<!-- footer(??????) -->
<%@ include file="/WEB-INF/views/board/boardFooter.jsp"%>

<script>
		$('.deleteBtn').click(function(){
			var boardNo = $(this).attr('id');
			if(window.confirm('?????? ?????????????????????????\n- ????????? ????????? ????????? ?????????. -')){
															
			$.ajax({
					url:"/board/deleteBoardPost.do",
					data:{"boardNo":boardNo},
					type:"get",
					success:function(result){
				if(result=='true'){
					alert("???????????? ?????? ???????????????");
					window.location.reload();
				}else{
					alert("????????? ????????? ?????????????????????.\n- ???????????? ?????? ????????? ??????????????? ?????????????????? -");
					window.location.reload();
				}
			},
				error:function(){
				console.log('ajax ?????? ??????');
				}
		});
			}
		});

</script>
												

</body>
</html>