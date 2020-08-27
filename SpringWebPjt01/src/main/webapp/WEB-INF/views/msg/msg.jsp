<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<c:url value="/resources/css/main.css?fast"/>" rel="stylesheet" type="text/css">
<link href="<c:url value="/resources/css/myPage.css?fast"/>" rel="stylesheet" type="text/css">
<title>1 Day Helper</title>
</head>
<body>
	<%@ include file="/resources/include/nav_top.jsp" %>
	<%@ include file="/resources/include/header.jsp" %>
	<article>
		<h2>메시지함</h2>
		<table id="msgTb">
			<c:if test="${empty myMsg }">
				<div id="noMsg">
					<p>받은 메시지가 없습니다.</p>
				</div>
			</c:if>
			<c:if test="${!empty myMsg}">
				<tr>
					<td colspan=6>
						<div class="boxArea">
							<input type="button" id="checkedDel" value="선택삭제">
						</div>
					</td>
				</tr>
				<tr>
					<td class="line1" width="5%"><input type="checkbox" id="checkAll"></td>
					<td class="line1" width="10%">No</td>
					<td class="line1" width="40%">Title</td>
					<td class="line1" width="15%">To</td>
					<td class="line1" width="15%">From</td>
					<td class="line1" width="20%">Date</td>
				</tr>
				<c:forEach var="myMsg" items="${myMsg }">
				<tr class="hoverTr">
					<td><input type="checkbox" class="checkbox" data-no="${myMsg.no }"></td>
					<td>${myMsg.no }</td>
					<td><a href="#" onclick="msgView()">${myMsg.title }</a></td>
					<td>${myMsg.receiver }</td>
					<td>${myMsg.sender }</td>
					<td>${myMsg.iDate.substring(0,10) }</td>
				</tr>
				<input type="hidden" id="msgNo" value="${myMsg.no }">
				</c:forEach>
			</c:if>
		</table>
		<div id="pagingDiv">
			<ul id="pageUl">
	   	 		<c:if test="${pmMsg.prev}">
	    			<li class="pageLi"><a href="/msgTo${pmMsg.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
			    </c:if> 
	    		<c:forEach begin="${pmMsg.startPage}" end="${pmMsg.endPage}" var="idx">
	    			<li class="pageLi"><a href="/msgTo${pmMsg.makeQuery(idx)}">${idx}</a></li>
	    		</c:forEach>
	    		<c:if test="${pmMsg.next && pmMsg.endPage > 0}">
	    			<li class="pageLi"><a href="/msgTo${pmMsg.makeQuery(pmPost.endPage + 1)}">다음</a></li>
	    		</c:if> 
  			</ul>
		</div>
	</article>
	<%@ include file="/resources/include/footer.jsp" %>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script>
		function msgView() {
			var msgNo = $('#msgNo').val();
			
			window.open('/msgView?no='+msgNo, '메시지 조회', 'width=500, height=500, left=200, top=200');
			
		}
		$('#checkedDel').click(function(){
			var cnt = $('input[class="checkbox"]:checked').length;
			if(cnt==0) {
				alert('삭제하실 글을 선택해주세요.');
			} else {
				var confirmMsg = confirm('정말 삭제하시겠습니까?');
				
				if(confirmMsg) {
					var arr = new Array();
					
					$('input[class="checkbox"]:checked').each(function(){
						arr.push($(this).attr('data-no'));
					});
					
					$.ajax({
						url : '${pageContext.request.contextPath}/msgDeleteOK',
						type : 'post',
						traditional : true,
						data : {
							'arr' : arr
						},
						success : function(result) {
							if(result == 1) {
								alert('삭제되었습니다.');
								location.reload();
							} else {
								alert('삭제 실패.');
							}
						}
					});
				}
			}
		});
		$('#checkAll').click(function(){
			var checkAll = $('#checkAll').prop('checked');
			
			if(checkAll) {
				$('.checkbox').prop('checked', true);
			} else {
				$('.checkbox').prop('checked', false);
			}
		});
	</script>
</body>
</html>