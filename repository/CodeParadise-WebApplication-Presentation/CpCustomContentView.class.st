Class {
	#name : #CpCustomContentView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Presentation-View'
}

{ #category : #'web resources' }
CpCustomContentView class >> style [

	<webResource: #css>

	^ '* {
			box-sizing: border-box;
		}
		:host,
		#container {
			width: 100%;
			height: 100%;
			overflow: hidden;
		}'
]

{ #category : #'web resources' }
CpCustomContentView class >> template [

	<webResource: #html>

	^ '<div id="container">
			<slot></slot>
		</div>'
]

{ #category : #rendering }
CpCustomContentView >> render [

	"Render custom content"
]
