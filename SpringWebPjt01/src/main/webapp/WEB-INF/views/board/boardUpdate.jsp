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
		<form action="/boardUpdateOK" method="post" autocomplete="off" enctype="multipart/form-data" onsubmit="return resultCheck()">
			<table>
				<caption>게시글 수정</caption>
				<tr>
					<td><input type="text" name="title" id="title" placeholder="제목을 입력해주세요." value="${vo.title }"></td>
				</tr>
				<tr>
					<td>
						<input type="text" name="name" value="${user.name }" readonly>
						<input type="email" name="email" value="${user.email }" readonly>
					</td>
				</tr>
				<tr>
					<td>
						<input type=text id="datePicker" name="aDate" placeholder="날짜 선택" value="${vo.aDate }">						
						<input type="text" class="timePicker" name="sTime" id="sTime" placeholder="시간 시간" value="${vo.sTime }">
						<input type="text" class="timePicker" name="eTime" id="eTime" placeholder="종료 시간" value="${vo.eTime }">
					</td>
				</tr>
				<tr>
					<td>
						<select name="area" id="area">
							<option value="서울" <c:if test="${vo.area eq '서울' }">checked</c:if>>서울</option>
							<option value="부산" <c:if test="${vo.area eq '부산' }">checked</c:if>>부산</option>
							<option value="대구" <c:if test="${vo.area eq '대구' }">checked</c:if>>대구</option>
							<option value="인천" <c:if test="${vo.area eq '인천' }">checked</c:if>>인천</option>
							<option value="광주" <c:if test="${vo.area eq '광주' }">checked</c:if>>광주</option>
							<option value="대전" <c:if test="${vo.area eq '대전' }">checked</c:if>>대전</option>
							<option value="울산" <c:if test="${vo.area eq '울산' }">checked</c:if>>울산</option>
							<option value="세종" <c:if test="${vo.area eq '세종' }">checked</c:if>>세종</option>
							<option value="경기" <c:if test="${vo.area eq '경기' }">checked</c:if>>경기</option>
							<option value="강원" <c:if test="${vo.area eq '강원' }">checked</c:if>>강원</option>
							<option value="충북" <c:if test="${vo.area eq '충북' }">checked</c:if>>충북</option>
							<option value="충남" <c:if test="${vo.area eq '충남' }">checked</c:if>>충남</option>
							<option value="전북" <c:if test="${vo.area eq '전북' }">checked</c:if>>전북</option>
							<option value="전남" <c:if test="${vo.area eq '전남' }">checked</c:if>>전남</option>
							<option value="경북" <c:if test="${vo.area eq '경북' }">checked</c:if>>경북</option>
							<option value="경남" <c:if test="${vo.area eq '경남' }">checked</c:if>>경남</option>
							<option value="제주" <c:if test="${vo.area eq '제주' }">checked</c:if>>제주</option>
						</select>
						<input type="text" name="place" id="place" placeholder="자세한 장소를 입력해주세요." value="${vo.place }">
					</td>
				</tr>
				<tr>
					<td><textarea name="content" id="content">${vo.content }</textarea></td>
				</tr>
				<tr>
					<td id="fileInfoTd">
						<c:forEach var="fileInfo" items="${fileInfo }">
							<div class="fileInfo">
								${fileInfo.originName }
								<a href="#" class="fileDelete" data-no="${fileInfo.no }">삭제하기</a>
							</div>
						</c:forEach>
					</td>
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
					<td><input type="submit" value="수정 완료"><a href="/"><input type="button" value="취소" onclick="javascript:history.back()"></a></td>
				</tr>
			</table>
			<input type="hidden" name="id" value="${user.id }">
			<input type="hidden" name="id" value="${user.id }">
			<input type="hidden" name="no" id="no" value="${vo.no }">
		</form>
	</article>
	<%@ include file="/resources/include/footer.jsp" %>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 	<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
	<script>
		// 첨부파일 삭제
		$('.fileDelete').click(function(){
			var confirmMsg = confirm('파일을 삭제하시겠습니까?');
			
			if(confirmMsg) {
				var no = $(this).attr('data-no');
				
				$.ajax({
					url : '${pageContext.request.contextPath}/fileDeleteOK',
					type : 'post',
					traditional : true,
					data : {
						'no' : no
					},
					success : function(result) {
						if(result == 1) {
							alert('삭제되었습니다.');
							location.reload();
						} else {
							alert('삭제 실패');
						}
					}
				});
			}
		});
		
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
	</script>
</body>
</html>