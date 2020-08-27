<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<c:url value="/resources/css/main.css?fast"/>" rel="stylesheet" type="text/css">
<link href="<c:url value="/resources/css/memberUpdate.css?fast"/>" rel="stylesheet" type="text/css">
<title>1 Day Helper</title>
</head>
<body>
	<%@ include file="/resources/include/nav_top.jsp" %>
	<%@ include file="/resources/include/header.jsp" %>
	<article>
		<input type="hidden" id="emailCheckResult" value="approve">
		<input type="hidden" id="certiNumCheckResult" value="approve">
		<form action="/memberUpdateOK" method="post" autocomplete="off" onsubmit="return resultCheck()" >
			<table id="memInsertTb">
				<caption>회원 정보수정</caption>
				<tr>
					<td>
						<input type="text" name="id" id="id" placeholder="아이디" value="${user.id }" readonly>
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
					<td><input type="text" name="name" id="name" placeholder="이름" value="${user.name }"></td>
				</tr>
				<tr>
					<td>
						<input type="email" name="email" id="email" placeholder="이메일" value="${user.email }">
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
						<input type="text" name="phone" id="phone" placeholder="휴대전화" value="${user.phone }">
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" name="yy" id="yy" placeholder="년(4자리)"  maxlength="4" value="${user.yy }" readonly>
						<select name="mm">
							<c:forEach var="i" begin="1" end="12">
								<option value="${i }" disabled <c:if test="${user.mm eq i }"> selected</c:if>>${i }</option>
							</c:forEach>
						</select>
						<input type="text" name="dd" id="dd" placeholder="일" value="${user.dd }" readonly>
					</td>
				</tr>
				<tr>
					<td>
						<select name="gender">
							<option value="none">성별</option>
							<option value="male" <c:if test="${user.gender eq 'male' }"> selected</c:if>>남자</option>
							<option value="female" <c:if test="${user.gender eq 'female' }"> selected</c:if>>여자</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" name="postCode" id="sample4_postcode" placeholder="우편번호" value="${user.postCode }">
						<input type="button" id="findPostCode" onclick="postCodeAPI()" value="우편번호 찾기">
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" name="roadAddress" id="sample4_roadAddress" placeholder="도로명주소" value="${user.roadAddress }">
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" name="numAddress" id="sample4_jibunAddress" placeholder="지번주소" value="${user.numAddress }">
						<span id="guide" style="color:#999;display:none"></span>
					</td>
				</tr>
				<tr>
					<td><input type="text" name="extraAddress" id="sample4_extraAddress" placeholder="참고항목" value="${user.extraAddress }"></td>
				</tr>
				<tr>
					<td><input type="text" name="detailAddress" id="sample4_detailAddress" placeholder="상세주소" value="${user.detailAddress }"></td>
				</tr>
				<tr>
					<td><input type="submit" id="regSubmit" value="정보수정">
				</td>
				<tr>
					<td style="float:right"><a href="javascript:void(0)" onclick="memberDel()">회원탈퇴</a></td>
				</tr>
			</table>
		</form>
	</article>
	<%@ include file="/resources/include/footer.jsp" %>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="<c:url value="/resources/js/postCodeAPI.js"/>"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script>
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
							$('#emailCheckMsg').text('인증을 진행해주세요.').css('color', 'blue');
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
			
			alert('인증번호를 발송했습니다.');
				
			$.ajax({
				url : '${pageContext.request.contextPath}/sendCertiNum?email='+email,
				type : 'get',
			});
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
			var emailCheckResult = $('#emailCheckResult').val();
			var certiNumCheckResult = $('#certiNumCheckResult').val();
			
			if(emailCheckResult == 'approve' &&
			   certiNumCheckResult == 'approve') {
				alert('회원정보를 수정하였습니다.');
				return true;
			} else {
				alert('입력하신 정보를 확인해주세요.');
				return false;
			}
				
		}
		function memberDel() {
			var msg = confirm('정말 회원탈퇴하시겠습니까?');
			
			if(msg) {
				location.href='/pwCheck?keyword=memberDelete';
			} else {
				location.reload();
			}
		}
	</script>
</body>
</html>