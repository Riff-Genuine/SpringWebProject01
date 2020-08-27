<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<c:url value="/resources/css/main.css?fast"/>" rel="stylesheet" type="text/css">
<link href="<c:url value="/resources/css/memberInsert.css?fast"/>" rel="stylesheet" type="text/css">
<title>1 Day Helper</title>
</head>
<body>
	<%@ include file="/resources/include/nav_top.jsp" %>
	<%@ include file="/resources/include/header.jsp" %>
	<article>
		<input type="hidden" id="idCheckResult" value="negative">
		<input type="hidden" id="pwCheckResult" value="negative">
		<input type="hidden" id="emailCheckResult" value="negative">
		<input type="hidden" id="certiNumCheckResult" value="negative">
		<form action="/memberInsertOK" method="post" autocomplete="off" onsubmit="return resultCheck()" >
			<table id="memInsertTb">
				<caption>회원가입</caption>
				<tr>
					<td>
						<input type="text" name="id" id="id" placeholder="아이디" required>
						<div id="idCheckMsg"></div>	
					</td>
				</tr>
				<tr>
					<td><input type="password" name="pw" id="pw" placeholder="비밀번호" required></td>
				</tr>
				<tr>
					<td>
						<input type="password" name="pwConfirm" id="pwConfirm" placeholder="비밀번호 확인" required>
						<div id="pwCheckMsg"></div>	
					</td>
				</tr>
				<tr>
					<td><input type="text" name="name" id="name" placeholder="이름" required></td>
				</tr>
				<tr>
					<td>
						<input type="email" name="email" id="email" placeholder="이메일" required>
						<input type="button" id="sendCertiNum" value="인증번호 발송">
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" name="certiNum" id="certiNum" placeholder="인증번호 입력" style="display:none">
						<div id="emailCheckMsg"></div>	
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" name="phone" id="phone" placeholder="휴대전화" required>
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" name="yy" id="yy" placeholder="년(4자리)"  maxlength="4" required>
						<select name="mm">
							<c:forEach var="i" begin="1" end="12">
								<option value="${i }">${i }</option>
							</c:forEach>
						</select>
						<input type="text" name="dd" id="dd" placeholder="일" maxlength="2">
					</td>
				</tr>
				<tr>
					<td>
						<select name="gender">
							<option value="none">성별</option>
							<option value="male">남자</option>
							<option value="female">여자</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" name="postCode" id="sample4_postcode" placeholder="우편번호" readonly required>
						<input type="button" id="findPostCode" onclick="postCodeAPI()" value="우편번호 찾기">
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" name="roadAddress" id="sample4_roadAddress" placeholder="도로명주소" required readonly>
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" name="numAddress" id="sample4_jibunAddress" placeholder="지번주소" required readonly>
						<span id="guide" style="color:#999;display:none"></span>
					</td>
				</tr>
				<tr>
					<td><input type="text" name="extraAddress" id="sample4_extraAddress" placeholder="참고항목" required readonly></td>
				</tr>
				<tr>
					<td><input type="text" name="detailAddress" id="sample4_detailAddress" placeholder="상세주소" required></td>
				</tr>
				<tr>
					<td><input type="submit" id="regSubmit" value="회원가입">
				</td>
			</table>
		</form>
	</article>
	<%@ include file="/resources/include/footer.jsp" %>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="<c:url value="/resources/js/postCodeAPI.js"/>"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script>
		// 아이디 유효성 검사 및 중복체크
		$('#id').blur(function() {
			var id = $('#id').val();
			var pattern = /^[a-zA-Z0-9]{6,12}$/;
			
			if(pattern.test(id)) {
				$.ajax({
					url : '${pageContext.request.contextPath}/idCheck?id='+id,
					type : 'get',
					success : function(data) {
						if(data == 0) {
							$('#idCheckMsg').text('사용 가능한 아이디입니다.').css('color', 'blue');
							$('#idCheckResult').val('approve');
							$('#regSubmit').attr('disabled', false);
						} else {
							$('#idCheckMsg').text('사용중인 아이디입니다.').css('color', 'red');
							$('#idCheckResult').val('negative');
							$('#regSubmit').attr('disabled', true);							
						}
					}
				});	
			} else {
				$('#idCheckMsg').text('아이디는 6~12자이내 영문+숫자 조합만 가능합니다.').css('color', 'red');
				$('#idCheckResult').val('negative');
				$('#regSubmit').attr('disabled', true);
			}
		});
		// 비밀번호 유효성 검사
		$('#pwConfirm').blur(function() {
			var pw1 = $('#pw').val();
			var pw2 = $('#pwConfirm').val();
			var pattern = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,20}$/;
			
			if(pw1 != "" && pw2 != "") {
				if(!(pattern.test(pw2))) {
					$('#pwCheckMsg').text('비밀번호는 6~20자이내 대소문자/숫자/특수문자를 포함해야합니다.').css('color', 'red');
					$('#pwCheckResult').val('negative');					
				} else if(pw1 != pw2) {
					$('#pwCheckMsg').text('비밀번호가 같지 않습니다.').css('color', 'red');
					$('#pwCheckResult').val('negative');
				} else {
					$('#pwCheckMsg').text('사용가능한 비밀번호입니다.').css('color', 'blue');
					$('#pwCheckResult').val('approve');
				}
			}
		});
		// 이메일 중복체크
		$('#email').blur(function() {
			var email = $('#email').val();
			if(email != "") {
				$.ajax({
					url : '${pageContext.request.contextPath}/emailCheck?email='+email,
					type : 'get',
					success : function(data) {
						if(data == 0) {
							alert('사용 가능한 이메일입니다.');
							$('#emailCheckMsg').text('인증 번호를 입력해주세요.').css('color', 'red');
							$('#emailCheckResult').val('approve');
							$('#sendCertiNum').attr('disabled', false);
							$('#certiNum').show();
						} else {
							$('#emailCheckMsg').text('사용중인 이메일입니다.').css('color', 'red');
							$('#emailCheckResult').val('negative');
							$('#sendCertiNum').attr('disabled', true);
							$('#certiNum').hide();							
						}
					}
				});	
			} else {
				alert('이메일을 입력해주세요.');
			}
		});
		// 인증번호 발송
		$('#sendCertiNum').click(function() {
			var email = $('#email').val();
			
			if(email == "") {
				alert('이메일을 입력해주세요.');	
			} else {
				alert('인증번호를 발송했습니다.');
				
				$.ajax({
					url : '${pageContext.request.contextPath}/sendCertiNum?email='+email,
					type : 'get',
				});	
			}
		});
		// 인증번호 체크
		$('#certiNum').blur(function() {
			var certiNum = $('#certiNum').val();
			$.ajax({
				url : '${pageContext.request.contextPath}/certiNumCheck?certiNum='+certiNum,
				type : 'get',
				success : function(data) {
					if(data == 1) {
						$('#emailCheckMsg').text('인증번호가 다릅니다.').css('color', 'red');
						$('#certiNumCheckResult').val('negative');
					} else {
						alert('인증되었습니다.');
						$('#certiNumCheckResult').val('approve');
						$('#emailCheckMsg').text("");
						$('#sendCertiNum').attr('disabled', true);
						$('#certiNum').hide();
					}
				}
			});
		});
		function resultCheck() {
			var idCheckResult = $('#idCheckResult').val();
			var pwCheckResult = $('#pwCheckResult').val();
			var emailCheckResult = $('#emailCheckResult').val();
			var certiNumCheckResult = $('#certiNumCheckResult').val();
			
			if(idCheckResult == 'approve' &&
			   pwCheckResult == 'approve' &&
			   emailCheckResult == 'approve' &&
			   certiNumCheckResult == 'approve') {
				alert('회원가입이 완료되었습니다.');
				return true;
			} else {
				alert('입력하신 정보를 확인해주세요.');
				return false;
			}
				
		}
	</script>
</html>