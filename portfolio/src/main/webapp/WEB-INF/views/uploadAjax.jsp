<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
}
.uploadResult ul li img {
	width: 20px;
}
.bigPictureWrapper {
  position: absolute;
  display: none;
  justify-content: center;
  align-items: center;
  top:0%;
  width:100%;
  height:100%;
  background-color: gray; 
  z-index: 100;
}
.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}
.bigPicture img {
  width: 600px;
}
</style>
</head>
<body>
<h1>Upload with Ajax</h1>
<div class="uploadDiv">
	<input type="file" name="uploadFile" multiple>
</div>
<button id="uploadBtn">Upload</button>
<div class="uploadResult"><!-- 첨부 파일 추가된 결과를 보여주는 창 -->
	<ul><!-- li 태그를 이용해서 첨부파일을 리스트 -->
	
	</ul>
</div>
<div class='bigPictureWrapper'>
	<div class='bigPicture'>
	
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
// 원본 이미지 파일을 보여주는 함수
function showImage(fileCallPath) {
	alert(fileCallPath);
	
	$(".bigPictureWrapper").css("display","flex").show();
	  
	$(".bigPicture")
		.html("<img src='/display?fileName="+ encodeURI(fileCallPath)+"'>")
		.animate({width:'100%', height: '100%'}, 1000);
}

$(document).ready(function() {
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880;	// 5MB
	  
	function checkExtension(filename, filesize) {
		if(filesize > maxSize) {
			alert("파일 크기 초과");
			return false;
		}
		if(regex.test(filename)) {
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	var cloneObj = $(".uploadDiv").clone();
	
	$("#uploadBtn").on("click", function(e) {
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		console.log(files);
		
		for(var i = 0;i < files.length;i++) {
			if(!checkExtension(files[i].name, files[i].size)) {
				  return false;
			}
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url: '/uploadAjaxAction',
			processData: false,	// 규칙
			contentType: false,	// 규칙
			data: formData,
			type: 'POST',
			dataType: 'json',	// 응답을 JSON 형태로 수신
			success: function(result) {
				alert(result);
				showUploadedFile(result);
				// upload 완료
				var uploadDiv = $(".uploadDiv");
				uploadDiv.html(cloneObj.html());
			}
		});
	});
	
	var uploadResult = $(".uploadResult ul");
	function showUploadedFile(uploadResultArr) {
		var str = "";
		// Controller로부터 List<AttachFileDTO> 응답을 수신 
		$(uploadResultArr).each(function(i, obj) {
			if(!obj.image) {	// 일반 파일(이미지가 아님)
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
				  var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
				  str += "<li><div><a href='/download?fileName=" + fileCallPath + "'>" +
					"<img src='/resources/img/attach.png'>"	+ obj.fileName + "</a>" +
					"<span data-file=\'" + fileCallPath + "\' data-type='file'> x </span>" +
					"</div></li>";
			} else {
				// str += "<li>" + obj.fileName + "</li>";
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
				  originPath = originPath.replace(new RegExp(/\\/g), "/");
				  str += "<li><a href=\"javascript:showImage(\'" + originPath +
						"\')\"><img src='/display?fileName=" + fileCallPath + "'></a>" +
						"<span data-file=\'" + fileCallPath + "\' data-type='image'> x </span>" +
						"</li>";
			}
		});
		uploadResult.append(str);
	}
	
	$(".uploadResult").on("click","span", function(e){
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		console.log(targetFile);
		  
		$.ajax({
		    url: '/deleteFile',
		    data: {fileName: targetFile, type:type},
		    dataType:'text',
		    type: 'POST',
		      success: function(result){
		         alert(result);
		      }
		}); //$.ajax  
	  });
	
	$(".bigPictureWrapper").on("click", function(e){
		$(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
//		setTimeout(() => {
//			$(this).hide();
//		}, 1000);
		 
		// IE 11때문에 수정 필요
		setTimeout(function() {
		  $(".bigPictureWrapper").hide();
		}, 1000);
	});
});
</script>
</body>
</html>