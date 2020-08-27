<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link href="<c:url value="/resources/css/nav_top.css?fast"/>" rel="stylesheet" type="text/css">
<title>1 Day Helper</title>
</head>
<body>
	<div id="nav">
		<ul>
			<c:if test="${user eq null }">
				<li><a href="/login">LOGIN</a></li>
			</c:if>
			<c:if test="${user ne null }">
				<li><a href="/">HOME</a></li>
				<li><a href="/myPage">MY PAGE</a></li>
				<li><a href="/memberUpdate">MODIFY</a></li>
				<li><a href="/msg">MESSAGE</a></li>
				<li><a href="/qna">1:1 QnA</a></li>
				<li><a href="/logout">LOGOUT</a></li>
			</c:if>
		</ul>
	</div>
</body>
</html>