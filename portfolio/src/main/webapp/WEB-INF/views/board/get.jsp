
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@include file="../includes/header.jsp"%>

<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

.uploadResult ul li img {
	width: 100px;
}

.uploadResult ul li span {
	color: white;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255, 255, 255, 0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}
</style>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">Board Read Page</div>
			<!-- /.panel-heading -->
			<div class="panel-body">

				<div class="form-group get_title_group">
					<samp class="get_title">
						<c:out value="${board.title }" />
					</samp>
					<samp class="get_writer">
						작성자 :
						<c:out value="${board.writer }" />
					</samp>
				</div>
				<!-- 본문부분 -->
				<div class="form-group">
					<textarea class="form-control" rows="10" name='content'
						readonly="readonly"><c:out value="${board.content}" /></textarea>
				</div>
				<!-- <button data-oper='modify' class="btn btn-default">Modify</button> -->
				<sec:authentication property="principal" var="pinfo" />
				<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.username eq board.writer}">
						<button data-oper='modify' class="btn btn-default">Modify</button>
					</c:if>
				</sec:authorize>

				<form id='operForm' action="/boad/modify" method="get">
					<input type='hidden' id='bno' name='bno'
						value='<c:out value="${board.bno}"/>'> <input
						type='hidden' name='pageNum'
						value='<c:out value="${cri.pageNum}"/>'> <input
						type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
					<input type='hidden' name='keyword'
						value='<c:out value="${cri.keyword}"/>'> <input
						type='hidden' name='type' value='<c:out value="${cri.type}"/>'>
				</form>
			</div>
			<!--  end panel-body -->
			<div class='bigPictureWrapper'>
				<div class='bigPicture'></div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="form-group panel-default">
						<div class="panel-heading">Files</div>
						<!-- /.panel-heading -->
						<div class="panel-body">
							<div class='uploadResult'>
								<ul>
								</ul>
							</div>
						</div>
						<!--  end panel-body -->
					</div>
					<!--  end panel-body -->
				</div>
				<!-- end panel -->
			</div>
			<!-- /.row -->

		</div>
		<!--  end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- /.row -->
<!-- 추천 기능 -->
<div>
	<div class="w3-border w3-center w3-padding">
		<sec:authorize access="isAuthenticated()">
			<button class="likesbtn">
				<div>추천</div>
				<span class="likes_count"> </span>
			</button>
		</sec:authorize>
	</div>
</div>

<div class='row'>
	<div class="col-lg-12">
		<!-- /.panel -->
		<div class="panel panel-default">

			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> Reply
				<!-- <button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button> -->

			</div>
			<div class="w3-right">
				<sec:authorize access="isAuthenticated()">
					<div class="input-group">
						<input type="text" id="reply_addtext" class="form-control">
						<span class="input-group-btn">
							<button class="btn btn-default reply_addbtn" type="button">댓글
								등록</button>
						</span>
					</div>
					<!-- /input-group -->
				</sec:authorize>
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<ul class="chat">
					<!-- start reply -->
					<li class="left clearfix" data-rno='12'>
						<div>
							<div class="header">
								<strong class="primary-font">user00</strong> <small
									class="pull-right text-muted">2018-01-01 13:13</small>
							</div>
							<p>Good job!</p>
							<button class="pull-right reply_modbtn">수정</button>
							<button class="pull-right">답글</button>
							<button class="pull-right reply_removebtn" type="button">
								삭제</button>
						</div>
					</li>
					<!-- end reply -->
				</ul>
				<!-- ./ end ul -->
			</div>
			<!-- /.panel .chat-panel -->

			<div class="panel-footer"></div>
		</div>
	</div>
	<!-- ./ end row -->
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label> <input class="form-control" name='reply'
						value='New Reply!!!!'>
				</div>
				<div class="form-group">
					<label>Replyer</label> <input class="form-control" name='replyer'
						value='replyer'>
				</div>
				<div class="form-group">
					<label>Reply Date</label> <input class="form-control"
						name='replyDate' value='2018-01-01 13:13'>
				</div>
			</div>
			<div class="modal-footer">
				<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
				<button id='modaladdreplyBtn' type="button" class="btn btn-danger">addreply</button>
				<button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<script type="text/javascript" src="/resources/js/reply.js"></script>
