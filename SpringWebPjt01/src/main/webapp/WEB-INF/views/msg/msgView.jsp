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
				<caption>메시지 확인</caption>
				<tr>
					<td id="receiverTd">
						<label>받는 사람 : ${vo.receiver}</label>
					</td>
					<td id="senderTd">
						<label>보내는 사람 : ${vo.sender }</label>
					</td>
				</tr>
				<tr>
					<td colspan=4><input type="text" name="title" id="title" value="${vo.title }" readonly></td>
				</tr>
				<tr>	
					<td colspan=4><textarea name="content" id="content" readonly>${vo.content }</textarea></td>
				</tr>
				<tr>
					<td>
						<c:if test="${user.id != vo.senderID }">
						<input type="button" value="답장" onclick="sendMsg()">
						</c:if>
						<input type="button" value="닫기" onclick="javascript:window.close()">
					</td>
				</tr>
			</table>
			<input type="hidden" name="sender" id="sender" value="${vo.sender }">
			<input type="hidden" name="senderID" id="senderID" value="${vo.senderID }">
			<input type="hidden" name="boardNo" id="boardNo" value="${vo.boardNo }">
			<input type="hidden" name="boardTitle" id="boardTitle" value="${vo.boardTitle }">
		</form>
	</article>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script>
		function sendMsg() {
			var receiver = $('#sender').val();
			var receiverID = $('#senderID').val();
			var boardNo = $('#boardNo').val();
			var boardTitle = $('#boardTitle').val();
			
			window.open('/sendMsg?receiver='+receiver+'&receiverID='+receiverID+'&boardNo='+boardNo+'&boardTitle='+boardTitle, '메시지 보내기', 'width=500, height=500, left=200, top=200');
			window.close();
		}
	</script>
</body>
</html>