Class {
	#name : #CpMultiContentView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Presentation-View'
}

{ #category : #'web resources' }
CpMultiContentView class >> style [

	<webResource: #css>

	^ '* {
			box-sizing: border-box;
		}
		:host {
			width: 100%;
		}
		::slotted(*) {
			display: block;
		}'
]

{ #category : #'web resources' }
CpMultiContentView class >> template [

	<webResource: #html>

	^ '<div id="container">
			<slot></slot>
		</div>'
]
