<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
				<input type="file" multiple="multiple" style="width: 100%; height: 100%;"></input>
			</div>
		</div>
		<div id="layer"></div>
		<div id="imageModal">
		</div>
	</div>
</body>
<script type="text/html" id="imageInSidebarTemplate">
<div class="imageBox" draggable="true">
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
<script src="/javascripts/ContentManager.js"></script>
<script src="/javascripts/html2canvas.js"></script>
<script>
	/* var content = document.getElementById('content');
	html2canvas(content, {
		onrendered: function(canvas) {
			document.body.appendChild(canvas);
		}
	}); */
</script>
</html>