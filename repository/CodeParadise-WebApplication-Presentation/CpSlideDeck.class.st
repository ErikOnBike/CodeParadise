"
I represent a slide deck.
I have zero or more slides.

"
Class {
	#name : #CpSlideDeck,
	#superclass : #CpModel,
	#instVars : [
		'slides'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Model'
}

{ #category : #accessing }
CpSlideDeck >> addSlide: aSlide [

	self slides add: aSlide.

	self valueChanged.

	^ aSlide
]

{ #category : #accessing }
CpSlideDeck >> firstSlide [

	^ self slides
		ifNotEmpty: [ :allSlides | allSlides first ]
		ifEmpty: [ nil ]
]

{ #category : #'accessing - private' }
CpSlideDeck >> indexOfSlide: aSlide [

	"Answer the index of the specified slide or 0 if the slide is not part of the receiver"

	^ self slides indexOf: aSlide ifAbsent: [ 0 ]
]

{ #category : #initialization }
CpSlideDeck >> initialize [

	super initialize.

	slides := OrderedCollection new
]

{ #category : #accessing }
CpSlideDeck >> insertSlide: aSlide beforeSlide: anotherSlide [

	| index |
	
	(index := self indexOfSlide: anotherSlide) = 0
		ifTrue: [ self error: 'Unknown slide for relative positioning' ].
	self slides add: aSlide beforeIndex: index.

	self valueChanged.

	^ aSlide
]

{ #category : #accessing }
CpSlideDeck >> lastSlide [

	^ self slides
		ifNotEmpty: [ :allSlides | allSlides last ]
		ifEmpty: [ nil ]
]

{ #category : #accessing }
CpSlideDeck >> slideAfter: aSlide [

	|index |

	(index := self indexOfSlide: aSlide) = 0
		ifTrue: [ ^ nil ].
	^ self slides at: index + 1 ifAbsent: [ nil ]
]

{ #category : #accessing }
CpSlideDeck >> slideBefore: aSlide [

	|index |

	(index := self indexOfSlide: aSlide) < 1
		ifTrue: [ ^ nil ].
	^ self slides at: index - 1 ifAbsent: [ nil ]
]

{ #category : #accessing }
CpSlideDeck >> slides [

	^ slides
]
