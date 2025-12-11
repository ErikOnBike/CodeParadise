Class {
	#name : #CynFloatingHelpView,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'helpScript',
		'highlights',
		'position',
		'transition'
	],
	#category : #'CodeParadise-Canyon-App-View'
}

{ #category : #'class initialization' }
CynFloatingHelpView class >> beLoaded [

	CpTransition beLoaded
]

{ #category : #'web resources' }
CynFloatingHelpView class >> style [

	<webResource: #css>

	^ '*, *:before, *:after {
	box-sizing: border-box;
}
:host {
	display: block;
	position: absolute;
	top: 0;
	bottom: 0;
	left: 0;
	right: 0;
	z-index: 1001;
	opacity: 0;
	transition: opacity .5s ease;
}
:host(.show) {
	opacity: 1;
}
#container {
	position: relative;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}
#layer {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}
#content {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}
#controls {
	display: flex;
	justify-content: flex-start;
	align-items: center;
}'
]

{ #category : #'web resources' }
CynFloatingHelpView class >> template [

	<webResource: #html>

	^ '<div id="container">
	<svg id="layer" preserveAspectRatio="none" viewBox="0 0 100 100">
		<defs>
			<mask id="holeMask">
				<rect width="100" height="100" fill="white"></rect>
				<g id="highlights" fill="black">
				</g>
			</mask>
		</defs>
		<rect width="100" height="100" fill="rgba(42, 42, 42, .7)" mask="url(#holeMask)"></rect>
	</svg>
	<div id="content" part="content">
		<div id="text" part="text"><slot></slot></div>
		<div id="controls" part="controls">
			<div id="previous-step" part="previous-step"><slot name="previous-step"></slot></div>
			<div id="next-step" part="next-step"><slot name="next-step"></slot></div>
			<div id="close-help" part="close-help"><slot name="close-help"></slot></div>
		</div>
	</div>
</div>'
]

{ #category : #view }
CynFloatingHelpView >> close [

	self removeClass: #show.

	CpGlobalThis setTimeout: 600 thenDo: [ self destroy ]
]

{ #category : #accessing }
CynFloatingHelpView >> closeControl [

	^ self firstChildAtSlotNamed: #'close-help'
]

{ #category : #accessing }
CynFloatingHelpView >> closeElement [

	^ self shadowedElementWithId: #'close-help'
]

{ #category : #'event handling' }
CynFloatingHelpView >> handleClose [

	self close
]

{ #category : #'event handling' }
CynFloatingHelpView >> handleNextStep [

	helpScript ifNotNil: [ helpScript nextStep ].

	self updateView
]

{ #category : #'event handling' }
CynFloatingHelpView >> handlePreviousStep [

	helpScript ifNotNil: [ helpScript previousStep ].

	self updateView
]

{ #category : #testing }
CynFloatingHelpView >> hasNextStep [

	^ helpScript
		ifNotNil: [ helpScript hasNextStep ]
		ifNil: [ false ]
]

{ #category : #testing }
CynFloatingHelpView >> hasPreviousStep [

	^ helpScript
		ifNotNil: [ helpScript hasPreviousStep ]
		ifNil: [ false ]
]

{ #category : #accessing }
CynFloatingHelpView >> helpScript: aHelpScript [

	helpScript := aHelpScript.

	self updateView
]

{ #category : #view }
CynFloatingHelpView >> highlightElements: aStep [

	| boundingRect index |

	boundingRect := self boundingClientRectangle.

	(self shadowedElementWithId: #highlights)
		attributeAt: #transform put: (String streamContents: [ :stream |
			stream
				nextPutAll: 'scale(' ;
				print: (100 / boundingRect width) ;
				nextPut: $, ;
				print: (100 / boundingRect height) ;
				nextPut: $) ]).

	index := 1.
	aStep highlightElementsDo: [ :each |
		| eachBoundingRect highlight |
		eachBoundingRect := each boundingClientRectangle.

		"Create new or use existing highlight element"
		highlights size < index
			ifTrue: [
				"Create new highlight element and add to collection"
				highlight := CynHelpHighlight at: position.
				(self shadowedElementWithId: #highlights)
					appendChild: highlight element.
				highlights add: highlight ]
			ifFalse: [ highlight := highlights at: index ].

		"Set new 'destination' position and size"
		highlight
			toPos: (eachBoundingRect centerPoint - boundingRect position)
			size: (self normalizedSize: eachBoundingRect).

		index := index + 1 ].

	"Release the remaining elements (do not do a transition here, because it distracts)"
	self releaseHighlightsFrom: index.

	self startTransition
]

{ #category : #initialization }
CynFloatingHelpView >> initialize [

	super initialize.

	highlights := OrderedCollection new
]

{ #category : #initialization }
CynFloatingHelpView >> initializeShadowRoot [

	super initializeShadowRoot.

	"This is not using Ionic elements, so no #deferSend: needed"
	self when: CpClickEvent send: #keepPosition: to: self.

	self previousStepElement
		when: CpClickEvent deferSend: #handlePreviousStep to: self.
	self nextStepElement
		when: CpClickEvent deferSend: #handleNextStep to: self.
	self closeElement
		when: CpClickEvent deferSend: #handleClose to: self.

	self updateView
]

{ #category : #testing }
CynFloatingHelpView >> isShowing [

	^ self isClassed: #show
]

{ #category : #'event handling' }
CynFloatingHelpView >> keepPosition: anEvent [

	| boundingRect |

	boundingRect := self boundingClientRectangle.

	position := anEvent point - (boundingRect left @ boundingRect top)
]

{ #category : #accessing }
CynFloatingHelpView >> nextStepControl [

	^ self firstChildAtSlotNamed: #'next-step'
]

{ #category : #accessing }
CynFloatingHelpView >> nextStepElement [

	^ self shadowedElementWithId: #'next-step'
]

{ #category : #view }
CynFloatingHelpView >> normalizedSize: eachBoundingRect [

	| size side ratio |

	size := eachBoundingRect size max: 24 @ 24.

	"Make square shape if almost square"
	side := size x max: size y.
	ratio := size x / size y.
	((side < 60 and: [ ratio between: 0.6 and: 1.4 ]) or: [ ratio between: 0.8 and: 1.2 ])
		ifTrue: [ size := side @ side ].

	^ size
]

{ #category : #view }
CynFloatingHelpView >> open [

	CpGlobalThis defer: [ self addClass: #show ]
]

{ #category : #accessing }
CynFloatingHelpView >> previousStepControl [

	^ self firstChildAtSlotNamed: #'previous-step'
]

{ #category : #accessing }
CynFloatingHelpView >> previousStepElement [

	^ self shadowedElementWithId: #'previous-step'
]

{ #category : #initialization }
CynFloatingHelpView >> release [

	self releaseHighlights.

	super release
]

{ #category : #initialization }
CynFloatingHelpView >> releaseHighlights [

	"Remove the highlights and release any dependencies"

	highlights ifNil: [ ^ self ].

	self releaseHighlightsFrom: 1.

	highlights := nil
]

{ #category : #initialization }
CynFloatingHelpView >> releaseHighlightsFrom: anInteger [

	"Remove the highlights and release any dependencies"

	highlights ifNil: [ ^ self ].

	[ anInteger <= highlights size ] whileTrue: [
		highlights removeLast ifNotNil: [ :highlight |
			highlight element destroy.
			highlight release ] ]
]

{ #category : #view }
CynFloatingHelpView >> showCurrentStep [

	| currentStep |

	helpScript ifNotNil: [ currentStep := helpScript currentStep ].

	currentStep
		ifNotNil: [
			self replaceAllChildrenWith: currentStep contentElement atSlotNamed: nil.
			self highlightElements: currentStep ]
		ifNil: [
			self removeChildrenAtSlotNamed: nil.
			self releaseHighlights ]
]

{ #category : #view }
CynFloatingHelpView >> startTransition [

	| ease |

	transition := CpTransition onBlock: [ :p |
		ease := CpTransition easeInOutCubic: p.

		highlights do: [ :each | each updateTo: ease ] ].

	transition
		when: CpTransitionEnded send: #transitionEnded to: self ;
		duration: 600 ;
		start
]

{ #category : #view }
CynFloatingHelpView >> transitionEnded [

	highlights do: [ :each | each updateFinal ]
]

{ #category : #view }
CynFloatingHelpView >> updateView [

	self previousStepControl ifNotNil: [ :control |
		control disabled: self hasPreviousStep not ].
	self nextStepControl ifNotNil: [ :control |
		control disabled: self hasNextStep not ].

	self showCurrentStep
]
