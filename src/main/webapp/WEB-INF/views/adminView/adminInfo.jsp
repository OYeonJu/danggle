<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>       
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>      
</head>
  
<style>

    .wrap{
        width: 100%;
        height: 100%;
        position:relative;
        box-sizing: border-box;
        margin: 0px;
    }
    
     .wrap>div{
        box-sizing: border-box;
        margin: 0px;
        display: inline-block;
    }
    
    #header{
        height: 10%;
        width: 100%;
    }    
    
    #body{
        height: 90%;
        width: 100%;        
    }
    
    #aside{
        width: 15%;
        height: 100%;
        float: left;        
    }
    
    .contents{
        width: 85%;
        height: 100%;        
        float: left;
        display: flex;
    }    
    
    #adminForm{
       margin: 0 auto;
        width: 90%;
    } 
    
</style>
          
<body>
   
<div class="wrap"> 

	<c:choose>
		<c:when test="${sessionScope.adminVO != null }">
      
       <div id="header">  <%@ include file="/WEB-INF/views/adminView/adminHeader.jsp" %> </div>
       
       <div id="body">
          
         <div id="aside">  <%@ include file="/WEB-INF/views/adminView/adminAside.jsp" %>  </div>
           
             <div class="contents">
                       
              <div id="adminForm">
               <table class="table table-hover">    
                  
                   <thead>
                      <tr>
                      <H2 > ???????????? ????????? ????????? ??????????????? </H2>
                      </tr>
                      <th> <span> ????????? ????????????: &nbsp; </span> <span style="color: red" id="msg"> </span> </th>
                   </thead>
                   
                    <tbody>   
                        <tr>
                          <td>
							????????? ??????: ${sessionScope.adminVO.adminNo}                           
                          </td>     
                        </tr>
                        <tr>   
                          <td>
							ID: ${sessionScope.adminVO.adminID}
                          </td>     
                        </tr>                                                
                        <tr>   
                          <td>
                           ?????? ??????: <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#pwdChangeForm">
  							???????????? ??????
					    </button>
                          </td>     
                        </tr>                                                
                        <tr>   
                          <td>
                           ?????? ??????: <input type="text" id="adminName" maxlength="4" value="${sessionScope.adminVO.adminName}" />
                          </td>     
                        </tr>
                        <tr>   
                          <td>
                           ????????? ??????: <input type="text" id="adminEmail" maxlength="30" value="${sessionScope.adminVO.adminEmail}" />
                          </td>     
                        </tr>
                        <tr>   
                          <td>
							???????????????: ${sessionScope.adminVO.adminGrade}
                          </td>     
                        </tr>
                        <tr>   
                          <td>
							???????????????: ${sessionScope.adminVO.adminDate}
                          </td>     
                        </tr>
                    </tbody> 
                    
                    <tfoot>
                            <tr>
                        	 <td> 
                        	     <button class="btn btn-secondary" type="button" onclick="refresh();" style="float: left;">????????????</button>                                	                        	          
                            </td>
                            <td> 
                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">              
								  <button class="btn btn-warning me-md-2" type="submit" onclick="return info();" style="float: left;">??????</button>									  	  
								</div>								                      	
				            </td>														
                        </tr>
                    </tfoot>   
                                    
                 </table>    
                </div>                	         	                 
                
            </div>
            
 <div class="modal fade" id="emailChkForm" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="adminEmailCheck">Email ??????????????????</h5>
      </div>
      <div class="modal-body">
        <form>
          <div class="mb-3">
            <label for="inputID" class="col-form-label">Email ??????:</label>
            <input type="text" class="form-control" id="inputEmail" maxlength="30" >
          </div>
                    
          <div class="mb-3">
            <label for="chkResult" class="col-form-label">?????? ??????:</label>
            <span id="chkResult" style="color: red"> </span>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">??????</button>
        <button type="button" class="btn btn-outline-danger" onclick="return emailCheck();">??????</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal -->
<div class="modal fade" id="pwdChangeForm" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="pwdChangeLabel">????????? ???????????????</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
       <form>
          <div class="mb-3">
            <label for="originalPWD" class="col-form-label">?????? ?????? ??????:</label>
            <input type="password" class="form-control" id="oldPWD" maxlength="20" >
          </div>
          
          <div class="mb-3">
            <label for="newPWD" class="col-form-label">????????? ?????? ??????:</label>
            <input type="password" class="form-control" id="newPWD" maxlength="20" >
          </div>
          
          <div class="mb-3">
            <label for="newPWD_Re" class="col-form-label">????????? ?????? ?????????:</label>
            <input type="password" class="form-control" id="pwdRe" maxlength="20" >
          </div>
                    
          <div class="mb-3">
            <label for="chkResult" class="col-form-label">??????:</label>
            <span id="chkMsg" style="color: red"> </span>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">??????</button>
        <button type="button" class="btn btn-outline-danger" onclick="return pwdChange();">??????</button>
      </div>
    </div>
  </div>
