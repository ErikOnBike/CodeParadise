"
I represent a presentation.
I have a slide deck and optionally keep track of the slides presented/shown (in my slide stack).
If the slide stack is not used, previous and next slide, simply move forward/backward in the
slideDeck (wrapping around at both ends).

If the slide stack is used, the following holds:
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
		'slideStack',
		'useStack'
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

{ #category : #accessing }
CpPresentation >> beDeckBased [

	useStack := false.

	"Remove any slides on the Stack (and keep only the current slide)"
	slideStack := OrderedCollection with: self currentSlide
]

{ #category : #accessing }
CpPresentation >> beStackBased [

	useStack := true
]

{ #category : #api }
CpPresentation >> currentSlide [

	"Answer the current Slide or nil if the receiver has no slides"

	^ self slideStack
		ifNotEmpty: [ :allSlides | allSlides last ]
		ifEmpty: [ self slideDeck firstSlide ]
]

{ #category : #api }
CpPresentation >> goToSlide: aSlide [

	"Make the specified slide the current slide"

	(self slideDeck indexOfSlide: aSlide) = 0
		ifTrue: [ ^ self error: 'The specified slide is not part of the receiver''s slide deck' ].

	"Only keep track of current slide if the stack is not used"
	useStack
		ifFalse: [ self slideStack removeAll ].
	self slideStack add: aSlide.

	self valueChanged
]

{ #category : #initialization }
CpPresentation >> initialize [

	super initialize.

	slideStack := OrderedCollection new.
	useStack := true
]

{ #category : #api }
CpPresentation >> nextSlide [

	"Go to the next slide (based on the slides in the slideDeck)"

	| nextSlide |

	(nextSlide := self slideDeck slideAfter: self currentSlide)
		ifNil: [
			useStack ifTrue: [ ^ self ].
			nextSlide := self slideDeck firstSlide ].

	useStack
		ifTrue: [ self slideStack add: nextSlide ]
		ifFalse: [ self goToSlide: nextSlide ].

	self valueChanged
]

{ #category : #api }
CpPresentation >> previousSlide [

	"Go to the previously shown slide.

	Implementation (for stack based presentation):
	The previous slide is based on the slideStack.
	This might be different than the slide order in the slideDeck.
	See also the class comment."

	useStack
		ifTrue: [
			self slideStack size > 1
				ifFalse: [ ^ self ].

			self slideStack removeLast ]
		ifFalse: [
			| previousSlide |
			
			(previousSlide := self slideDeck slideBefore: self currentSlide)
				ifNil: [
					previousSlide := self slideDeck lastSlide ].
			self goToSlide: previousSlide ].

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

{ #category : #accessing }
CpPresentation >> useStack [

	^ useStack
]
