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
		<h2>내 게시글</h2>
		<table id="postTb">
			<c:if test="${empty myPost }">
				<div id="noPost">
					<p>작성한 게시글이 없습니다.</p>
				</div>
				<div class="boxArea">
					<a href="/boardInsert"><input type="button" value="글쓰기"></a>
				</div>
			</c:if>
			<c:if test="${!empty myPost }">
				<tr>
					<td colspan=5>
						<div class="boxArea">
							<input type="button" id="checkedDel" value="선택삭제">
							<a href="/boardInsert">
								<input type="button" value="글쓰기">
							</a>
						</div>
					</td>
				</tr>
				<tr>
					<td class="line1" width="5%"><input type="checkbox" id="checkAll"></td>
					<td class="line1" width="10%">No</td>
					<td class="line1" width="50%">Title</td>
					<td class="line1" width="20%">Date</td>
					<td class="line1" width="10%">Views</td>
				</tr>
				<c:forEach var="myPost" items="${myPost}">
				<tr class="hoverTr">
					<td><input type="checkbox" class="checkbox" data-no="${myPost.no }"></td>
					<td>${myPost.no }</td>
					<td><a href="/boardUpdate?no=${myPost.no }">${myPost.title }</a></td>
					<td>${myPost.iDate.substring(0,10) }</td>
					<td>${myPost.views }</td>
				</tr>
				</c:forEach>
			</c:if>
		</table>
		<div id="pagingDiv">
			<ul id="pageUl">
	   	 		<c:if test="${pmPost.prev}">
	    			<li class="pageLi"><a href="/myPage${pmPost.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
			    </c:if> 
	    		<c:forEach begin="${pmPost.startPage}" end="${pmPost.endPage}" var="idx">
	    			<li class="pageLi"><a href="/myPage${pmPost.makeQuery(idx)}">${idx}</a></li>
	    		</c:forEach>
	    		<c:if test="${pmPost.next && pmPost.endPage > 0}">
	    			<li class="pageLi"><a href="/myPage${pmPost.makeQuery(pmPost.endPage + 1)}">다음</a></li>
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
						url : '${pageContext.request.contextPath}/boardDeleteOK',
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