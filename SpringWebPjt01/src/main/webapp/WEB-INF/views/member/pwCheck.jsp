<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<c:url value="/resources/css/main.css?fast"/>" rel="stylesheet" type="text/css">
<title>1 Day Helper</title>
</head>
<body>
	<%@ include file="/resources/include/nav_top.jsp" %>
	<%@ include file="/resources/include/header.jsp" %>
	<article>
		<form action="/pwCheckOK" method="post" autocomplete="off">
			<table>
				<tr>
					<td><input type="password" name="pw" placeholder="Password"></td>
				</tr>
				<tr>
					<td><input type="submit" value="확인"></td>
				</tr>
			</table>
			<input type="hidden" name="id" value="${user.id }">
			<input type="hidden" name="keyword" value="${param.keyword }">
		</form>
	</article>
	<%@ include file="/resources/include/footer.jsp" %>
</body>
</html>