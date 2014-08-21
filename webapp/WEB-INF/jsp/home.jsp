<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/stylesheets/home.css" />
</head>
<body>
	<div id="bodyWrapper">
		<div id="contentWrapper">
			<canvas id="contentCanvas"></canvas>
		</div>
		<div id="rightSidebarWrapper">
			<div id="fileUploadDiv">
				<input type="file" style="width: 100%; height: 100%;"></input>
			</div>
		</div>
	</div>
</body>
<script type="text/html" id="imageBoxTemplate">
<div class="imageBox" style="background-image:url(<\%= backgroundURL %>);">
</div>
</script>
<script src="/javascripts/underscore-min.js"></script>
<script>
	var ctx = document.getElementById('contentCanvas').getContext('2d');
	var rightSidebar = document.getElementById('rightSidebarWrapper');
	var fileInput = document.querySelector('#fileUploadDiv input[type="file"]');
	var reader = new FileReader();
	
	fileInput.addEventListener('change', function() {
		var result;
		console.log('changed');
		reader.readAsDataURL(this.files[0]);
		
		reader.onloadend = function() {
			var imageBoxTemplate = _.template(document.getElementById('imageBoxTemplate').innerHTML);
			var imageBox = imageBoxTemplate({backgroundURL: this.result});
			rightSidebar.insertAdjacentHTML('afterbegin', imageBox);			
		}
	}, false);
	
	rightSidebar.addEventListener('click', function(e) {
		if (e.target.tagName === 'DIV') {
			var imageURL = e.target.style['background-image'];
			var URLComponent = imageURL.slice(4, imageURL.length - 1);
			var img = new Image();
			img.src = URLComponent;
			img.onload = function() {
				ctx.drawImage(img, 0, 0, 50, 50);
			};
		}
	}, false);
</script>
</html>