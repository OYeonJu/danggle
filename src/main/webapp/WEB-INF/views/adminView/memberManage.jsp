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
        text-align: center;
    }
    
    .search {
        height: 30%;
        float: left;
        margin:5px;
    }  

	.badge{
		cursor:pointer;
	}
        
</style>
          
<body>
   
   <div class="wrap"> 
   
	<%-- <c:choose> 
		<c:when test="${sessionScope.adminVO != null }"> --%>		
   	
      <div id="header">  <%@ include file="/WEB-INF/views/adminView/adminHeader.jsp" %> </div>
       
       <div id="body">
          
         <div id="aside">  <%@ include file="/WEB-INF/views/adminView/adminAside.jsp" %>  </div>
           
         <div class="contents">
            
            <div class="search">
              <form action="/admin/memberSearch.do" method="get">	
                <select name="tag"> 
                    <option disabled selected>??????</option>
                    <option value="memberId">ID</option>
                    <option value="nickname">?????????</option>
                    <option value="all">ID+??????</option>
                </select>
                <input type="text" name="keyword">
                <input type="submit" value="??????">                
              </form> 
            </div>
            
        	<div class="table">
                <table class="table table-hover" >        	 
                    <thead>
                        <tr style="text-align:center;">
                            <th>?????? ??????</th>                            
                            <th>?????? ID</th>
                            <th>????????? ??????</th>
                            <th>???????????? ??????</th>
                            <th>????????????</th>
                            <th>???????????? 
                            	 	<c:if test="${requestScope.map.count != null}"> 
                            			<span class="badge bg-danger"> ${requestScope.map.count} </span>
                            	 	</c:if>
                            </th>
                            <th>??????</th>                            
                        </tr>
                    </thead>
                    <tbody>
                   <c:choose>
                   
                   	<c:when test="${requestScope.map.member != null}">
                   		
                      <c:forEach items="${requestScope.map.member}" var="a">	
                        <tr>
                            <td> ${a.memberNo} </td>
                            <td> ${a.memberId} </td>
                            <td> ${a.nickame} </td>
                            <td> ${a.dogYN} </td>
                            <td> ${a.enrollDate} </td>
                            <td> ${a.memberStatus} </td>
                            <td> <input type="checkbox" value="${a.memberNo}"> </td>
                        </tr>                                                                 
                      </c:forEach>
                      
                    </c:when>
                    
                    	<c:otherwise>
                    		<tr> <td colspan="7"> ????????? ????????? ???????????? </td>  </tr>
                    	</c:otherwise>
                    	
                   </c:choose>                                              
                    </tbody>
                    <tfoot style="text-align: center;">                            
                    
                     <c:choose>
                      <c:when test="${requestScope.map.member == null}">                      		
                      	  <tr>
                        	   <td colspan="3"></td>
                           	   <td colspan="3">
                            	<nav aria-label="...">
									  <ul class="pagination">
								  			<li class="page-item"><a href="" class="page-link">??????</a></li>
    									  									
    										<li class="page-item">
      											<a  href=""  class="page-link"> ????????? ?????? </a>
									    	</li>
									    
									    	<li class="page-item"><a  href="" class="page-link">???</a> </li>									    
 								  	</ul>
								</nav>
                           		</td>
                           		<td colspan="3"></td>
                        	</tr>                                                        
                       </c:when>
                       
						<c:otherwise>
							<%-- each ????????? ????????? ?????? --%>
                      	  <tr>
                        	   <td></td>
                           	   <td>
                            	<nav aria-label="...">
									  <ul class="pagination">
								  			<li class="page-item"><a class="page-link" href="">??????</a></li>
    									  									
    										<li class="page-item">
      											<a class="page-link" href=""> ????????? ?????? </a>
									    	</li>
									    
									    	<li class="page-item"><a class="page-link" href="">???</a> </li>									    
 								  	</ul>
								</nav>
                           		</td>
                           		<td></td>
                        	</tr>                    	
                    	</c:otherwise>                                              
                       </c:choose>    
                                                   
                        <tr>
                            <td colspan="5"> 
                            	<button type="button" class="btn btn-success" onclick="pageRefresh();" style="float:left;">
                            		????????????	
                            	</button>
                            </td>
                            
                            <td>                                    
                                <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#gradeForm" onclick="printData();">
                                 	 ??????
                                </button>
                                
                                <div class="modal fade" id="gradeForm" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                  <div class="modal-dialog modal-sm">
                                    <div class="modal-content">                                     
                                          <div class="modal-body">
                                            <br>
                                            	????????? ??????: <span id="selectMsg"> </span> 
                                            <br>	
                                              <select id="gradeValue"> 
                                                <option disabled selected> ?????? ?????? </option>
                                                                                                                                        
                                                <option value="0">?????????</option>
                                                <option value="1">??????</option>
                                                <option value="2">??????</option>
                                              </select>                                                                                            
                                              
                                          </div>
                                      <div class="modal-footer">
                                      <button type="button" class="btn btn-outline-danger" onclick="gradeChange();">??????</button>
                                      <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">??????</button>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                            
                            </td>
                        </tr>                        
                    </tfoot>
                  </table>
             </div>   
               
           </div>
           
       </div>
    <%-- </c:when>       
       
      <c:otherwise>
      	<H2>????????? ?????? ???????????? ???????????????</H2>
      		<a href="/admin/adminIndex.do"> ??????????????? ?????? </a>
      </c:otherwise>      
	</c:choose> --%>
              
   </div>
