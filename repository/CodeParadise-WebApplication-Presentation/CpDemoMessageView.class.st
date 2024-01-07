Class {
	#name : #CpDemoMessageView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Presentation-Examples'
}

{ #category : #'web resources' }
CpDemoMessageView class >> style [

	<webResource: #css>

	^ '* {
			box-sizing: border-box;
		}
		:host {
			position: relative;
			display: block;
			overflow: hidden;
			border-radius: 8px;
			height: 3em;
			color: white;
			background-color: rgba(0, 105, 148, .7);
			margin-right: 6px;
			margin-bottom: 6px;
		}
		#container {
			position: relative;
			top: 50%;
			transform: translateY(-50%);
			padding: 10px;
		}'
]

{ #category : #'web resources' }
CpDemoMessageView class >> template [

	<webResource: #html>

	^ '<div id="container">
			<slot></slot>
		</div>'
]

{ #category : #rendering }
CpDemoMessageView >> renderMessage: aString [

	self replaceAllChildrenWith: aString asHtmlElement.

	(CpTransition onBlock: [ :p | self styleAt: #'max-height' put: ((1 - p) * 3) printString, 'em' ])
		duration: 300 ;
		when: CpTransitionEnded send: #remove to: self ;
		startDelayedBy: 2400
]
