Class {
	#name : #CpFullPageSlideView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Presentation-View'
}

{ #category : #'web resources' }
CpFullPageSlideView class >> style [

	<webResource: #css>

	^ '* {
			box-sizing: border-box;
		}
		:host,
		#container {
			width: 100%;
			height: 100%;
		}'
]

{ #category : #'web resources' }
CpFullPageSlideView class >> template [

	<webResource: #html>

	^ '<div id="container">
			<slot name="content"></slot>
		</div>'
]
