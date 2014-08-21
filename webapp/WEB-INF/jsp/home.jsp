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
		</div>
		<div id="rightSidebarWrapper">
			<div id="fileUploadDiv">
				<input type="file" style="width: 100%; height: 100%;"></input>
			</div>
		</div>
	</div>
</body>
<script type="text/html" id="imageInSidebarTemplate">
<div class="imageBox" style="background-image:url(<\%= backgroundURL %>);">
</div>
</script>
<script type="text/html" id="imageInContentTemplate">
<div style="
			background-image:url(<\%= backgroundURL %>);
			background-size:cover;
			width: <\%= width %>;
			height: <\%= height %>;
			">
</div>	
</script>
<script src="/javascripts/underscore-min.js"></script>
<script>
	var contentWrapper = document.getElementById('contentWrapper');
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
	
	rightSidebar.addEventListener('click', function(e) {
		if (e.target.tagName === 'DIV') {
			var imageURL = e.target.style['background-image'];
			var URLComponent = imageURL.slice(4, imageURL.length - 1);
			var img = new Image();
			img.src = URLComponent;
			
			img.onload = function() {
				var ratio = this.height / this.width;
				var imageInContentTemplate = _.template(document.getElementById('imageInContentTemplate').innerHTML);
				var image = imageInContentTemplate({
					backgroundURL: URLComponent,
					width: 300 + 'px',
					height: 300 * ratio + 'px'
					});
				contentWrapper.insertAdjacentHTML('beforeend', image);
			};
		}
	}, false);
</script>
</html>