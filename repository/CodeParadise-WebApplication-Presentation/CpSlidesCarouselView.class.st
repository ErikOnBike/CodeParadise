Class {
	#name : #CpSlidesCarouselView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Presentation-View'
}

{ #category : #'web resources' }
CpSlidesCarouselView class >> style [

	<webResource: #css>

	"Code based on https://3dtransforms.desandro.com/carousel"

	^ '* {
			box-sizing: border-box;
		}
		:host {
			display: none;
			position: absolute;
			left: 0;
			top: 0;
		}
		:host(.show) {
			display: block;
		}
		:host,
		#container {
			width: 100%;
			height: 100%;
			overflow: hidden;
		}
		#scene {
			position: relative;
			width: 1050px;
			height: 700px;
			margin: 80px auto;
		}'
]

{ #category : #'web resources' }
CpSlidesCarouselView class >> template [

	<webResource: #html>

	"Code based on https://3dtransforms.desandro.com/carousel"

	^ '<div id="container">
			<div id="scene">
				<slot></slot>
			</div>
		</div>'
]

{ #category : #rendering }
CpSlidesCarouselView >> centerAround: anInteger [

	"Put the carousel in the correct 'orientation'.
	Code is based on https://3dtransforms.desandro.com/carousel"

	| wrapper slides theta radius angle |

	wrapper := self firstDescendantMatching: '.wrapper'.
	slides := wrapper children.
	theta := 360 / slides size.
	radius := (525 / ((Float pi / slides size) tan)) rounded.
	angle := theta * anInteger * -1.
	wrapper styleAt: #transform put: (String streamContents: [ :stream |
			stream nextPutAll: 'perspective(2000px)translateZ('.
			radius negated printOn: stream.
			stream nextPutAll: 'px) rotateY('.
			angle printOn: stream.
			stream nextPutAll: 'deg)' ])
]

{ #category : #rendering }
CpSlidesCarouselView >> renderSlidesCenteredAround: anInteger [

	"Put the slides in the correct 'position'.
	Code is based on https://3dtransforms.desandro.com/carousel"

	| wrapper slides theta radius |

	"Move all children into wrapper"
	wrapper := self firstDescendantMatching: '.wrapper'.
	wrapper ifNil: [
		wrapper := self appendChild: ((CpHtmlElement newWithTag: #div)
			addClass: #wrapper ;
			styleAt: #width put: '100%' ;
			styleAt: #height put: '100%' ;
			styleAt: #position put: 'absolute' ;
			styleAt: #transform put: 'perspective(2000px)translateZ(-1442px)' ;
			styleAt: #'transform-style' put: 'preserve-3d' ;
			styleAt: #transition put: 'transform 1s' ;
			yourself).
		self children do: [ :each |
			each = wrapper
				ifFalse: [ wrapper appendChild: each ] ] ].

	slides := wrapper children.
	theta := 360 / slides size.
	radius := (525 / ((Float pi / slides size) tan)) rounded.
	slides withIndexDo: [ :each :index |
		each styleAt: #transform put: (String streamContents: [ :stream |
			stream nextPutAll: 'rotateY('.
			(theta * index) printOn: stream.
			stream nextPutAll: 'deg) translateZ('.
			radius printOn: stream.
			stream nextPutAll: 'px)' ]) ].

	self centerAround: anInteger.

	self addClass: #show
]
