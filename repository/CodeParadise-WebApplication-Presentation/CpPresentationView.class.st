Class {
	#name : #CpPresentationView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Presentation-View'
}

{ #category : #'web resources' }
CpPresentationView class >> globalStyle [

	<webResource: #css>

	^ 'body {
		margin: 0;
		padding: 0 ;
		width: 100vw;
		height: 100vh;
		overflow: hidden;
		font-family: "SF Pro Text", "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: .9vw;
	}'
]

{ #category : #'web resources' }
CpPresentationView class >> style [

	<webResource: #css>

	^ '* {
			box-sizing: border-box;
		}
		:host,
		#container {
			width: 100%;
			height: 100%;
			overflow: hidden;
		}'
]

{ #category : #'web resources' }
CpPresentationView class >> template [

	<webResource: #html>

	^ '<div id="container">
			<slot name="slide"></slot>
			<slot name="carousel"></slot>
		</div>'
]

{ #category : #'event handling' }
CpPresentationView >> handleClickEvent: aClickEvent [

	"Handle click event for presentation behavior.
	A click on the left 10% of the window width will move back.
	A click on the right 10% of the window width will move forward."

	| pointX clickWidth |

	pointX := aClickEvent point x.
	clickWidth := self width / 10.
	pointX < clickWidth
		ifTrue: [ self serverAnnounce: CpPreviousSlide ]
		ifFalse: [
			pointX > (self width - clickWidth)
				ifTrue: [ self serverAnnounce: CpNextSlide ] ]
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
		ifTrue: [ ^ self serverAnnounce: CpRemoveSlideIndex ]
]

{ #category : #initialization }
CpPresentationView >> initialize [

	super initialize.

	"Add a key event handler on the body (where all key events will end up at the moment).
	The KeyUpEvent is used, since it will prevent repeating keys and also supports
	arrow keys (which do not generate a KeyPress event)."
	CpHtmlElement documentBody
		when: CpPrimaryClickEvent only send: #handleClickEvent: to: self ;
		when: CpKeyUpEvent arrowLeft only send: #showPreviousSlide to: self ;
		when: CpKeyUpEvent arrowRight only send: #showNextSlide to: self ;
		when: (CpKeyUpEvent key: 'i') only send: #toggleSlideIndex to: self ;
		when: (CpKeyUpEvent escape) only send: #removeSlideIndex to: self ;
		when: (CpKeyUpEvent key: 'r') only send: #refreshSlide to: self
]

{ #category : #actions }
CpPresentationView >> refreshSlide [

	self serverAnnounce: CpRefreshSlide
]

{ #category : #actions }
CpPresentationView >> removeSlideIndex [

	self serverAnnounce: CpRemoveSlideIndex
]

{ #category : #rendering }
CpPresentationView >> renderTitle: aString [

	| headElement |

	((headElement := CpHtmlElement documentHead) firstDescendantMatching: #title)
		ifNotNil: [ :titleElement | titleElement textContent: aString ]
		ifNil: [ headElement appendChild: (aString inHtmlTag: #title) ]
]

{ #category : #actions }
CpPresentationView >> showNextSlide [

	self serverAnnounce: CpNextSlide
]

{ #category : #actions }
CpPresentationView >> showPreviousSlide [

	self serverAnnounce: CpPreviousSlide
]

{ #category : #actions }
CpPresentationView >> toggleSlideIndex [

	self serverAnnounce: CpSlideIndex
]

{ #category : #accessing }
CpPresentationView >> width [ 

	^ CpHtmlElement documentBody propertyAt: #clientWidth
]
