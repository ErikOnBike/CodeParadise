"
I represent a presentation.
I have a slide deck and keep track of the slides presented/shown (in my slide stack).

"
Class {
	#name : #CpPresentation,
	#superclass : #Model,
	#instVars : [
		'title',
		'slideDeck',
		'slideStack'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Model'
}

{ #category : #'instance creation' }
CpPresentation class >> titled: aString [

	^ self titled: aString usingSlideDeck: CpSlideDeck new
]

{ #category : #'instance creation' }
CpPresentation class >> titled: aString usingSlideDeck: aSlideDeck [

	^ self new
		title: aString ;
		slideDeck: aSlideDeck ;
		yourself
]

{ #category : #api }
CpPresentation >> currentSlide [

	"Answer the current Slide or nil if the receiver has no slides or is not started yet"

	^ self slideStack
		ifNotEmpty: [ :allSlides | allSlides last ]
		ifEmpty: [ nil ]
]

{ #category : #api }
CpPresentation >> goToSlide: aSlide [

	self slideStack add: aSlide.

	self valueChanged
]

{ #category : #initialization }
CpPresentation >> initialize [

	super initialize.

	slideStack := OrderedCollection new
]

{ #category : #api }
CpPresentation >> nextSlide [

	| nextSlide |

	(nextSlide := self slideDeck slideAfter: self currentSlide)
		ifNil: [ ^ self "self error: 'Cannot go to next slide of presentation while already at end'" ].

	self slideStack add: nextSlide.

	self valueChanged
]

{ #category : #api }
CpPresentation >> previousSlide [

	self slideStack size > 1
		ifFalse: [ ^ self ].

	self slideStack removeLast.

	self valueChanged
]

{ #category : #accessing }
CpPresentation >> slideDeck [

	^ slideDeck
]

{ #category : #accessing }
CpPresentation >> slideDeck: aSlideDeck [

	slideDeck := aSlideDeck.

	self valueChanged
]

{ #category : #accessing }
CpPresentation >> slideStack [

	^ slideStack
]

{ #category : #api }
CpPresentation >> start [

	"Start the receiver by making the first Slide of the SlideDeck the current
	(putting it on top of the Slide stack)."

	| firstSlide |

	(firstSlide := self slideDeck firstSlide)
		ifNil: [ self error: 'Cannot start a presentation without slides' ].

	self slideStack add: firstSlide.

	self valueChanged
]

{ #category : #accessing }
CpPresentation >> title [

	^ title
]

{ #category : #accessing }
CpPresentation >> title: aString [

	title := aString.

	self valueChanged
]