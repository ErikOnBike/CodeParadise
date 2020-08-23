Class {
	#name : #CpPresentationView,
	#superclass : #CpView,
	#instVars : [
		'width'
	],
	#category : #'CodeParadise-WebApplication-Presentation-View'
}

{ #category : #'web resources' }
CpPresentationView class >> style [

	<webResource: #css>

	^':host {
		width: 100%;
		height: 100%;
	}
	.container {
		width: 100%;
		height: 100%;
		overflow: hidden;
	}'
]

{ #category : #'web resources' }
CpPresentationView class >> template [

	<webResource: #html>

	^ '<div class="container">
			<slot></slot>
		</div>'
]

{ #category : #'event handling' }
CpPresentationView >> handleClickEvent: aClickEvent [

	| pointX clickWidth |

	pointX := aClickEvent clickPoint x.
	clickWidth := self width / 10.
	pointX < clickWidth
		ifTrue: [ self serverAnnounce: CpPreviousSlide ]
		ifFalse: [
			pointX > (self width - clickWidth)
				ifTrue: [ self serverAnnounce: CpNextSlide ]
				ifFalse: [ super handleClickEvent: aClickEvent ] ]
]

{ #category : #'event handling' }
CpPresentationView >> handleKeyPressEvent: aKeyEvent [

	aKeyEvent key = ','
		ifTrue: [ self serverAnnounce: CpPreviousSlide ]
		ifFalse: [
			aKeyEvent key = '.'
				ifTrue: [ self serverAnnounce: CpNextSlide ]
				ifFalse: [ super handleKeyPressEvent: aKeyEvent ] ]
]

{ #category : #initialization }
CpPresentationView >> initialize [

	super initialize.

	self appendChild: (CpCursor new
		styleAt: #position put: 'absolute' ;
		styleAt: #top put: '-2rem' ;
		yourself)
]

{ #category : #rendering }
CpPresentationView >> renderTitle: aString [

	| headElement |

	((headElement := CpHtmlElement documentHead) firstDescendantMatching: #title)
		ifNotNil: [ :titleElement | titleElement textContent: aString ]
		ifNil: [ headElement appendChild: (aString inHtmlTag: #title) ]
]

{ #category : #accessing }
CpPresentationView >> width [ 

	^ width ifNil: [ width := CpHtmlElement documentBody propertyAt: #clientWidth ]
]
