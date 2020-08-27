<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<c:url value="/resources/css/main.css?fast"/>" rel="stylesheet" type="text/css">
<link href="<c:url value="/resources/css/boardView.css?fast"/>" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<title>1 Day Helper</title>
</head>
<body>
	<%@ include file="/resources/include/nav_top.jsp" %>
	<%@ include file="/resources/include/header.jsp" %>
	<article>
		<h1>${postInfo.title }</h1>
		<div id="timeInfo">
			<ul>
				<li>날짜 : ${postInfo.aDate }</li>
				<li>시작 : ${postInfo.sTime }</li>
				<li>종료 : ${postInfo.eTime }</li>
			</ul>
		</div>
		<div id="boardInfo">
			<ul>
				<li>작성자 : ${postInfo.name }</li>
				<li>조회수 : ${postInfo.views }</li>
				<li>작성일 : ${postInfo.iDate.substring(0, 10) }</li>
			</ul>
		</div>
		<div id="boardContent">
			<textarea readonly>${postInfo.content }</textarea>
		</div>
		<c:if test="${!empty fileInfo }">
		<div id="imgFile">
			<div class="bxSlider">
				<c:forEach var="fileInfo" items="${fileInfo }">
					<div><img class="imgs" src="/img/${fileInfo.storedName }"></div>
				</c:forEach>
			</div>
		</div>
		</c:if>
		<div id="contactBtn">
			<c:if test="${user.name ne postInfo.name && user.name ne null }">
			<input type="button" class="btns" value="Contact" onclick="sendMsg()">
			</c:if>
			<input type="button" class="btns" value="Back" onclick="javascript:history.back()">
		</div>
		<input type="hidden" id="receiver" value="${postInfo.name }">
		<input type="hidden" id="receiverID" value="${postInfo.id }">
		<input type="hidden" id="boardNo" value="${postInfo.no }">
		<input type="hidden" id="boardTitle" value="${postInfo.title }">
	</article>
	<script>
		function sendMsg() {
			var receiver = $('#receiver').val();
			var receiverID = $('#receiverID').val();
			var boardNo = $('#boardNo').val();
			var boardTitle = $('#boardTitle').val();
			
			window.open('/sendMsg?receiver='+receiver+'&receiverID='+receiverID+'&boardNo='+boardNo+'&boardTitle='+boardTitle, '메시지 보내기', 'width=500, height=500, left=200, top=200');

		}
	    $(document).ready(function(){
	      $('.bxSlider').bxSlider({
	    	  mode: 'horizontal',// 가로 방향 수평 슬라이드
	          pager: true,      // 현재 위치 페이징 표시 여부 설정
	          controls: true,    // 이전 다음 버튼 노출 여부
	          adaptiveHeight: true, // 컨텐츠 높이에 따라 반응
	      });
	    });
  	</script>
  	<%@ include file="/resources/include/footer.jsp" %>
</body>
</html>