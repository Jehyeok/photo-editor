// image 업로드를 관리하는 객체
var ContentUploader = {
		rightSidebar: document.getElementById('rightSidebarWrapper'),
		fileInput: document.querySelector('#fileUploadDiv input[type="file"]'),
		reader: new FileReader(),
		onLoadingElement: null,
		curReadIdx: 0,
		
		upload: function() {
			var result;
			
			this.reader.onprogress = function(e) {
				this.onLoadingElement.innerText = e.loaded / e.total;
			}.bind(this);
			
			this.reader.onloadstart = function() {
				var imageInSidebarTemplate = _.template(document.getElementById('imageInSidebarTemplate').innerHTML);
				var image = imageInSidebarTemplate();
				this.rightSidebar.insertAdjacentHTML('afterbegin', image);
				this.onLoadingElement = this.rightSidebar.firstElementChild;
			}.bind(this);
			
			this.reader.onloadend = function() {
				this.rightSidebar.firstElementChild.style.backgroundImage = 'url(' + this.reader.result + ')';
				if (this.curReadIdx + 1 < this.fileInput.files.length) {
					this.curReadIdx++;
					this.reader.readAsDataURL(this.fileInput.files[this.curReadIdx]);
				}
			}.bind(this);
			
			
			this.reader.readAsDataURL(this.fileInput.files[this.curReadIdx]);
		},
		init: function() {
			this.fileInput.addEventListener('change',this.upload.bind(this), false);
		}
};

// 이미지 drag & drop 을 관리하는 객체
var ContentMover = {
		content: document.getElementById('content'),
		rightSidebar: document.getElementById('rightSidebarWrapper'),
		selectedImage: null,
		
		dragStart: function(e) {
			console.log('dragstart');

			this.selectedImage = e.target;
			if (e.target.tagName === 'DIV') {
				var imageURL = this.selectedImage.style['background-image'];
				var URLComponent = imageURL.slice(4, imageURL.length - 1);
				
				e.dataTransfer.setData('imageURL', imageURL);
				e.dataTransfer.setData('offsetXInImageBox', e.offsetX);
				e.dataTransfer.setData('offsetYInImageBox', e.offsetY);
				e.dataTransfer.setData('isMove', e.currentTarget.className === 'content');
			}
		},
		init: function() {
			this.rightSidebar.addEventListener('dragstart', this.dragStart.bind(this), false);
			this.content.addEventListener('dragstart', this.dragStart.bind(this), false);
			this.content.addEventListener('dragover', function(e) {
				e.preventDefault();
			}, false);

			this.content.addEventListener('drop', function(e) {
				console.log('drop');
				if (e.currentTarget.className === 'content') {
					var imageURL = e.dataTransfer.getData('imageURL');
					var isMove = ('true' === e.dataTransfer.getData('isMove'));
					
					var left = e.offsetX - e.dataTransfer.getData('offsetXInImageBox');
					var top = e.offsetY - e.dataTransfer.getData('offsetYInImageBox');
					
					if (isMove) {
						if (e.target.className !== 'content') {
							var preLeft = parseInt(this.selectedImage.style.left, 10);
							var preTop = parseInt(this.selectedImage.style.top, 10);
							left = preLeft + (e.offsetX - e.dataTransfer.getData('offsetXInImageBox'));
							top = preTop + (e.offsetY - e.dataTransfer.getData('offsetYInImageBox'));
						}
						this.selectedImage.style.left = left + 'px';
						this.selectedImage.style.top = top + 'px';
					} else{
						var imageInContentTemplate = _.template(document.getElementById('imageInContentTemplate').innerHTML);
						var image = imageInContentTemplate({
							backgroundURL : imageURL,
							width : '180px',
							height : '180px',
							left : left + 'px',
							top : top + 'px'
						});
						this.content.insertAdjacentHTML('beforeend', image);
					}
				}
			}.bind(this), false);
		}
};

ContentUploader.init();
ContentMover.init();