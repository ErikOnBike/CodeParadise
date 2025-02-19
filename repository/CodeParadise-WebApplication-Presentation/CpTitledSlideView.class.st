Class {
	#name : #CpTitledSlideView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Presentation-View'
}

{ #category : #'web resources' }
CpTitledSlideView class >> style [

	<webResource: #css>

	^ '* {
			box-sizing: border-box;
		}
		:host,
		#container {
			width: 100%;
			height: 100%;
			overflow: hidden;
		}
		#header {
			height: 1.6em;
			font-size: 4.5em;
			text-align: center;
			overflow: hidden;
			color: rgba(0, 105, 148, 1);
			border-bottom: .3em solid rgba(255, 255, 255, .9);
			background-color: rgba(255, 240, 201, .7);
		}
		#content {
			height: calc(100% - 1.6em);
			padding: 2.5% 2.5% 2.5% 2.5%;
			font-size: 2em;
			overflow: hidden;
			color: rgba(255, 255, 255, 1);
			background-color: rgba(0, 105, 148, .7);
		}'
]

{ #category : #'web resources' }
CpTitledSlideView class >> template [

	<webResource: #html>

	^ '<div id="container">
			<div id="header">
				<slot name="title"></slot>
			</div>
			<div id="content">
				<slot name="content"></slot>
			</div>
		</div>'
]

{ #category : #rendering }
CpTitledSlideView >> renderTitle: aString [

	self
		replaceAllChildrenWith: (aString inHtmlTag: #span)
		atSlotNamed: #title
]
