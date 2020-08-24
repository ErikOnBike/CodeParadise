Class {
	#name : #CpTextContentView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Presentation-View'
}

{ #category : #'web resources' }
CpTextContentView class >> style [

	<webResource: #css>

	^ '* {
			box-sizing: border-box;
		}
		:host {
			display: inline-block;
		}'
]

{ #category : #'web resources' }
CpTextContentView class >> template [

	<webResource: #html>

	^ '<div class="container">
			<slot></slot>
		</div>'
]