</div>
               
         </div>  
       </c:when> 
         
      <c:otherwise>
      	<H2>????????? ?????? ???????????? ???????????????</H2>
      		<a href="/admin/adminIndex.do"> ??????????????? ?????? </a>
      </c:otherwise>      
	</c:choose>
           
 </div>        
 
 <c:if test="${sessionScope.adminVO != null }">   
	<script>
		function pwdChange(){
			var pwdCheck =  /^(?=.*[a-z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{10,20}$/;			
			var aID = '<c:out value="${sessionScope.adminVO.adminID}" />';
			var oldPWD = $('#oldPWD').val();
			var newPWD = $('#newPWD').val();
			var pwdRe = $('#pwdRe').val();
			var msg = $('#chkMsg');
			
			 if ( oldPWD.length == 0 ) {
					msg.text("???????????? ????????? ???????????????");			
					return false;
				} else if (!pwdCheck.test(newPWD) ) {
					msg.text("10~20?????? ?????? ???????????? ??????,??????????????? ???????????? ?????????");			
					return false;	
				} else if (newPWD.length == 0 ) {
						msg.text("????????? ????????? ???????????????");			
						return false;								 
				} else if (newPWD != pwdRe ) {
						msg.text('????????? ????????? ????????? ?????????');			
					return false;
				}else{					
					 $.ajax({
					    	url : "/admin/updatePWDChange.do",
					        type : "post",            
					        data : {"adminID":aID, "oldPWD":oldPWD, "newPWD":newPWD },
					        
					        success : function(data) {           
					      if (data == 'true')	{            	
					          alert('????????????');
					          location.reload();
					      }else if (data == 'invalid') {
					    	  msg.text('???????????? ????????? ???????????????'); 
					      }else{
					         msg.text('????????????');
					         }			        
					        },
					        error : function(data) {
					            alert("ajax error");
					        }
					    });
					}		
		}	
	</script>
    
   <script>   
    $('#adminEmail').focusin(function() {
    	var myModal = new bootstrap.Modal(document.getElementById('emailChkForm'), focus);
    	myModal.show()
	});    
   </script>
   
   <script>
   		function emailCheck(){
   	     var emailCheck=  /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
   		 var spaceCheck = /\s/g;   		 
   		 var chkData = $('#inputEmail').val();
   		 
   		 if (chkData.length > 30 ) {
   			$('#chkResult').text("email??? 30??? ????????? ???????????????");
             return false;
         } else if (!emailCheck.test( chkData ) ) {
        	 $('#chkResult').text("????????? ????????? ????????????");                                      
             return false;              
         } else if (spaceCheck.test( chkData ) ) {
        	 $('#chkResult').text("???????????? ????????? ????????????");                                      
             return false; 
             
         } else {        	 
			    $.ajax({
			    	url : "/admin/adminEmailCheck.do",
			        type : "post",            
			        data : {"chkMail":chkData},
			        
			        success : function(data) {           
			      if (data == 'pass') {            				          
			    	  $('#adminEmail').val(chkData);
			    	  $('#emailChkForm').modal('hide');
			          
			        }else if (data == 'false') {
			        	$('#chkResult').text(" ?????? EMAIL");
			        
			        }else if (data == 'invalid') {
			        	$('#chkResult').text(" email????????? ???????????????");		 
			         }				      
			        },
			        error : function(data) {
			            alert("ajax error");
			        }
			    })        	 
         	}    		 
   		}   
   </script>
      
   <script>
        function info(){        
        var nameCheck = /^[???-???]{2,4}$/;
        var emailCheck=  /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		var spaceCheck = /\s/g;        
		var msg = $('#msg');
		
		var adminName = $('#adminName').val();
		var adminEmail = $('#adminEmail').val();
        
			if ( !nameCheck.test($('#adminName').val() )) {
                alert("????????? 2~4????????? ????????? ?????? ????????????");        
                return false;
            }else if (spaceCheck.test($('#adminName').val() )) {
                alert("???????????? ????????? ????????????");                                      
                return false;
            }else if ( !emailCheck.test($('#adminEmail').val() )) {
                alert("????????? ?????? ????????? ??????????????????");
                return false;            
            }else if (spaceCheck.test($('#adminEmail').val() )) {
                alert("???????????? ????????? ????????????");                                      
                return false;
       
            }else{               
                var adminID = '<c:out value="${(sessionScope.adminVO.adminID)}" />';
				var adminData = {"adminID":adminID,"adminName":adminName,"adminEmail":adminEmail};
				
			    $.ajax({
			    	url : "/admin/updateAdminAccount.do",
			        type : "post",            
			        data : adminData,
			        
			        success : function(data) {           
			      if (data == 'pass')	{            	
			          alert('?????? ??????');
			          location.reload();
			        }else if (data == 'invalid'){
			        	msg.text('????????? ?????? ???????????????');
			        }else{
			        	msg.text('?????? ??????');
			        }			      
			        },
			        error : function(data) {
			            alert("ajax error");
			        }
			    })                
            }      
        }

   </script>

   <script>
        $("tr>td").click(function(){
            $(this).children().focus();
        });       
   </script>   

   <script>

    $('#adminName').on('keyup' ,function(event) { 
        var nameCheck = /^[???-???]{2,4}$/;
        var spaceCheck = /\s/g;
        var $msg = $('#msg');  
        
           if ( !nameCheck.test(adminName.value) ) {
                $msg.html("????????? ????????? ????????? 2~4????????? ????????? ?????? ????????????");                                                  
            }else if (spaceCheck.test(adminName.value) ) {
                $msg.html("???????????? ????????? ?????????????????????");  
            }else{
                $msg.html("");                                      
            } 
     });    

     $('#adminEmail').on('keyup' ,function(event) { 
        var emailCheck=  /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
        var spaceCheck = /\s/g;
        var $msg = $('#msg');                
           if ( !emailCheck.test(adminEmail.value) ) {
                $msg.html("????????? ?????? ????????? ??????????????????");
            }else if (spaceCheck.test(adminEmail.value) ) {
                $msg.html("???????????? ????????? ?????????????????????"); 
            }else{
                $msg.html("");                                      
            }  
     }); 
    
   </script>
   
   <script>
   	function refresh(){
		location.reload();
	}
    </script>
    
</c:if>       
        
</body>
</html>