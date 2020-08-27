<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<c:url value="/resources/css/main.css?fast"/>" rel="stylesheet" type="text/css">
<link href="<c:url value="/resources/css/login.css?fast"/>" rel="stylesheet" type="text/css">
<title>1 Day Helper</title>
</head>
<body>
	<%@ include file="/resources/include/nav_top.jsp" %>
	<%@ include file="/resources/include/header.jsp" %>
	<article>
		<form action="/loginOK" method="post" autocomplete="off">
			<table id="loginTb">
				<caption>로그인</caption>
				<tr>
					<td><input type="text" name="id" placeholder="아이디"></td>
				</tr>
				<tr>
					<td><input type="password" name="pw" placeholder="패스워드"></td>
				</tr>
				<tr>
					<td><input type="submit" value="로그인"></td>
				</tr>
				<tr>
					<td>
						<a href="#" id="findID">아이디 찾기</a>
						<a href="#" id="findPW">비밀번호 찾기</a>
						<a href="/memberInsert">회원가입</a>
					</td>
				</tr>
			</table>
		</form>
	</article>
	<%@ include file="/resources/include/footer.jsp" %>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script>
		$('#findID').click(function() {
			window.open('/findID', '아이디 찾기', 'width=500, height=400, left=200, top=200');
		});
		$('#findPW').click(function() {
			window.open('/findPW', '비밀번호 찾기', 'width=500, height=400, left=200, top=200')
		});
	</script>
</body>
</html>