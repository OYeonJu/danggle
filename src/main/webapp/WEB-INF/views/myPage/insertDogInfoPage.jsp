<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JQuery 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반려견 정보 등록</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
  
    <style>
        * {
            box-sizing: border-box;
            font-family: 'Noto Sans KR', sans-serif;
            font-size: 15px;
            font-weight: bold;
            color: #919CA7;
        }

        .wrap {
            border: 1px solid red;
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

        .side_menu>li:first-child>a {
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
            width: 450px;
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
            
            height: 50px;

        }

        tr>td:first-child {
            width: 150px;
        }

        tr>td:last-child {
            /*padding-left: 15px;*/


        }

        label {
            display: inline-block;
            width: 70px;
            height: 100%;
            line-height: 50px;
        }

        select {
            border: 1px solid #919CA7;
            height: 37px;
            border-radius: 5px;
            padding: 0 5px 0 5px;
            height: 35px;
        }

        input[type=text],
        input[type=email] {
            width: 220px;
            height: 35px;
            border: 1px solid #919CA7;
            border-radius: 5px;
            padding: 0 8px 0 8px;
        }
        

        .btn {
            /*border: 1px solid #FD6F22;*/
            position: relative;
            bottom: -40px;
            clear: both;
        }

        
        .cancelBtn {
            width: 67px;
            height: 40px;
            border: 1px solid #FD6F22;
            background-color: #ffffff;
            border-radius: 5px;
            cursor: pointer;
            filter: drop-shadow(4px 4px 4px rgba(0, 0, 0, 0.10));
            margin: 0 13px;
        }
        
        .enrollBtn{
            width: 67px;
            height: 40px;
            border: 1px solid #FD6F22;
            background-color: #FD6F22;
            color: #ffffff;
            border-radius: 5px;
            cursor: pointer;
            filter: drop-shadow(4px 4px 4px rgba(0, 0, 0, 0.10));
            margin: 0 13px;
        }



        /*footer(풋터)*/
        .footer {
            border: 1px solid black;
            width: 100%;
            height: 235px;
            background-color: dimgrey;
        }
    </style>


    <!-- 생년월일 -->
    <script>
        $(document).ready(function() {
            var now = new Date();
            var year = now.getFullYear();
            var mon = (now.getMonth() + 1) > 9 ? '' + (now.getMonth() + 1) : '0' + (now.getMonth() + 1);
            var day = (now.getDate()) > 9 ? '' + (now.getDate()) : '0' + (now.getDate());
            //년도 selectbox만들기               
            for (var i = 1900; i <= year; i++) {
                $('#year').append('<option value="' + i + '">' + i + '</option>');
            }

            // 월별 selectbox 만들기            
            for (var i = 1; i <= 12; i++) {
                var mm = i > 9 ? i : "0" + i;
                $('#month').append('<option value="' + mm + '">' + mm + '</option>');
            }

            // 일별 selectbox 만들기
            for (var i = 1; i <= 31; i++) {
                var dd = i > 9 ? i : "0" + i;
                $('#day').append('<option value="' + dd + '">' + dd + '</option>');
            }

            $("#year  > option[value=" + year + "]").attr("selected", "true");
            $("#month  > option[value=" + mon + "]").attr("selected", "true");
            $("#day  > option[value=" + day + "]").attr("selected", "true");

            /* $('#birthdate').attr('value',year+mon+day); */
        })
    </script>


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
                <p>반려견 정보 등록</p>

                <!--메인 컨텐츠-->
                <div class='contentCenter'>
                    <div class="contentCenterInner">

                        <!--등록-->
                        <div class='dogInfo'>
                        <form action="/myPage/insertDogInfo.do" method="post" enctype="multipart/form-data" onsubmit="return checkForm();">
                            <div class='dogImg'>
                            	<img id="user_icon" src="/resources/upload/dogProfile/dog_default.jpg" onclick="profileUpload()"></img>
                            </div>
          
	          				<input type=file name='profileFile' style='display: none;' onchange="readURL(this);">
	          				 
	          				 <!-- 사진 클릭 시 파일 업로드창 생성 -->
	          				 <script>
	          				 	function profileUpload() {
	          				 	 document.all.profileFile.click();
								}
	          				 </script>
	          				 
	          				 <script>
	          				 	function readURL(input){
	          				 		if(input.files && input.files[0]){
	          				 			var reader=new FileReader();
		          				 		reader.onload=function(e){
		          				 			document.getElementById('user_icon').src=e.target.result;
		          				 		};
		          				 		reader.readAsDataURL(input.files[0]);	
	          				 		}else{
	          				 			document.getElementById('user_icon').src="";
	          				 		}
	          		
	          				 		
	          				 	}
	          				 </script>
	          				 
                            <div class='dogInfoText'>
                                <table>
                                    <tr>
                                        <td>이름</td>
                                        <td><input type="text" name="dogName"></td>
                                    </tr>
                                    <tr>
                                        <td>성별</td>
                                        <td><label><input type="radio" name="gender" value="M" checked>남</label> <label><input type="radio" name="gender" value="F">여</label></td>
                                    </tr>
                                    <tr>
                                        <td>생일</td>
                                        <td>
                                            <select name="yy" id="year" class="birthdate"></select>년 &nbsp;
                                            <select name="mm" id="month" class="birthdate"></select>월 &nbsp;
                                            <select name="dd" id="day" class="birthdate"></select>일 &nbsp;
                                            <!-- <input type="text" id="birthdate" name="birthdate" value="" style="display:none;"> -->
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>품종</td>
                                        <td><input type="text" name="breed" ></td>
                                    </tr>
                                    <tr>
                                        <td>사이즈</td>
                                        <td>
                                            <select name="dogSize">
                                                <option value="소형견">소형견 (10kg 이하)</option>
                                                <option value="중형견">중형견 (11kg ~ 25kg)</option>
                                                <option value="대형견">대형견 (26kg 이상)</option>
                                            </select>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>접종 유무</td>
                                        <td><label><input type="radio" name="vaccinationYN" value="Y">완료</label> <label><input type="radio" name="vaccinationYN" value="ING">진행중</label> <label><input type="radio" name="vaccinationYN" value="N" checked>미완료</label></td>
                                    </tr>
                                    <tr>
                                        <td>중성화 유무</td>
                                        <td><label><input type="radio" name="neutralizationYN" value="Y">완료</label> <label><input type="radio" name="neutralizationYN" value="N" checked>미완료</label></td>
                                    </tr>

                                </table>

                            </div>

                            <div class="btn">
                            	<input type="submit" value="등록"  class="enrollBtn">
                                <button type="button" class="cancelBtn">취소</button>
                            </div>
                            
                            
							</form>
                        </div>

                    </div>
                    
                    	<script>
                    		function checkForm(){
                    			var dogName=$('input[name=dogName]').val();
                    			var breed=$('input[name=breed]').val();
                    			
                    			if(dogName==""){
                    				alert('이름을 입력해 주세요.');
                    				$('input[name=dogName]').css('border','2px solid #FD6F22');
                    				return false;
                    			}
                    			if(breed==""){
                    				alert('품종을 입력해 주세요.');
                    				$('input[name=breed]').css('border','2px solid #FD6F22');
                    				return false;
                    			}
                    		}
                    		
                    		$('input[name=dogName]').click(function(){
                    			$(this).css('border','2px solid #919CA7');
                    		});
                    		$('input[name=breed]').click(function(){
                    			$(this).css('border','2px solid #919CA7');
                    		});
                    	</script>
                    
                    	<!-- 취소 버튼 클릭시 반려견 정보 페이지 호출 -->
						<script>
							$('.cancelBtn').click(function(){
								location.replace("/myPage/dogInfoPage.do");
							});
						</script>

                </div>
            </div>
        </div>
        <div class="footer"></div>
    </div>

</body>
</html>