<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<c:url value="/resources/css/main.css?fast"/>" rel="stylesheet" type="text/css">
<link href="<c:url value="/resources/css/index.css?fast"/>" rel="stylesheet" type="text/css">
<title>1 Day Helper</title>
</head>
<body>
	<%@ include file="/resources/include/nav_top.jsp" %>
	<%@ include file="/resources/include/header.jsp" %>
	<article>
		<table>
			<tr>
				<td class="line1" width="10%">No</td>
				<td class="line1" width="50%">Title</td>
				<td class="line1" width="10%">Area</td>
				<td class="line1" width="20%">Date</td>
				<td class="line1" width="10%">Views</td>
			</tr>
			<c:forEach var="allPost" items="${allPost }">
				<tr class="hoverTr">
					<td>${allPost.no }</td>
					<td><a href="/boardView?no=${allPost.no}">${allPost.title }</a></td>
					<td>${allPost.area }</td>
					<td>${allPost.iDate.substring(0,10) }</td>
					<td>${allPost.views }</td>
				</tr>
			</c:forEach>			
		</table>
		<div id="pagingDiv">
			<ul id="pageUl">
	   	 		<c:if test="${pmIndex.prev}">
	    			<li class="pageLi"><a href="/${pmIndex.makeQuery(pmIndex.startPage - 1)}">이전</a></li>
			    </c:if> 
	    		<c:forEach begin="${pmIndex.startPage}" end="${pmIndex.endPage}" var="idx">
	    			<li class="pageLi"><a href="/${pmIndex.makeQuery(idx)}">${idx}</a></li>
	    		</c:forEach>
	    		<c:if test="${pmIndex.next && pmIndex.endPage > 0}">
	    			<li class="pageLi"><a href="/${pmIndex.makeQuery(pmIndex.endPage + 1)}">다음</a></li>
	    		</c:if> 
  			</ul>
		</div>
	</article>
	<%@ include file="/resources/include/footer.jsp" %>
</body>
</html>