Class {
	#name : #CpHtmlContentView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Presentation-View'
}

{ #category : #'web resources' }
CpHtmlContentView class >> style [

	<webResource: #css>

	^ '* {
			box-sizing: border-box;
		}
		:host {
			display: inline-block;
		}'
]

{ #category : #'web resources' }
CpHtmlContentView class >> template [

	<webResource: #html>

	^ '<div id="container">
			<slot></slot>
		</div>'
]
