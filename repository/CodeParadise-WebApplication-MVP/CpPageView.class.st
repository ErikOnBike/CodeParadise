Class {
	#name : #CpPageView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #'web resources' }
CpPageView class >> style [

	<webResource: #css>

	^'#container {
		width: 100%;
		height: 100%;
		overflow: auto;
	}'
]

{ #category : #'web resources' }
CpPageView class >> template [

	<webResource: #html>

	^ '<div id="container">
			<slot></slot>
		</div>'
]
