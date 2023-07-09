Class {
	#name : #CpContextView,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'context',
		'currentVariable'
	],
	#category : #'CodeParadise-WebApplication-Debugger-View'
}

{ #category : #'web resources' }
CpContextView class >> style [

	<webResource: #css>

	^ '*, *:before, *:after {
		-moz-box-sizing: border-box;
		-webkit-box-sizing: border-box;
		box-sizing: border-box;
	}
	:host {
		display: block;
		height: 100%;
	}
	#container {
		position: relative;
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		height: 100%;
	}
	#method {
		flex: 0 0 50%;
		position: relative;
		height: 50%;
		padding: 8px;
		border-bottom: 4px #666 solid;
		overflow-y: scroll;
	}
	#method.local:before {
		display: block;
		position: absolute;
		bottom: 20px;
		padding: 8px;
		content: "This is a local method for the tiny image, source code is from the server and might not be the same.";
		border: rgba(0, 0, 0, .2) 1px solid;
		border-radius: 4px;
		background-color: rgba(255, 0, 0, .1);
	}
	#method.error slot {
		background-color: rgba(255, 0, 0, .3);
	}
	#open-browser {
		position: absolute;
		top: 8px;
		right: 8px;
	}
	#columns {
		flex: 1 0 auto;
		display: flex;
		justify-content: space-between;
		align-items: stretch;
	}
	#variables {
		flex: 1 1 50%;
		width: 50%;
		height: 100%;
		padding: 8px;
		border-right: 2px #666 solid;
	}
	#variable {
		flex: 1 1 50%;
		position: relative;
		width: 50%;
		height: 100%;
		padding: 8px;
		border-left: 2px #666 solid;
	}
	::slotted(span[slot="method"]) {
		display: block;
		white-space: pre;
	}
	::slotted(sl-skeleton) {
		padding-top: 8px;
	}
	::slotted(cp-variable:hover) {
		background-color: rgba(0, 0, 0, .05);
		cursor: pointer;
	}'
]

