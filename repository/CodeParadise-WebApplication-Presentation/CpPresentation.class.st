"
I represent a presentation.
I have a slide deck and keep track of the slides presented/shown (in my slide stack).
When I perform #nextSlide I make the slide following the #currentSlide in the slides
of my slideDeck the new current slide. When I perform #previousSlide I make the slide
current which was previously the #currentSlide. (Implementation) So for #nextSlide I
use my slideDeck and for #previousSlide I use my slideStack.

"
Class {
	#name : #CpPresentation,
	#superclass : #CpModel,
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
CpPresentation >> addSlide: aSlide [

	^ self slideDeck addSlide: aSlide
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

	"Make the specified slide the current slide"

	(self slideDeck indexOfSlide: aSlide) = 0
		ifTrue: [ ^ self error: 'The specified slide is not part of the receiver''s slide deck' ].

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

	"Go to the next slide (based on the slides in the slideDeck)"

	| nextSlide |

	(nextSlide := self slideDeck slideAfter: self currentSlide)
		ifNil: [ ^ self "self error: 'Cannot go to next slide of presentation while already at end'" ].

	self slideStack add: nextSlide.

	self valueChanged
]

{ #category : #presenter }
CpPresentation >> preferredPresenterClass [

	^ CpPresentationPresenter
]

{ #category : #api }
CpPresentation >> previousSlide [

	"Go to the previously shown slide.

	Implementation:
	The previous slide is based on the slideStack.
	This might be different than the slide order in the slideDeck.
	See also the class comment."

	self slideStack size > 1
		ifFalse: [ ^ self ].

	self slideStack removeLast.

	self valueChanged
]

{ #category : #presenter }
CpPresentation >> rootPresenterClass [

	"The receiver's root Presenter class equals the preferred Presenter class"

	^ self preferredPresenterClass
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
