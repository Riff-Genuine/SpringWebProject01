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
		<h2>내 문의글</h2>
		<table id="qnaTb">
			<c:if test="${empty myQna }">
				<div id="noQna">
					<p>문의내역이 없습니다.</p>
				</div>
				<div class="boxArea">
					<a href="/qnaInsert"><input type="button" value="문의하기"></a>
				</div>
			</c:if>
			<c:if test="${!empty myQna }">
				<tr>
					<td colspan=5>
						<div class="boxArea">
							<input type="button" id="checkedDel" value="선택삭제">
							<a href="/qnaInsert"><input type="button" value="문의하기"></a>
						</div>
					</td>
				</tr>
				<tr>
					<td class="line1" width="5%"><input type="checkbox" id="checkAll"></td>
					<td class="line1" width="10%">No</td>
					<td class="line1" width="50%">Title</td>
					<td class="line1" width="20%">Date</td>
					<td class="line1" width="10%">Answer</td>
				</tr>
				<c:forEach var="myQna" items="${myQna }">
				<tr class="hoverTr">
					<td><input type="checkbox" class="checkbox" data-no="${myQna.no }"></td>
					<td>${myQna.no }</td>
					<td><a href="/qnaView?no=${myQna.no }">${myQna.title }</a></td>
					<td>${myQna.iDate.substring(0,10) }</td>
					<td>
						<c:if test="${myQna.answer eq null }">N</c:if>
						<c:if test="${myQna.answer ne null }">Y</c:if>
					</td>
				</tr>
				</c:forEach>
			</c:if>
		</table>
		<div id="pagingDiv">
			<ul id="pageUl">
	   	 		<c:if test="${pmQna.prev}">
	    			<li class="pageLi"><a href="/qna${pmQna.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
			    </c:if> 
	    		<c:forEach begin="${pmQna.startPage}" end="${pmQna.endPage}" var="idx">
	    			<li class="pageLi"><a href="/qna${pmQna.makeQuery(idx)}">${idx}</a></li>
	    		</c:forEach>
	    		<c:if test="${pmQna.next && pmQna.endPage > 0}">
	    			<li class="pageLi"><a href="/qna${pmQna.makeQuery(pmPost.endPage + 1)}">다음</a></li>
	    		</c:if> 
  			</ul>
		</div>
	</article>
	<%@ include file="/resources/include/footer.jsp" %>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script>
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
						url : '${pageContext.request.contextPath}/qnaDeleteOK',
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