{ #category : #'web resources' }
CpContextView class >> template [

	<webResource: #html>

	^ '<div id="container">
		<div id="method"><slot name="method"></slot></div>
		<sl-button id="open-browser">Open browser (on server)</sl-button>
		<div id="columns">
			<div id="variables"><slot name="variables"></slot></div>
			<div id="variable"><slot name="variable"></slot</div>
		</div>
	</div>'
]

{ #category : #accessing }
CpContextView >> context [

	^ context
]

{ #category : #accessing }
CpContextView >> context: aContext [

	context := aContext
]

{ #category : #accessing }
CpContextView >> currentVariableView [

	^ (self allDescendantsMatching: CpVariableView asCssSelector)
		detect: [ :each | each variable == currentVariable ] ifNone: [ nil ]
]

{ #category : #initialization }
CpContextView >> initializeShadowRoot [

	super initializeShadowRoot.

	(self shadowRoot elementWithId: #'open-browser')
		when: CpClickEvent basicPrimary send: #openBrowser to: self
]

{ #category : #accessing }
CpContextView >> inspectorView [

	^ (self firstChildAtSlotNamed: #variable)
		ifNil: [ self appendChild: CpInspectorView new atSlotNamed: #variable ]
]

{ #category : #'event handling' }
CpContextView >> openBrowser [

	"Open browser on source code (on server)"
	CpClientEnvironment current
		serverAnnounce: (CpSourceCodeRequest openBrowserOnContext: context)
]

{ #category : #rendering }
CpContextView >> render [

	| variables |

	[
		self renderMethod.

		"Remove existing variables"
		self removeChildrenAtSlotNamed: #variables.

		"Select all variables and set current variable"
		variables := self variables.
		currentVariable := variables
			ifNotEmpty: [ variables first ]
			ifEmpty: [ nil ].

		"Render all and the current variable"
		variables do: [ :each | self renderVariable: each ].
		self renderCurrentVariable
	] on: Error do: [ :error | self crError: 'Error in debugger context: ', error printString ]
]

{ #category : #rendering }
CpContextView >> renderCurrentVariable [

	self inspectorView
		object: currentVariable value ;
		render
]

{ #category : #rendering }
CpContextView >> renderFakeMethod [

	"Fake the method signature"
	self
		appendChild: ((SlSkeleton new)
			styleAt: #width put: (20 + 40 atRandom) printString, '%' ;
			styleAt: #'--color' put: '#999' ;
			yourself)
		atSlotNamed: #method.

	self appendChild: (CpHtmlElement newWithTag: #p) atSlotNamed: #method.

	4 + 4 atRandom timesRepeat: [
		self
			appendChild: ((SlSkeleton new)
				styleAt: #width put: (40 + 60 atRandom) printString, '%' ;
				effectPulse ;
				yourself)
			atSlotNamed: #method ]
]

{ #category : #rendering }
CpContextView >> renderMethod [

	self removeChildrenAtSlotNamed: #method.

	"Start with fake method"
	self renderFakeMethod.

	"Request source code from server"
	CpClientEnvironment current
		serverAnnounce: (CpSourceCodeRequest context: context)
]

{ #category : #rendering }
CpContextView >> renderSourceCode: aDictionary [

	"Render the given source code, ignore if it does not match the receiver's context
	(it might be because of update which arrives too late)"

	| method sourceCode |

	"Handle error if present"
	aDictionary at: #error ifPresent: [ :error | ^ self renderSourceCodeError: error ].

	"Validate source code received"
	method := context method.
	method methodClass name = (aDictionary at: #className ifAbsent: [ nil ])
		ifFalse: [ ^ self ].
	method selector = (aDictionary at: #selector ifAbsent: [ nil ])
		ifFalse: [ ^ self ].

	"Retrieve source code"
	(sourceCode := aDictionary at: #sourceCode ifAbsent: [ nil ])
		ifNil: [ ^ self renderSourceCodeError: 'No source code found' ].

	"Render source code (remove potential error flag)"
	self replaceAllChildrenWith: sourceCode asHtmlElement atSlotNamed: #method.
	(self shadowRoot elementWithId: #method)
		classed: #local if: (aDictionary at: #isLocalMethod ifAbsent: [ false ]) ;
		removeClass: #error
]

{ #category : #rendering }
CpContextView >> renderSourceCodeError: aString [

	self replaceAllChildrenWith: aString asHtmlElement atSlotNamed: #method.
	(self shadowRoot elementWithId: #method)
		removeClass: #local ;
		addClass: #error
]

{ #category : #rendering }
CpContextView >> renderVariable: anAssociation [

	(self appendChild: CpVariableView new atSlotNamed: #variables)
		variable: anAssociation ;
		beSelected: currentVariable == anAssociation ;
		when: CpClickEvent basicPrimary send: #updateCurrentVariable: to: self ;
		render
]

{ #category : #'event handling' }
CpContextView >> updateCurrentVariable: aClickEvent [

	| variableView selectedVariable |

	variableView := aClickEvent currentTarget.

	selectedVariable := variableView variable.
	currentVariable = selectedVariable
		ifTrue: [ ^ self ].

	self currentVariableView beSelected: false.
	currentVariable := selectedVariable.
	self renderCurrentVariable.
	self currentVariableView beSelected: true
]

{ #category : #accessing }
CpContextView >> variables [

	"Answer a collection of variables (Associations)"

	| variables compiledCode numArgs |

	variables := OrderedCollection new.

	compiledCode := context method.

	variables
		add: 'receiver' -> context receiver ;
		add: 'selector' -> compiledCode selector.

	numArgs := context numArgs.
	1 to: numArgs do: [ :index |
		variables add: ('arg', index printString) -> (context tempAt: index) ].
	numArgs + 1 to: context numTemps do: [ :index |
		variables add: ('tmp', (index - numArgs) printString) -> (context tempAt: index) ].

	^ variables
]
