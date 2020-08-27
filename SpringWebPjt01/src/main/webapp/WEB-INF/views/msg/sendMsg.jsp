<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<c:url value="/resources/css/sendMsg.css?fast"/>" rel="stylesheet" type="text/css">
<title>1 Day Helper</title>
</head>
<body>
	<article>
		<form action="/sendMsgOK" method="post" autocomplete="off">
			<table>
				<caption>메시지 보내기</caption>
				<tr>
					<td id="receiverTd">
						<label>받는 사람 : ${param.receiver}</label>
					</td>
					<td id="senderTd">
						<label>보내는 사람 : ${user.name }</label>
					</td>
				</tr>
				<tr>
					<td colspan=4><input type="text" name="title" id="title" placeholder="제목"></td>
				</tr>
				<tr>	
					<td colspan=4><textarea name="content" id="content"></textarea></td>
				</tr>
				<tr>
					<td>
						<input type="button" id="submitBtn" value="전송">
						<input type="button" value="취소" onclick="javascript:window.close()">
					</td>
				</tr>
			</table>
			<input type="hidden" name="sender" id="sender" value="${user.name }">
			<input type="hidden" name="senderID" id="senderID" value="${user.id }">
			<input type="hidden" name="receiver" id="receiver" value="${param.receiver }">
			<input type="hidden" name="receiverID" id="receiverID" value="${param.receiverID }">
			<input type="hidden" name="boardNo" id="boardNo" value="${param.boardNo }">
			<input type="hidden" name="boardTitle" id="boardTitle" value="${param.boardTitle }">
		</form>
	</article>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script>
		$('#submitBtn').click(function() {
			var title = $('#title').val();
			var content = $('#content').val();
			
			if(title == '') {
				alert('제목을 입력해주세요.');
				return;
			} else if(content == '') {
				alert('내용을 입력해주세요.');
				return;
			} else {
				$('form').submit();
			}
		});
	</script>
</body>
</html>