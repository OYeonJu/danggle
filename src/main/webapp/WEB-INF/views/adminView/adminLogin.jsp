<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>      
    
    <style>
        #wrap {
            width: 100%;
            height: 100%;
            
            background-image: url(/resources/images/logo.png);
        	background-repeat:repeat;        	
        	background-position: center;
            }
        
        #wrap>div {
            width: 23%;
            display: inline-block;            
        }
        
        #inputBox{
            position: absolute;
            width: 250px;
            height: 250px;
            background-color: #C4C4C4;
            z-index: 999;
            left: 40%;
            top: 30%;
            border-radius: 20px;
            border: 2px solid #ff8a40;            
        }
        
        #margin {
        position: absolute;
        left: 50%;
        transform: translateX(-50%);
        }
        
        #modal{
            position: absolute;
            bottom: 5%;
            right: 10%;
        }
        
    </style>    
</head>
<body>
   
   <div id="wrap">       
       
       <div id="inputBox">
           
           <div id="margin">
                              
                 <fieldset> <legend style="text-align: center;">?????????</legend>               
                 <br>
              ID: <br><input type="text" name="adminID" id="adminId" /> <br>
              PWD: <input type="password" name="adminPWD" id="adminPwd" />  <br> <br>                                 
                 <input type="submit" value="?????????" onclick="return login();">
                  </fieldset>                 	                                                                                       
           
           </div> 
           
          <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#mail" id="modal"> ????????? ?????? </button>
           
       </div>
       

<div class="modal fade" id="mail" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">??????????????? ????????? ???????????????</h5>
      </div>
      <div class="modal-body">
        <form>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label">?????????:</label>
            <input type="text" class="form-control" id="recipient-name" maxlength="20" placeholder=" (??????/??????) ?????? ?????? ????????????" >
          </div>
          <div class="mb-3">
            <label for="message-text" class="col-form-label">????????????:</label>
            <textarea class="form-control" id="message-text" maxlength="50" style="resize: none;" rows="5" placeholder="(50??? ??????)"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">??????</button>
        <button type="button" class="btn btn-outline-danger" onclick="send();">??????</button>
      </div>
    </div>
  </div>
</div>    
          
   </div>
   
   <script>		
	function login(){
		var adminId = $('#adminId').val();
		var adminPwd = $('#adminPwd').val();
		
		if (adminId.length == 0 )  {
       		 alert('ID??? ???????????????');
       		 return false;
       	 } else if ( adminPwd.length == 0 ) {
       		alert('PW??? ???????????????');
       		return false;   
       		
		 }else{				
			$.ajax({
			 url : "/admin/adminLogin.do",
			 type : "post",            
			 data : {"adminID":adminId, "adminPWD":adminPwd},
			        
			 success : function(data) {           
			    if (data == 'true')	{            	
			      alert('????????? ??????');
			      location.replace("/admin/adminMain.do");
			    }else{
			 	  alert('????????? ??????');
			 	  location.replace("/admin/adminIndex.do");
			    }			        
			},
			 error : function(data) {
			 	alert("ajax error");
			    }
		})
		}
	};		
       
   </script>
      
   <script>
   	function send(){
		
		if( window.confirm('????????? ?????? ???????????????????') ){	

		var title = "????????? ??????";
		var name = $('#recipient-name').val();
		var text = $('#message-text').val();

		var data = {
			    service_id: 'service_rh9wwuk',
			    template_id: 'template_ph9swvu',
			    user_id: 'user_tRmE2v5Kxa2R2cg8A61U1',
			    template_params: {
			    	'title': title,	    	
			        'name': name,
			        'message': text	        
			    }
			};
		
		$.ajax('https://api.emailjs.com/api/v1.0/email/send', {
	    	type: 'POST',
	    	data: JSON.stringify(data),
	    	contentType: 'application/json'
		}).done(function() {
	    	alert('????????? ???????????????');
	    	$('#mail').modal('hide');
		}).fail(function(error) {
	    	alert('???????????? ?????? ' + JSON.stringify(error));
		});
	  }		
	}
    </script>
    
</body>
</html>