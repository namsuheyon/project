<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../includes/header.jsp"%>
<div class="row">
  <div class="col-lg-12">
	<h1 class="page-header">회원 가입</h1>
  </div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
  <div class="col-lg-12">
	<div class="panel panel-default">
	  <div class="panel-heading">회원 가입</div><!-- /.panel-heading -->
	  <div class="panel-body">
		<form role="form" action="/member/join" method="post">
		  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		  <div class="form-group">
		    <label>아이디</label><br>
		    <input style="width: 80%; display: inline-block;" class="form-control" placeholder="userid" name="userid" type="text" autofocus>
		    <button style="width: 18%; float: right" type="button" class="btn btn-default">중복검사</button>
		  </div>
		  <div class="form-group">
		    <label>암 &nbsp; 호</label>
		    <input class="form-control" placeholder="Password" name="userpw" type="password">
		  </div>
		  <div class="form-group">
		    <label>암호확인</label>
		    <input class="form-control" placeholder="Password 확인" name="userpw2" type="password">
		  </div>
		  <div class="form-group">
		    <label>이 &nbsp; 름</label>
		    <input class="form-control" placeholder="홍길동" name="username" type="text">
		  </div>
		  <button type="submit" class="btn btn-default">Join</button>
		  <button type="reset" class="btn btn-default">Reset</button>
		</form>
	  </div><!-- end panel-body -->
	</div><!-- end panel-body -->
  </div><!-- end panel -->
</div><!-- /.row -->
<script>
$(document).ready(function(e){
  var formObj = $("form[role='form']");
  var duplicated = true;
  $("button[type='submit']").on("click", function(e){ 
    e.preventDefault();
    if(duplicated == true) {
    	return false;
    }
    console.log("submit clicked");

    formObj.submit();
  });

  var csrfHeaderName = "${_csrf.parameterName}";
  var csrfTokenValue = "${_csrf.token}";
  $(document).ajaxSend(function(e, xhr, options) { 
      xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); 
  }); 
  
  $("button[type='button']").on("click", function(e){    
	e.preventDefault();
	console.log("button clicked");
	var inputUserId = $("input[name='userid']").val();
	var data = {
			_csrf: csrfTokenValue,
			userid: inputUserId
	      };
	$.ajax({
	    type: 'post',
		url: '/member/checkId',
	    data: data,
	    dataType: "text",
	    success: function(result){
	          console.log(result);
	          if(result == "possible") {
	        	  alert("사용 가능한 아이디 입니다.");
	        	  duplicated = false;
	          } else {
	        	  alert("중복된 사용자 입니다.");
	        	  duplicated = true;
	          }
	    }
	}); //$.ajax
  });

});
</script>
<%@ include file="../includes/footer.jsp" %>