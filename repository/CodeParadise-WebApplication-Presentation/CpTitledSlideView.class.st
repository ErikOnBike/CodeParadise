Class {
	#name : #CpTitledSlideView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Presentation-View'
}

{ #category : #'web resources' }
CpTitledSlideView class >> style [

	<webResource: #css>

	^'.container {
		width: 100%;
		height: 100%;
	}
	.header {
		width: 100%;
		height: 15%;
		font-size: 12vh;
		text-align: center;
		vertical-align: middle;
		background-color: rgba(255, 0, 0, .1);
		overflow: hidden;
	}
	.content {
		width: 100%;
		height: calc(100% - 15%);
		background-color: rgba(0, 0, 255, .1);
		overflow: hidden;
	}'
]

{ #category : #'web resources' }
CpTitledSlideView class >> template [

	<webResource: #html>

	^ '<div class="container">
			<div class="header">
				<slot name="title"></slot>
			</div>
			<div class="content">
				<slot name="content"></slot>
			</div>
		</div>'
]

{ #category : #rendering }
CpTitledSlideView >> renderTitle: aString [

	self
		replaceChild: (aString inHtmlTag: #span)
		atSlotNamed: #title
]