<%-- <c:if test="${sessionScope.adminVO != null }">  --%>  
    <script>
   		$(".badge").click(function(){
   		// 1. ????????? ???????????? ???????????? ????????? ????????? ?????? C?????? ???????????? ????????? ?????? ??? ??????
   	    $('td:contains(C)').next().children().prop('checked',true);	
   		var myModal = new bootstrap.Modal(document.getElementById('gradeForm'), focus);
   	    myModal.show()	   	    	    	   	    	
 		var count = '<c:out value="${(requestScope.map.count)}" />';   		   			   			   					
		$('#selectMsg').text("???( "+count+" )???");   		
   		// 2. ?????? ?????? ajax ?????? ??????				
   		// ?????? ?????? ?????? ?????????   		
   		});
   </script>

	<script>
		function printData(){		
			var dataArray = new Array();				
			$('input:checked').each(function(){
				dataArray.push( this.value );
			});
			if (dataArray != 0){
				$('#selectMsg').text(dataArray);
			}else{
				$('#selectMsg').text('????????? ????????? ??????');	
			}
	}	
	</script>
	
   <script>
		function gradeChange(){
			var dataArray = new Array();
			var grade = $('#gradeValue>option:selected').val();
			
			$('input:checked').each(function(){
				dataArray.push( this.value );
			})
			
			if( dataArray == 0 ){
				return false;
			}else{					
				$.ajax({
			    	url : "/admin/adminGradeChange.do",
			        type : "post",            
			        data : {"dataArray":dataArray,"newGrade":grade},			        
			        success : function(data) {           
			      if (data == 'pass') {            				          
			    	 alert('?????? ??????');
			    	  $('#gradeForm').modal('hide');
			          location.reload();
			        }else{
			          $('#selectMsg').text('?????? ??????');			        				     
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
   		
        $("tbody>tr").click(function(){        	           
        	// 1?????? ?????? ????????????, ??? ?????? ?????? ??????????????? ??????
        	var $test = $(this).children().eq(6);        	        	

        	// 2?????? ?????? ????????? ?????? ??????           	
        	console.log($test.children().prop('checked'));
        	if ($test.children().prop('checked') == true) {
        		$test.children().prop('checked',false);
        		$test.parent().removeAttr("style");
        	}else{
        		$test.children().prop('checked',true);        		
        		$test.parent().css('background','grey');
        	}
        });       
   </script> 
   
   <script>
   		function pageRefresh(){
   			location.replace("/admin/memberManage.do");
   		};
   </script>
   
<%-- </c:if>   --%>
</body>
</html>