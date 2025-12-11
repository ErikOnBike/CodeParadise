Class {
	#name : #CynSpotlightHelpView,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'helpScript',
		'highlights',
		'position',
		'transition'
	],
	#category : #'CodeParadise-Canyon-App-Help'
}

{ #category : #'class initialization' }
CynSpotlightHelpView class >> beLoaded [

	CpTransition beLoaded
]

{ #category : #'web resources' }
CynSpotlightHelpView class >> style [

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
	justify-content: center;
	align-items: center;
}'
]

{ #category : #'web resources' }
CynSpotlightHelpView class >> template [

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
		<div id="content-wrapper">
			<div id="text" part="text"><slot></slot></div>
			<div id="controls" part="controls">
				<div id="previous-step" part="previous-step"><slot name="previous-step"></slot></div>
				<div id="next-step" part="next-step"><slot name="next-step"></slot></div>
				<div id="close-help" part="close-help"><slot name="close-help"></slot></div>
			</div>
		</div>
	</div>
</div>'
]

{ #category : #view }
CynSpotlightHelpView >> close [

	self removeClass: #show.

	"Announce close, before destroy otherwise the announcer is gone"
	self announce: CynHelpViewClosed.

	CpGlobalThis setTimeout: 600 thenDo: [ self destroy ]
]

{ #category : #accessing }
CynSpotlightHelpView >> closeControl [

	^ self firstChildAtSlotNamed: #'close-help'
]

{ #category : #accessing }
CynSpotlightHelpView >> closeElement [

	^ self shadowedElementWithId: #'close-help'
]

{ #category : #accessing }
CynSpotlightHelpView >> contentWrapper [

	^ self shadowedElementWithId: #'content-wrapper'
]

{ #category : #'event handling' }
CynSpotlightHelpView >> handleClose [

	self close
]

{ #category : #'event handling' }
CynSpotlightHelpView >> handleNextStep [

	helpScript ifNotNil: [ helpScript nextStep ].

	self updateView
]

{ #category : #'event handling' }
CynSpotlightHelpView >> handlePreviousStep [

	helpScript ifNotNil: [ helpScript previousStep ].

	self updateView
]

{ #category : #testing }
CynSpotlightHelpView >> hasNextStep [

	^ helpScript
		ifNotNil: [ helpScript hasNextStep ]
		ifNil: [ false ]
]

{ #category : #testing }
CynSpotlightHelpView >> hasPreviousStep [

	^ helpScript
		ifNotNil: [ helpScript hasPreviousStep ]
		ifNil: [ false ]
]

{ #category : #accessing }
CynSpotlightHelpView >> helpScript: aHelpScript [

	helpScript := aHelpScript.

	self updateView
]

{ #category : #view }
CynSpotlightHelpView >> highlightElements: aStep [

	| page content boundingRect minY maxY index |

	page := self canyonPage.
	content := page ifNotNil: [ page content ].

	boundingRect := self boundingClientRectangle.

	(self shadowedElementWithId: #highlights)
		attributeAt: #transform put: (String streamContents: [ :stream |
			stream
				nextPutAll: 'scale(' ;
				print: (100 / boundingRect width) ;
				nextPut: $, ;
				print: (100 / boundingRect height) ;
				nextPut: $) ]).

	minY := boundingRect height.
	maxY := 0.
	index := 1.
	aStep highlightElementsDo: [ :each |
		| eachBoundingRect highlight |
		eachBoundingRect := each boundingClientRectangle.

		"Perform size calculations on scrollable content (find bounds of Y)"
		(content isNotNil and: [ each isDescendantOf: content ])
			ifTrue: [
				minY := eachBoundingRect top min: minY.
				maxY := eachBoundingRect bottom max: maxY ].

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

	"Scroll into position and update highlights accordingly"
	content ifNotNil: [
		| toolbarHeight helpHeight scrollTop scrollY |

		"Check if toolbar is hiding content"
		scrollY := 0.
		toolbarHeight := page toolbar
			ifNotNil: [ :toolbar | toolbar boundingClientRectangle height ]
			ifNil: [ 44 ].	"default minimum for iOS"
		scrollTop := [ (content getScrollElement await propertyAt: #scrollTop) ifNil: [ 0 ] ] on: Error do: [ :error | self errorCr: 'Failed to read scrollTop: ', error printString. 0 ].
		(scrollTop > 0 and: [ minY < toolbarHeight ])
			ifTrue: [ scrollY := minY - toolbarHeight ].

		"Check if help content is hiding content (should normally not conflict with toolbar)"
		helpHeight := self contentWrapper boundingClientRectangle height + 16. "Add margin of content"
		(scrollY >= 0 and: [ maxY + helpHeight > boundingRect height ])
			ifTrue: [ scrollY := scrollY max: maxY + helpHeight - boundingRect height ].

		"Perform scroll"
		scrollY = 0
			ifFalse: [

				"Scroll content into view"
				content scrollToPoint: 0 y: scrollTop + scrollY duration: 600.

				"Compensate position of highlights"
				highlights do: [ :each | each scrollY: scrollY negated ] ] ].

	self startTransition
]

{ #category : #initialization }
CynSpotlightHelpView >> initialize [

	super initialize.

	highlights := OrderedCollection new
]

{ #category : #initialization }
CynSpotlightHelpView >> initializeShadowRoot [

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
CynSpotlightHelpView >> isShowing [

	^ self isClassed: #show
]

{ #category : #'event handling' }
CynSpotlightHelpView >> keepPosition: anEvent [

	| boundingRect |

	boundingRect := self boundingClientRectangle.

	position := anEvent point - (boundingRect left @ boundingRect top)
]

{ #category : #accessing }
CynSpotlightHelpView >> nextStepControl [

	^ self firstChildAtSlotNamed: #'next-step'
]

{ #category : #accessing }
CynSpotlightHelpView >> nextStepElement [

	^ self shadowedElementWithId: #'next-step'
]

{ #category : #view }
CynSpotlightHelpView >> normalizedSize: eachBoundingRect [

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
CynSpotlightHelpView >> open [

	CpGlobalThis defer: [ self addClass: #show ]
]

{ #category : #accessing }
CynSpotlightHelpView >> previousStepControl [

	^ self firstChildAtSlotNamed: #'previous-step'
]

{ #category : #accessing }
CynSpotlightHelpView >> previousStepElement [

	^ self shadowedElementWithId: #'previous-step'
]

{ #category : #initialization }
CynSpotlightHelpView >> release [

	self releaseHighlights.

	super release
]

{ #category : #initialization }
CynSpotlightHelpView >> releaseHighlights [

	"Remove the highlights and release any dependencies"

	highlights ifNil: [ ^ self ].

	self releaseHighlightsFrom: 1.

	highlights := nil
]

{ #category : #initialization }
CynSpotlightHelpView >> releaseHighlightsFrom: anInteger [

	"Remove the highlights and release any dependencies"

	highlights ifNil: [ ^ self ].

	[ anInteger <= highlights size ] whileTrue: [
		highlights removeLast ifNotNil: [ :highlight |
			highlight element destroy.
			highlight release ] ]
]

{ #category : #view }
CynSpotlightHelpView >> showCurrentStep [

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
CynSpotlightHelpView >> startTransition [

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
CynSpotlightHelpView >> transitionEnded [

	highlights do: [ :each | each updateFinal ]
]

{ #category : #view }
CynSpotlightHelpView >> updateView [

	self previousStepControl ifNotNil: [ :control |
		control disabled: self hasPreviousStep not ].
	self nextStepControl ifNotNil: [ :control |
		control disabled: self hasNextStep not ].

	self showCurrentStep
]
