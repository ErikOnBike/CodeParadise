Class {
	#name : #CynHelpScriptStep,
	#superclass : #Object,
	#instVars : [
		'name',
		'script',
		'root',
		'selector',
		'content',
		'maxElements',
		'maxHeight',
		'showable'
	],
	#category : #'CodeParadise-Canyon-App-Help'
}

{ #category : #accessing }
CynHelpScriptStep class >> defaultMaxElements [

	^ 3
]

{ #category : #'instance creation' }
CynHelpScriptStep class >> new [

	self errorNewReplacedBy: #root:
]

{ #category : #'instance creation' }
CynHelpScriptStep class >> root: rootElement [

	^ self basicNew
		initializeWithRoot: rootElement ;
		yourself
]

{ #category : #accessing }
CynHelpScriptStep >> allHighlightElements [

	"Answer all the elements which should be highlighted.

	Be aware: This might be more elements than the requested max elements."

	selector ifNil: [ ^ #() ].

	^ root allHighlightElementsMatching: selector
]

{ #category : #accessing }
CynHelpScriptStep >> alwaysShow [

	"Always show the step, independent of visible highlight elements.
	This can be useful in combination with dynamic content which will
	show an explanation about what could be visible."

	showable := [ true ]
]

{ #category : #accessing }
CynHelpScriptStep >> contentElement [

	^ content isBlock
		ifTrue: [ content cull: self ]
		ifFalse: [ content ]
]

{ #category : #accessing }
CynHelpScriptStep >> contentElement: anElementOrBlock [

	content := anElementOrBlock
]

{ #category : #testing }
CynHelpScriptStep >> hasShowableElements [

	^ self allHighlightElements
		anySatisfy: [ :each | root isVisibleElement: each ]
]

{ #category : #accessing }
CynHelpScriptStep >> highlightElementsDo: aBlock [

	"Evaluate the specified Block for the receiver's highlight elements.
	The evaluation is only performed on the max element count visible
	elements of the receiver. The other elements are ignored."

	| elements count |

	elements := self allHighlightElements.

	count := self maxElements.
	elements do: [ :each |
		(root isVisibleElement: each)
			ifTrue: [
				aBlock value: each.

				"One down, some more to go?"
				count := count - 1.
				count = 0
					ifTrue: [ ^ self ] ] ]
]

{ #category : #accessing }
CynHelpScriptStep >> html: aStringOrBlock [

	"Update the content"

	self contentElement: (aStringOrBlock isBlock
		ifTrue: [ [ self htmlToContent: (aStringOrBlock cull: self) ] ]
		ifFalse: [ self htmlToContent: aStringOrBlock ])
]

{ #category : #accessing }
CynHelpScriptStep >> htmlToContent: aString [

	^ (CpHtmlElement newWithTag: #div)
		markupContent: aString ;
		yourself
]

{ #category : #accessing }
CynHelpScriptStep >> id: aString [

	selector := '#', aString
]

{ #category : #initialization }
CynHelpScriptStep >> initializeWithRoot: anElement [

	self initialize.

	root := anElement
]

{ #category : #testing }
CynHelpScriptStep >> isShowable [

	"Answer whether the receiver can be shown.

	When a selector is provided, but does not resolve to any visible elements,
	the receiver can not be showed."

	showable ifNotNil: [
		^ showable cull: self ].

	^ selector isNil or: [ self hasShowableElements ]
]

{ #category : #accessing }
CynHelpScriptStep >> maxElements [

	^ maxElements ifNil: [ self class defaultMaxElements ]
]

{ #category : #accessing }
CynHelpScriptStep >> maxElements: anInteger [

	maxElements := anInteger
]

{ #category : #accessing }
CynHelpScriptStep >> maxHeight [

	^ maxHeight
]

{ #category : #accessing }
CynHelpScriptStep >> maxHeight: anInteger [

	maxHeight := anInteger
]

{ #category : #accessing }
CynHelpScriptStep >> name [

	^ name
]

{ #category : #accessing }
CynHelpScriptStep >> name: aString [

	name := aString
]

{ #category : #initialization }
CynHelpScriptStep >> release [

	script := nil.
	root := nil.
	content := nil.
	showable := nil.

	super release
]

{ #category : #accessing }
CynHelpScriptStep >> script [

	^ script
]

{ #category : #private }
CynHelpScriptStep >> script: aHelpScript [

	script := aHelpScript
]

{ #category : #accessing }
CynHelpScriptStep >> selector: aString [

	selector := aString
]

{ #category : #accessing }
CynHelpScriptStep >> showable: aBlock [

	"Set a Block which will be culled with the receiver to answer whether
	the receiver is showable. If the specified Block evaluates to true,
	the step will be shown. Otherwise it will not be shown."

	showable := aBlock
]

{ #category : #accessing }
CynHelpScriptStep >> text: aStringOrBlock [

	"Update the content"

	self contentElement: (aStringOrBlock isBlock
		ifTrue: [ [ self textToContent: (aStringOrBlock cull: self) ] ]
		ifFalse: [ self textToContent: aStringOrBlock ])
]

{ #category : #accessing }
CynHelpScriptStep >> textToContent: aString [

	^ (CpHtmlElement newWithTag: #p)
		textContent: aString ;
		yourself
]
