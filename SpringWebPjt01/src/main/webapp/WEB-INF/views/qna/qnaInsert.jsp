<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<c:url value="/resources/css/main.css?fast"/>" rel="stylesheet" type="text/css">
<link href="<c:url value="/resources/css/qnaInsert.css?fast"/>" rel="stylesheet" type="text/css">
<title>1 Day Helper</title>
</head>
<body>
	<%@ include file="/resources/include/nav_top.jsp" %>
	<%@ include file="/resources/include/header.jsp" %>
	<article>
		<c:if test="${user ne null }">
		<form action="/qnaInsertOK" method="post" autocomplete="off" onsubmit="return resultCheck()">
			<table>
				<caption>1:1 문의하기</caption>
				<tr>
					<td style="float:right; margin-bottom:10px;">
						<label>작성자 : ${user.name }</label>
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" name="title" id="title" placeholder="제목">
					</td>
				</tr>
				<tr>
					<td>
						<textarea name="content" id="content"></textarea>
					</td>
				</tr>
				<tr>
					<td>
						<input type="submit" value="문의하기">
						<input type="button" value="취소" onclick="javascript:history.back()">
					</td>
				</tr>
 			</table>
			<input type="hidden" name="id" value="${user.id }">
			<input type="hidden" name="name" value="${user.name }">
		</form>
		</c:if>
	</article>
	<%@ include file="/resources/include/footer.jsp" %>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script>
		function resultCheck(){
			if($('#title').val() == '') {
				alert('제목을 입력해주세요.');
				return false;
			} else if($('#content').val() == '') {
				alert('내용을 입력해주세요.');
				return false;
			} else return true;
		}
	</script>
</body>
</html>