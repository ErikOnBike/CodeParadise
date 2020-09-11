Class {
	#name : #CpPresentationView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Presentation-View'
}

{ #category : #'web resources' }
CpPresentationView class >> style [

	<webResource: #css>

	^ '* {
			box-sizing: border-box;
		}
		:host,
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

	"Handle click event for presentation behavior.
	A click on the left 10% of the window width will move back.
	A click on the right 10% of the window width will move forward."

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

	"Handle key presses for relevant presentation behavior.
	
	Implementation:
	Wrap received key in '|' to make sure a full match is found."

	| key |

	key := '|', aKeyEvent key, '|'.
	('|ArrowLeft|Backspace|,|' includesSubstring: key)
		ifTrue: [ ^ self serverAnnounce: CpPreviousSlide ].
	('|ArrowRight| |.|' includesSubstring: key)
		ifTrue: [ ^ self serverAnnounce: CpNextSlide ].
	('|r|R|' includesSubstring: key)
		ifTrue: [ ^ self serverAnnounce: CpRefreshSlide ].
	('|i|I|g|G|' includesSubstring: key)
		ifTrue: [ ^ self serverAnnounce: CpSlideIndex ].
	('|Escape|' includesSubstring: key)
		ifTrue: [ ^ self serverAnnounce: CpRemoveSlideIndex ].

	super handleKeyPressEvent: aKeyEvent
]

{ #category : #initialization }
CpPresentationView >> initialize [

	super initialize.

	"Set styling of the page"
	CpHtmlElement documentHead appendChild: ((CpHtmlElement newWithTag: #style)
		textContent: '
			body {
				margin: 0;
				padding: 0 ;
				width: 100vw;
				height: 100vh;
				overflow: hidden;
				font-family: "SF Pro Text", "Helvetica Neue", Helvetica, Arial, sans-serif;

			}' ;
		yourself).

	"Add a cursor so we retrieve key events, but put it outside the visible area"
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

	^ CpHtmlElement documentBody propertyAt: #clientWidth
]
