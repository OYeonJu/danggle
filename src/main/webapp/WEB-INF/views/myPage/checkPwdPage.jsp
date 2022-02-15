<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JQuery 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>
<link rel="stylesheet" type="text/css" href="/resources/css/checkPwdPage.css">
    <script type="text/javascript">
    	function checkPwd() {
			var memberPwd= $('input[name=memberPwd]').val();
			
			$.ajax({
				url: "/myPage/checkPwd.do",
				data:{"memberPwd":memberPwd},
				type: "post",
				success: function (result) {
				
					if(result=='true'){
						window.opener.parent.location="/myPage/updateMemberInfoPage.do";
						window.close();
					}else{
						alert('비밀번호가 일치하지 않습니다.');
					} 
				},
				error: function () {
					console.log('ajax 통신 실패');
				}
			});
		}
    </script>
</head>
<body>

    <div class='wrap'>

        <div class='content'>
            <div>
            	<span>비밀번호</span> <input type='password' name='memberPwd' placeholder='비밀번호를 입력하세요.'>
            </div>
            <br>
            <div>
            	<button class="pwd_change_btn" onclick="checkPwd()">비밀번호 확인</button>
            </div>
        </div>

    </div>
    

    

</body>
</html>











