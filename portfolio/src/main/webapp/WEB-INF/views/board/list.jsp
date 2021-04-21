<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">개시판</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board List Page
			<button id="regBtn" class="btn btn-xs pull-right">Register New Board</button>
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>#번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th class="tbl_view">조회수</th>
							<th class="tbl_view">추천수</th>
						</tr>
					</thead>
					<c:forEach items="${toplist}" var="board">
						<tr class="toplist">
							<td><c:out value="${board.bno}" /></td>
							<!-- 자바스크립트를 이용해서 /board/get으로 이동 -->
							<%-- <td><a href='/board/get?bno=<c:out value="${board.bno}"/>'>
							<c:out value="${board.title}" /></a></td> --%>
							<td><a class="move" href='<c:out value="${board.bno}"/>'><c:out
											value="${board.title}" /> <b>[ <c:out value="${board.replyCnt}" /> ]</b></a></td>
							<td><c:out value="${board.writer}" /></td>
							<td><fmt:formatDate value="${board.regDate}"
									pattern="yyyy-MM-dd" /></td>
							<td><c:out value="${board.views}" /></td>
							<td><c:out value="${board.likes}" /></td>							
						</tr>
					</c:forEach>
					<c:forEach items="${list}" var="board">
						<tr>
							<td><c:out value="${board.bno}" /></td>
							<!-- 자바스크립트를 이용해서 /board/get으로 이동 -->
							<%-- <td><a href='/board/get?bno=<c:out value="${board.bno}"/>'>
							<c:out value="${board.title}" /></a></td> --%>
							<td><a class="move" href='<c:out value="${board.bno}"/>'><c:out
											value="${board.title}" /> <b>[ <c:out value="${board.replyCnt}" /> ]</b></a></td>
							<td><c:out value="${board.writer}" /></td>
							<td><fmt:formatDate value="${board.regDate}"
									pattern="yyyy-MM-dd" /></td>
							<td><c:out value="${board.views}" /></td>
							<td><c:out value="${board.likes}" /></td>							
						</tr>
					</c:forEach>
				</table>
				
				<!-- 검색 부분 -->
				<div class='row'>
					<div class="col-lg-12">
						<form id="searchForm" action="/board/list" method="get">
							<select name="type">
								<!-- 어떤 검색 유형이 선택되었는지 selected -->
								<option value="" <c:out value="${pageMaker.cri.type == null? 'selected' : ''}"/>>--</option>
								<option value="T" <c:out value="${pageMaker.cri.type == 'T'? 'selected' : ''}"/>>제목</option>
								<option value="C" <c:out value="${pageMaker.cri.type == 'C'? 'selected' : ''}"/>>내용</option>
								<option value="W" <c:out value="${pageMaker.cri.type == 'W'? 'selected' : ''}"/>>작성자</option>
								<option value="TC" <c:out value="${pageMaker.cri.type == 'TC'? 'selected' : ''}"/>>제목 or 내용</option>
								<option value="TW" <c:out value="${pageMaker.cri.type == 'TW'? 'selected' : ''}"/>>제목 or 작성자</option>
								<option value="TCW" <c:out value="${pageMaker.cri.type == 'TWC'? 'selected' : ''}"/>>제목 or 내용 or 작성자</option>
							</select>
							<input type="text" name="keyword" value="${pageMaker.cri.keyword}">
							<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
							<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
							<button class="btn btn-default">Search</button>
						</form>
					</div>
				</div>
				
				<!-- 페이징 처리 부분 -->
				<div class="pull-right">
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li class="paginate_button previous"><a href="${pageMaker.startPage - 1}">Previous</a></li>
						</c:if>
						<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
							<li class='paginate_button ${pageMaker.cri.pageNum == num ? "active" : ""} '><a href="${num}">${num}</a></li>						
						</c:forEach>
						<c:if test="${pageMaker.next}">
							<li class="paginate_button next"><a href="${pageMaker.endPage + 1}">Next</a></li>
						</c:if>
					</ul>
				</div><!-- end pagination -->
				<form id="actionForm" action="/board/list" method="get">
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
					<input type="hidden" name="type" value="${pageMaker.cri.type}">
					<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
				</form>
				
				<!-- Modal 추가 : bootstrap에서 제공하는 기능을 이용 -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">Modal title</h4>
							</div>
							<div class="modal-body">처리가 완료되었습니다.</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Close</button>
								<button type="button" class="btn btn-primary">Save
									changes</button>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->
			</div>
			<!-- /.table-responsive -->
		</div>
		<!-- /.panel-body -->
	</div>
	<!-- /.panel -->
</div>
<!-- /.col-lg-6 -->
</div>
<!-- /.row -->
<script type="text/javascript">
$(document).ready(function() {
	var result = '<c:out value="${result}" />';
	// /board/list url을 호출하면 구동
	checkModal(result);
	
	history.replaceState({}, null, null);	// 상태 테이블을 초기화
	
	
	//
	function checkModal(result) {
		if(result === '' || history.state) {	// 게시글 쓰기, 게시글 수정, 게시글 삭제
			return;
		}
		if(parseInt(result) > 0) {	// 게시글 번호가 존재
			$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
		}
		$("#myModal").modal("show");	// 모달창을 보여준다.
	}
	
	// 이벤트 : 게시글 쓰기 버튼을 누르면
	$("#regBtn").on("click", function() {
		
		self.location = "/board/register";
	});
	
	// 페이지 처리 요구
	var actionForm = $("#actionForm");
	$(".paginate_button a").on("click", function(e) {
		e.preventDefault();
		console.log("click");
		var pn = $(this).attr("href");
		actionForm.find("input[name='pageNum']").val(pn);
		actionForm.submit();
	});
	
	// 게시글 상세보기를 요청을 하면 처리하는 이벤트를 등록
	// 이벤트가 발생하면 처리
	$(".move").on("click", function(e) {
		e.preventDefault();
		actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
		actionForm.attr("action", "/board/get");
		actionForm.submit();
	});
	
	var searchForm = $("#searchForm");	// 검색을 하려고 하므로
	// Search 버튼이 눌리면 검색 유형과 검색어가 입력이 되었는지 검사를 하고
	// pageNum = 1로 설정을 하고 submit()실 실행
	$("#searchForm button").on("click", function(e) {
		if(!searchForm.find("option:selected").val()) {	// 검색유형이 선택되지 않으면
			alert("검색 종류를 선택하세요");
			return false;	// 서버로 전송을 하지 않음
		}
		if(!searchForm.find("input[name='keyword']").val()) {	// 검색어가 입력되지 않으면
			alert("검색어를 입력하세요");
			return false;	// 서버로 전송을 하지 않음
		}
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		searchForm.submit();
	});
});
</script>
<%@ include file="../includes/footer.jsp"%>