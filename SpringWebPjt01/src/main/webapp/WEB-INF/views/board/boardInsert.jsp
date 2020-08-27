<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<link href="<c:url value="/resources/css/main.css?fast"/>" rel="stylesheet" type="text/css">
<link href="<c:url value="/resources/css/boardInsert.css?fast"/>" rel="stylesheet" type="text/css">
<title>1 Day Helper</title>
</head>
<body>
	<%@ include file="/resources/include/nav_top.jsp" %>
	<%@ include file="/resources/include/header.jsp" %>
	<article>
		<form action="/boardInsertOK" method="post" autocomplete="off" enctype="multipart/form-data" onsubmit="return resultCheck()">
			<table>
				<caption>게시글 작성</caption>
				<tr>
					<td><input type="text" name="title" id="title" placeholder="제목을 입력해주세요."></td>
				</tr>
				<tr>
					<td>
						<input type="text" name="name" value="${user.name }" readonly>
						<input type="email" name="email" value="${user.email }" readonly>
					</td>
				</tr>
				<tr>
					<td>
						<input type=text id="datePicker" name="aDate" placeholder="날짜 선택" readonly>
						<input type="text" class="timePicker" id="sTime" name="sTime" placeholder="시간 시간" readonly>
						<input type="text" class="timePicker" id="eTime" name="eTime" placeholder="종료 시간" readonly>
					</td>
				</tr>
				<tr>
					<td>
						<select name="area" id="area">
							<option value="none">지역</option>
							<option value="서울">서울</option>
							<option value="부산">부산</option>
							<option value="대구">대구</option>
							<option value="인천">인천</option>
							<option value="광주">광주</option>
							<option value="대전">대전</option>
							<option value="울산">울산</option>
							<option value="세종">세종</option>
							<option value="경기">경기</option>
							<option value="강원">강원</option>
							<option value="충북">충북</option>
							<option value="충남">충남</option>
							<option value="전북">전북</option>
							<option value="전남">전남</option>
							<option value="경북">경북</option>
							<option value="경남">경남</option>
							<option value="제주">제주</option>
						</select>
						<input type="text" name="place" id="place" placeholder="자세한 장소를 입력해주세요.">	
					</td>
				</tr>
				<tr>
					<td><textarea name="content" id="content"></textarea></td>
				</tr>
				<tr>
					<td style="float:right">
						<div id="fileDiv"></div>
					</td>
				</tr>
				<tr>
					<td style="float:right"><a href="#" id="add">파일 추가하기</a></td>
				</tr>
				<tr>
					<td><input type="submit" value="작성 완료"><a href="/"><input type="button" value="작성 취소" onclick="javascript:history.back()"></a></td>
				</tr>
				<tr>
					<td><input type="hidden" name="id" value="${user.id }"></td>
				</tr>
			</table>
		</form>
	</article>
	<%@ include file="/resources/include/footer.jsp" %>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 	<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
	<script>
		// 파일 추가 삭제
		var cnt = 0;
		$('#add').click(function(){
			var str = '<input type="file" class="file" name="file_'+(cnt++)+'"><a href="#" class="delete">삭제하기</a><br>';
			$('#fileDiv').append(str);
			
			$('.delete').click(function(){
				$(this).prev().remove();
				$(this).next().remove();
				$(this).remove();
			});
		});
		function resultCheck() {
			if($('#title').val()==''){
				alert('제목을 입력해주세요.');
				return false;
			}
			if($('#datePicker').val()==''){
				alert('날짜를 선택해주세요.');
				return false;
			}
			else if($('#sTime').val()==''){
				alert('시작 시간을 선택해주세요.');
				return false;
			}
			else if($('#eTime').val()==''){
				alert('종료 시간을 선택해주세요.');
				return false;
			}
			else if($('#area').val()=='none'){
				alert('지역을 선택해주세요.');
				return false;
			}
			else if($('#place').val()=='') {
				alert('장소를 입력해주세요.');
				return false;
			}
			else if($('#hPoint').val()=='none'){
				alert('헬퍼 포인트를 선택해주세요.');
				return false;
			}
			else if($('#content').val()=='') {
				alert('내용을 입력해주세요.');
				return false;
			}
			else return true;
		
		}
		// 달력 설정
		$('#datePicker').datepicker();
		$.datepicker.setDefaults({
			minDate:0,
	        dateFormat: 'yy-mm-dd',
	        prevText: '이전 달',
	        nextText: '다음 달',
	        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	        showMonthAfterYear: true,
	        yearSuffix: '년'
	    });
		// 시간 설정
		$('.timePicker').timepicker({
			timeFormat: 'p HH:mm',
		    interval: '10',
		    minTime: '00',
		    maxTime: '23:50',
		    startTime: '00:00',
		    dynamic: false,
		    dropdown: true,
		    scrollbar: true
		});
	</script>
</body>
</html>