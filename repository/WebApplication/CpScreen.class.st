"
I am a View representing the Screen of the web browser I live in. 
"
Class {
	#name : #CpScreen,
	#superclass : #CpView,
	#category : #'WebApplication-Core'
}

{ #category : #'web resources' }
CpScreen class >> style [

	<webResource: #css>

	^':host {
		position: absolute;
		left: 0;
		top: 0;
		width: 100%;
		height: 100%;
		overflow: hidden;
		background-color: rgb(255, 255, 255);
	}'
]

{ #category : #'web resources' }
CpScreen class >> template [

	<webResource: #html>

	^ '<div class="root"><slot></slot></div>'
]
