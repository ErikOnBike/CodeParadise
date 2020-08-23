Class {
	#name : #CpCustomContentView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Presentation-View'
}

{ #category : #'web resources' }
CpCustomContentView class >> style [

	<webResource: #css>

	^'.container {
		width: 100%;
		height: 100%;
	}'
]

{ #category : #'web resources' }
CpCustomContentView class >> template [

	<webResource: #html>

	^ '<div class="container">
			<slot></slot>
		</div>'
]

{ #category : #rendering }
CpCustomContentView >> render [

	"Render custom content"
]