<script>
$(document).ready(function() {
	 
	var replyer = null;
	 <sec:authorize access="isAuthenticated()">
			replyer = '<sec:authentication property="principal.username"/>';
	  </sec:authorize>
	  
	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $(".chat");
	
	showList(1);
	
	function showList(page) {
		console.log("show list " + page);
		replyService.getList({bno:bnoValue, page: page|| 1}, function(replyCnt, list) {
			console.log("replyCnt: " + replyCnt);
			console.log("list: " + list);
			
			if(page == -1) {
				pageNum = Math.ceil(replyCnt / 10.0);
				showList(pageNum);
				return;
			}
			var str = "";
			if(list == null || list.length == 0) {
				replyUL.html("");
				return;
			}
			var arr = []; 
			var k = 0;
			for(var i = 0, len = list.length || 0; i < len; i++) {
				if(list[i].child_bool == 1) {
					if(list[i].parent_rno == 0) {
						arr[k] = list[i];
						k++;
					}
					
					for(var j = 0; j < list.length || 0; j++) {
						if((list.length) <= k) {
							return;						
						}
						if(list[j].parent_rno == list[i].rno ) {	
									arr[k] = list[j];
									k++;
						}
					}
					continue;
				}
				if(list[i].parent_rno != 0) {
					continue;
				}
				arr[k] = list[i];
				k++;
			}		
			for(var i = 0, len = arr.length || 0;i < len;i++) {
				if(arr[i].parent_rno != 0) {
					str +="<li class='left clearfix reply'>";
				    str +="  <div><div class='header'><strong class='primary-font'>↪ ["
				        +arr[i].rno+"] "+arr[i].replyer+"</strong>"; 
				    str +="    <small class='pull-right text-muted'>"
				        +replyService.displayTime(arr[i].replyDate)+"</small></div>";
				    str +="    <p>"+arr[i].reply+"</p> ";
				    str +=" <button class='pull-right btn_size reply_modbtn' data-rno='"+arr[i].rno+"'>수정 </button>"
				    str +=" <button class='reply_removebtn pull-right btn_size' type='button' data-rno='"+arr[i].rno+"'>삭제 </button></div></li>"; 			
				}else {	
				str +="<li class='left clearfix'>";
			    str +="  <div><div class='header'><strong class='primary-font'>["
			        +arr[i].rno+"] "+arr[i].replyer+"</strong>"; 
			    str +="    <small class='pull-right text-muted'>"
			        +replyService.displayTime(arr[i].replyDate)+"</small></div>";
			    str +="    <p>"+arr[i].reply+"</p> ";
			    str +=" <button class='pull-right btn_size reply_modbtn' data-rno='"+arr[i].rno+"'>수정 </button>"
			    str +=" <button class='pull-right btn_size reply_addreplybtn' data-rno='"+arr[i].rno+"'>답글 </button>"
			    str +=" <button class='reply_removebtn pull-right btn_size' type='button' data-rno='"+arr[i].rno+"'>삭제 </button></div></li>"; 
				}
			}
			replyUL.html(str);
			showReplyPage(replyCnt);
		});
	}//end showlist
	var csrfHeaderName ="${_csrf.headerName}"; 
	var csrfTokenValue ="${_csrf.token}";
	  
	var pageNum = 1;
    var replyPageFooter = $(".panel-footer");
    
    function showReplyPage(replyCnt){
      var endNum = Math.ceil(pageNum / 10.0) * 10;  
      var startNum = endNum - 9;       
      var prev = startNum != 1;
      var next = false;
      
      if(endNum * 10 >= replyCnt){
        endNum = Math.ceil(replyCnt/10.0);
      }
      if(endNum * 10 < replyCnt){
        next = true;
      }
      var str = "<ul class='pagination pull-right'>";
      if(prev){
        str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
      }
      for(var i = startNum ; i <= endNum; i++){
        var active = pageNum == i? "active":"";
        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
      }
      if(next){
        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
      }
      str += "</ul></div>";
      console.log(str);
      replyPageFooter.html(str);
    }
    //뎃글 페이지 클릭시
    replyPageFooter.on("click","li a", function(e){
       e.preventDefault();
       console.log("page click");
       var targetPageNum = $(this).attr("href");
       console.log("targetPageNum: " + targetPageNum);
       pageNum = targetPageNum;
       showList(pageNum);
    });
    var modal = $(".modal");
    var modalInputReply = modal.find("input[name='reply']");
    var modalInputReplyer = modal.find("input[name='replyer']");
    var modalInputReplyDate = modal.find("input[name='replyDate']");
    
    var modalModBtn = $("#modalModBtn");
    var modalRemoveBtn = $("#modalRemoveBtn");
    var modaladdreplyBtn = $("#modaladdreplyBtn");
    $("#modalCloseBtn").on("click", function(e){	
    	modal.modal('hide');
    });
    $(document).ajaxSend(function(e, xhr, options) { 
        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); 
    }); 
    // 뎃글 등록부분 
     $(".reply_addbtn").on("click",function(e){
    	 if( !(replyer) ) {
       	  alert("로그인후 입력이 가능합니다.");
       	  return;
    	 }
      var reply = {  
          reply: $("#reply_addtext").val(),
          replyer: replyer,  
          bno:${board.bno}
      };
      replyService.add(reply, function(result){
          alert(result);
       
          showList(-1);          
      });
    });
  
     //수정
     $(".chat").on("click", ".reply_modbtn" ,function(e){
    	 var rowno = $(this).data("rno");
         console.log(rowno);
         if(!replyer){
  			alert("로그인후 수정이 가능합니다.");
  			modal.modal("hide");
  			return;
  		}
         
        replyService.get(rowno, function(replys){
        	if(replyer != replys.replyer){
     			alert("자신이 작성한 댓글만 수정이 가능합니다.");
     			return;
     		}
                modalInputReply.val(replys.reply);
                modalInputReplyer.val(replys.replyer).attr("readonly","readonly");;
                modalInputReplyDate.val(replyService.displayTime( replys.replyDate))
                .attr("readonly","readonly");
                modal.data("rno", replys.rno);
                
                modal.find("button[id !='modalCloseBtn']").hide();
                modalModBtn.show();
                
                $(".modal").modal("show");        
           });
   		 }); 
     modalModBtn.on("click", function(e){
     	var originalReplyer = modalInputReplyer.val();
 		var reply = {
 		      rno:modal.data("rno"), 
 		      reply: modalInputReply.val(),
 		      replyer: originalReplyer};
     
     	   replyService.update(reply, function(result){
      	   alert(result);
      	   modal.modal("hide");
      	   showList(pageNum);
       });
     });
    //삭제
	$(".chat").on("click", ".reply_removebtn" , function (e){
      var rowno = $(this).data("rno");
	  console.log("RNO: " + rowno);
	  replyService.get(rowno, function(replys){
    	  
		  if(!replyer){
	   		  alert("로그인후 삭제가 가능합니다.");
	   		  return;
	   	  }
		  if(replyer  != replys.replyer){
	   		  alert("자신이 작성한 댓글만 삭제가 가능합니다.");
	   		  return;
	   	  }
		  replyService.remove(rowno, replys.replyer, function(result){
			    alert(result);
			    showList(pageNum); 
			  });
	     });
	});
	 //답글
	  $(".chat").on("click", ".reply_addreplybtn", function (e){
      var rowno = $(this).data("rno");
	  console.log("RNO: " + rowno);
	  if(!replyer){
   		  alert("로그인후 답글이 가능합니다.");
   		  return;
   	  }
	  replyService.get(rowno, function(replys){
		  modal.find("input[name='reply']").val("");
          modalInputReplyer.val(replyer).attr("readonly","readonly");;
          modalInputReplyDate.val(replyService.displayTime( replys.updateDate))
          .attr("readonly","readonly");
          modal.data("rno", replys.rno);
          modal.find("button[id !='mod	alCloseBtn']").hide();
          modaladdreplyBtn.show();
          
          $(".modal").modal("show"); 
		  
	     });
	});  
	  modaladdreplyBtn.on("click", function(e){
		  var reply = {
		          reply: modalInputReply.val(),
		          replyer:replyer,
		          bno: bnoValue,
		          parent_rno: modal.data("rno") 
		      };
	     	   replyService.addreply(reply, function(result){
	      	   alert(result);
	      	   modal.find("input").val("");
	      	   modal.modal("hide");
	      	   showList(pageNum);
	       });
	     });
    
  var operForm = $("#operForm"); 
  
  $("button[data-oper='modify']").on("click", function(e){
    operForm.attr("action","/board/modify").submit();
  });
  $("button[data-oper='list']").on("click", function(e){
    operForm.find("#bno").remove();
    operForm.attr("action","/board/list")
    operForm.submit();
  });
  
  
  (function() {
	var bno = '<c:out value="${board.bno}"/>';
	$.getJSON("/board/getAttachList", {bno: bno}, function(arr){
	  console.log(arr);	       
	  var str = "";
	  $(arr).each(function(i, attach){
	    //image type
	    if(attach.fileType){
	      var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
	      str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
	      str += "<img src='/display?fileName="+fileCallPath+"'>";
	      str += "</div>";
	      str +"</li>";
	    }else{
	      str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
	      str += "<span> "+ attach.fileName+"</span><br/>";
	      str += "<img src='/resources/img/attach.png'></a>";
	      str += "</div>";
	      str +"</li>";
	    }
	  });
      $(".uploadResult ul").html(str);
	});//end getjson
  })();
  $(".uploadResult").on("click","li", function(e){
	console.log("view image");
	var liObj = $(this);
	var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
	if(liObj.data("type")){
	  showImage(path.replace(new RegExp(/\\/g),"/"));
	}else {
	  //download 
	  self.location ="/download?fileName="+path
	}
  });
  function showImage(fileCallPath){
    alert(fileCallPath);
	$(".bigPictureWrapper").css("display","flex").show();
	$(".bigPicture")
	  .html("<img src='/display?fileName="+fileCallPath+"' >")
	  .animate({width:'100%', height: '100%'}, 1000);
  }
  $(".bigPictureWrapper").on("click", function(e){
	$(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
	setTimeout(function(){
	  $('.bigPictureWrapper').hide();
	}, 1000);
  });
  

//추천버튼 클릭시(추천 추가 또는 추천 제거)
<sec:authorize access="isAuthenticated()">
	$(".likesbtn").click(function(){
		$.ajax({
			url: "/likes/update",
          type: "POST",
          data: {
              bno: "${board.bno}",
              username: "${pinfo.username}"
          },
          success: function () {
		        Count();
          },
		})
	})
</sec:authorize>
	// 게시글 추천수
    function Count() {
		$.ajax({
			url: "/likes/count",
          type: "POST",
          data: {
          	bno: "${board.bno}", 
            _csrf: csrfTokenValue
          },
          success: function (count) {
          	$(".likes_count").html(count);
          },
		})
 	};
  Count(); // 처음 시작했을 때 실행되도록 해당 함수 호출  
});

</script>

<%@include file="../includes/footer.jsp"%>