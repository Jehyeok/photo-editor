<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/stylesheets/home.css" />
</head>
<body>
	<div id="bodyWrapper">
		<div id="contentWrapper">
			<div id="content" class="content">
			
			</div>
		</div>
		<div id="rightSidebarWrapper">
			<div id="fileUploadDiv">
				<input type="file" style="width: 100%; height: 100%;"></input>
			</div>
		</div>
	</div>
</body>
<script type="text/html" id="imageInSidebarTemplate">
<div class="imageBox" draggable="true"
	style="
		background-image: url(<\%= backgroundURL %>);
">
</div>
</script>
<script type="text/html" id="imageInContentTemplate">
<div draggable="true" style="
	background-image: <\%= backgroundURL %>;
	background-size: cover;
	position: absolute;
	width: <\%= width %>;
	height: <\%= height %>;
	left: <\%= left %>;
	top: <\%= top %>;
">
</div>	
</script>
<script src="/javascripts/underscore-min.js"></script>
<script>
	var content = document.getElementById('content');
	var rightSidebar = document.getElementById('rightSidebarWrapper');
	var fileInput = document.querySelector('#fileUploadDiv input[type="file"]');
	var reader = new FileReader();
	
	fileInput.addEventListener('change', function() {
		var result;
		console.log('changed');
		reader.readAsDataURL(this.files[0]);
		
		reader.onloadend = function() {
			var imageInSidebarTemplate = _.template(document.getElementById('imageInSidebarTemplate').innerHTML);
			var image = imageInSidebarTemplate({backgroundURL: this.result});
			rightSidebar.insertAdjacentHTML('afterbegin', image);		
		}
	}, false);
	
	var selectedDiv;
	
	var imageBox;
	
	rightSidebar.addEventListener('dragstart', function(e) {
		console.log('dragstart');
		
		selectedDiv = e.target;
		if (e.target.tagName === 'DIV') {
			var imageURL = selectedDiv.style['background-image'];
			var URLComponent = imageURL.slice(4, imageURL.length - 1);
			e.dataTransfer.setData('imageURL', imageURL);			
		}
		imageBox = e.target;
		e.dataTransfer.setData('initOffsetX', e.offsetX);
		e.dataTransfer.setData('initOffsetY', e.offsetY);
	}, false);
	
	content.addEventListener('dragstart', function(e) {
		console.log('dragstart');
		
		selectedDiv = e.target;
		if (e.target.tagName === 'DIV') {
			var imageURL = selectedDiv.style['background-image'];
			var URLComponent = imageURL.slice(4, imageURL.length - 1);
			e.dataTransfer.setData('imageURL', imageURL);			
		}
		imageBox = e.target;
		e.dataTransfer.setData('initOffsetX', e.offsetX);
		e.dataTransfer.setData('initOffsetY', e.offsetY);
	}, false);
	
	rightSidebar.addEventListener('dragend', function(e) {
		console.log('dragend');
	}, false);
	
	content.addEventListener('dragover', function(e) {
		console.log('dragover');
		e.preventDefault();
	}, false);
	
	content.addEventListener('drop', function(e) {
		var target = e.target;
		var imageURL = e.dataTransfer.getData('imageURL');
		
		if (target.className === 'content') {
			var left = e.offsetX - e.dataTransfer.getData('initOffsetX') + 'px';
			var top = e.offsetY - e.dataTransfer.getData('initOffsetY') + 'px';
			
			var imageInContentTemplate = _.template(document.getElementById('imageInContentTemplate').innerHTML);
			var image = imageInContentTemplate({
				backgroundURL: imageURL,
				/* width: 300 + 'px',
				height: 300 * ratio + 'px' */
				width: '180px',
				height: '180px',
				left: left,
				top: top
				});
			debugger;
			content.insertAdjacentHTML('beforeend', image);
		}
	}, false);
</script>
</html>