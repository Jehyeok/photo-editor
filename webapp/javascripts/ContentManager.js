// image 업로드를 관리하는 객체
var ContentUploader = {
		rightSidebar: document.getElementById('rightSidebarWrapper'),
		fileInput: document.querySelector('#fileUploadDiv input[type="file"]'),
		reader: new FileReader(),
		
		upload: function() {
			var result;
			
			this.reader.readAsDataURL(this.fileInput.files[0]);
			this.reader.onloadend = function() {
				var imageInSidebarTemplate = _.template(document
						.getElementById('imageInSidebarTemplate').innerHTML);
				var image = imageInSidebarTemplate({
					backgroundURL : this.reader.result
				});
				this.rightSidebar.insertAdjacentHTML('afterbegin', image);
			}.bind(this);
		},
		init: function() {
			this.fileInput.addEventListener('change',this.upload.bind(this), false);
		}
};

// 이미지 drag & drop 을 관리하는 객체
var ContentMover = {
		content: document.getElementById('content'),
		rightSidebar: document.getElementById('rightSidebarWrapper'),
		
		init: function() {
			this.rightSidebar.addEventListener('dragstart', function(e) {
				console.log('dragstart');

				var selectedDiv = e.target;
				if (e.target.tagName === 'DIV') {
					var imageURL = selectedDiv.style['background-image'];
					var URLComponent = imageURL.slice(4, imageURL.length - 1);
					
					e.dataTransfer.setData('imageURL', imageURL);
					e.dataTransfer.setData('initOffsetX', e.offsetX);
					e.dataTransfer.setData('initOffsetY', e.offsetY);
				}
			}.bind(this), false);
			
			this.content.addEventListener('dragstart', function(e) {
				console.log('dragstart');
				
				var selectedDiv = e.target;
				if (e.target.tagName === 'DIV') {
					var imageURL = selectedDiv.style['background-image'];
					var URLComponent = imageURL.slice(4, imageURL.length - 1);
					
					e.dataTransfer.setData('imageURL', imageURL);
					e.dataTransfer.setData('initOffsetX', e.offsetX);
					e.dataTransfer.setData('initOffsetY', e.offsetY);
				}
			}.bind(this), false);

			this.content.addEventListener('dragover', function(e) {
				e.preventDefault();
			}, false);

			this.content.addEventListener('drop', function(e) {
				if (e.target.className === 'content') {
					var imageURL = e.dataTransfer.getData('imageURL');
					var left = e.offsetX - e.dataTransfer.getData('initOffsetX') + 'px';
					var top = e.offsetY - e.dataTransfer.getData('initOffsetY') + 'px';

					var imageInContentTemplate = _.template(document
							.getElementById('imageInContentTemplate').innerHTML);
					var image = imageInContentTemplate({
						backgroundURL : imageURL,
						width : '180px',
						height : '180px',
						left : left,
						top : top
					});
					this.insertAdjacentHTML('beforeend', image);
				}
			}, false);
		}
};

ContentUploader.init();
ContentMover.init();