Class {
	#name : #CpPresentationApplicationView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Presentation-View'
}

{ #category : #'web resources' }
CpPresentationApplicationView class >> style [

	<webResource: #css>

	^ '* {
			box-sizing: border-box;
		}
		:host,
		.container {
			width: 100%;
			height: 100%;
			overflow: hidden;
		}'
]

{ #category : #'web resources' }
CpPresentationApplicationView class >> template [

	<webResource: #html>

	^ '<div class="container">
			<slot></slot>
		</div>'
]
