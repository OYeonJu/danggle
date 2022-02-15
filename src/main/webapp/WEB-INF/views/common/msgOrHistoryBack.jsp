<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:choose>
	<c:when test="${requestScope.result=='true'}">
		<script>
			alert('${requestScope.msg }');
			location.replace('${requestScope.location}');
		</script>
	</c:when>
	<c:otherwise>
		<script>
			alert('${requestScope.msg }');
			history.back();
		</script>
	</c:otherwise>
</c:choose>

</body>
</html>