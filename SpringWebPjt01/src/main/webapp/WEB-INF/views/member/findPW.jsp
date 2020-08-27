<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<c:url value="/resources/css/popup.css?fast"/>" rel="stylesheet" type="text/css">
<title>1 Day Helper</title>
</head>
<body>
	<article>
		<table>
			<caption>이메일을 입력해주세요.</caption>
			<tr>
				<td>
					<input type="email" id="email" placeholder="이메일">
					<div id="emailCheckMsg"></div>
				</td>
			</tr>
			<tr>
				<td>
					<input type="button" id="submitBtn" value="확인">
				</td>
			</tr>
		</table>
	</article>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script>
		// 이메일 확인
		$('#email').blur(function(){
			var email = $('#email').val();
			
			if(email == "") {
				alert('이메일을 입력해주세요.');
			} else {
				$.ajax({
					url : '${pageContext.request.contextPath}/emailCheck?email='+email,
					type : 'get',
					async: false,
					success : function(data) {
						if(data == 0) {
							$('#emailCheckMsg').text('가입 정보가 없습니다.').css('color', 'red');
							$('#submitBtn').attr('disabled', true);
						} else {
							$('#emailCheckMsg').text('');
							$('#submitBtn').attr('disabled', false);
						}
					}
				});	
			}
		});
		$('#submitBtn').click(function(){
			var email = $('#email').val();
			
			if(email == "") {
				alert('이메일을 입력해주세요.');
			} else {
				alert('임시 비밀번호를 발급하였습니다.');
				
				$.ajax({
					url : '${pageContext.request.contextPath}/createNewPw?email='+email,
					type : 'get',
					async: false,
				});
				
				window.close();
			}
		});
		
	</script>
</body>
</html>