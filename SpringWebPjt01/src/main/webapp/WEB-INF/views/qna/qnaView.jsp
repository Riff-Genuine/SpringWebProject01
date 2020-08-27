<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<c:url value="/resources/css/main.css?fast"/>" rel="stylesheet" type="text/css">
<link href="<c:url value="/resources/css/qnaView.css?fast"/>" rel="stylesheet" type="text/css">
<title>1 Day Helper</title>
</head>
<body>
	<%@ include file="/resources/include/nav_top.jsp" %>
	<%@ include file="/resources/include/header.jsp" %>
	<article>
		<table>
			<caption>문의내역 확인</caption>
			<tr>
				<td id="writerTd">
					<label>작성자 : ${user.name }</label>
				</td>
			</tr>
			<tr>
				<td><input type="text" name="title" id="title" value="${vo.title }" readonly></td>
			</tr>
			<tr>
				<td><textarea name="content" id="content" readonly>${vo.content }</textarea>
			</td>
			<c:choose>
				<c:when test="${vo.answer ne null }">
					<tr>
						<td><textarea readonly>${vo.answer }</textarea></td>
					<tr>
				</c:when>
				<c:when test="${vo.answer eq null }">
					<tr>
						<td id="answerTd"><p>빠른 시일내에 답변드리겠습니다.</p></td>
					</tr>
				</c:when>
			</c:choose>
			<tr>
				<td><input type="button" value="뒤로" onclick="javascript:history.back()">
		</table>
	</article>
	<%@ include file="/resources/include/footer.jsp" %>
</body>
</html>