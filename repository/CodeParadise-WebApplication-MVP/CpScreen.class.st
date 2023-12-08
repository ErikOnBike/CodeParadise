"
I am a View representing the Screen of the web browser I live in. 
"
Class {
	#name : #CpScreen,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #'web resources' }
CpScreen class >> globalStyle [

	<webResource: #css>

	^ '*, *:before, *:after {
		box-sizing: border-box;
	}
	html {
		font-size: 100%;
		-webkit-text-size-adjust: 100%;
		font-family: "SF Pro Text", "Helvetica Neue", Helvetica, Arial, sans-serif;
	}
	body {
		overscroll-behavior-x: none; /* Prevent Chrome from navigating back on swipe */
	}'
]

{ #category : #'web resources' }
CpScreen class >> style [

	<webResource: #css>

	^':host {
		position: absolute;
		left: 0;
		top: 0;
		width: 100vw;
		height: 100vh;
		overflow: hidden;
	}
	#container {
		width: 100%;
		height: 100%;
	}
	/* Do not allow children to be selectable */
	*,
	::slotted(*) {
		-webkit-user-select: none;
		-moz-user-select: none;
		user-select: none;
	}'
]

{ #category : #'web resources' }
CpScreen class >> template [

	<webResource: #html>

	^ '<div id="container">
			<slot></slot>
		</div>'
]

{ #category : #sizing }
CpScreen >> height [

	^ self propertyAt: #clientHeight
]

{ #category : #sizing }
CpScreen >> width [

	^ self propertyAt: #clientWidth
]
