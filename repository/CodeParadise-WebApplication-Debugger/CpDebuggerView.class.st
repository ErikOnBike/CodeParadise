Class {
	#name : #CpDebuggerView,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'exception',
		'currentContext'
	],
	#category : #'CodeParadise-WebApplication-Debugger-View'
}

{ #category : #private }
CpDebuggerView class >> close [

	"Close first (and only) instance of the receiver"

	self first
		ifNotNil: [ :debugger | debugger destroy ]
]

{ #category : #private }
CpDebuggerView class >> debug: anException [

	"Use or create first instance of the receiver to debug the specified exception"

	(self first ifNil: [ CpHtmlElement documentBody appendChild: self new ])
		debug: anException
]

{ #category : #'event handling' }
CpDebuggerView class >> exceptionAnnounced: anExceptionAnnouncement [

	self debug: anExceptionAnnouncement exception
]

{ #category : #'class initialization' }
CpDebuggerView class >> postInstallOnce [

	"Register the receiver so we can send messages to it and start listening for exception announcements"

	CpClientEnvironment current objectRegistry
		registerObject: self
		withId: self name.

	CpExceptionAnnouncer when: CpExceptionAnnouncement send: #exceptionAnnounced: to: self
]

{ #category : #private }
CpDebuggerView class >> sourceCodeResponse: aDictionary [

	self first
		ifNotNil: [ :debugger | debugger renderSourceCode: aDictionary ]
]

{ #category : #'web resources' }
CpDebuggerView class >> style [

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
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		height: 100%;
		font-family: "Monaco", "Lucida Grande", "Andela Mono", "Courier";
		font-size: 12px;
		background-color: #fff;
		overflow: hidden;
	}
	#exception {
		flex: 0 0 auto;
		display: flex;
		justify-content: space-between;
		text-align: center;
		padding: 8px;
		background-color: rgba(0, 0, 0, .1);
		border-bottom: 4px #666 solid;
	}
	#exception slot {
		display: block;
		flex-grow: 1;
	}
	#call-stack {
		flex: 0 0 auto;
		display: flex;
		flex-direction: column;
		height: 30%;
		padding: 8px;
		border-bottom: 4px #666 solid;
		overflow: hidden;
	}
	#call-stack-list {
		overflow-y: scroll;
	}
	::slotted(cp-context-line:hover) {
		background-color: rgba(0, 0, 0, .05);
		cursor: pointer;
	}
	#context {
		flex: 1 0 auto;
		height: max-content;
		overflow: hidden;
	}
	button {
		display: inline-block;
		height: 32px;
		padding: 8px;
		border: 0;
		border-radius: 4px;
		box-shadow: none;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	button:hover {
		background-color: rgba(0, 0, 255, .1);
		cursor: pointer;
	}'
]

{ #category : #'web resources' }
CpDebuggerView class >> template [

	<webResource: #html>

	^ '<div id="container">
		<div id="exception"><slot name="exception"></slot><button id="close-button">Close</button></div>
		<div id="call-stack">
			<div id="call-stack-label">Call stack:</div>
			<div id="call-stack-list"><slot name="call-stack"></slot></div>
		</div>
		<div id="context"><slot name="context"></slot></div>
	</div>'
]

{ #category : #accessing }
CpDebuggerView >> callStackLineView [

	^ CpContextLineView all
		detect: [ :each | each context == currentContext ] ifNone: [ nil ]
]

{ #category : #accessing }
CpDebuggerView >> currentContextView [

	^ (self firstChildAtSlotNamed: #context)
		ifNil: [ self appendChild: CpContextView new atSlotNamed: #context ]
]

{ #category : #actions }
CpDebuggerView >> debug: anException [

	"Debugging can be done on single instance only, therefore stop if debugging is already taking place.

	In a future version multiple debuggers can be allowed, but some limit might be useful for situations
	where an exception occurs within a Transition or Event which gets called too many times in a short
	period)."

	exception ifNotNil: [
		self errorCr: 'A new Error is signaled during debugging (will be ignored for the moment to prevent infinite debuggers on recursion)'.
		self errorCr: exception printString.
		^ self ].

	exception := anException.

	"Always start from the sender of the signal (otherwise we'll always start with #error: or #doesNotUnderstand:)"
	currentContext := anException signalerContext sender.

	self render
]

{ #category : #accessing }
CpDebuggerView >> exception [

	^ exception
]

{ #category : #accessing }
CpDebuggerView >> exceptionView [

	^ (self firstChildAtSlotNamed: #exception)
		ifNil: [ self appendChild: CpExceptionView new atSlotNamed: #exception ]
]

{ #category : #halting }
CpDebuggerView >> halt [

	"Show a debugger with a number of interesting objects
	(making these temporary reveals them in the debugger)"

	| globals processes |

	globals := Smalltalk globals.
	processes := Process allInstances.

	self error: 'Manually interrupted'
]

{ #category : #actions }
CpDebuggerView >> hide [

	self styleAt: #display put: #none
]

{ #category : #initialization }
CpDebuggerView >> initialize [

	"Make myself top view, but do not show by default"

	super initialize.

	self attributeAt: #style put: 'display: none; position: absolute; top: 0; left: 0; width: 100%; height: 100%;'.

	"Install break handler"
"	CpHtmlElement documentBody
		when: (CpKeyDownEvent key: '.') & (CpAltKeyDown + CpCtrlKeyDown + CpShiftKeyDown) send: #halt to: self.
"
]

{ #category : #initialization }
CpDebuggerView >> initializeShadowRoot [

	super initializeShadowRoot.

	(self shadowedElementWithId: #'close-button')
		when: CpClickEvent basicPrimary send: #close to: self class
]

{ #category : #rendering }
CpDebuggerView >> render [

	[
		self renderException.
		self renderCallStack.
		self renderCurrentContext.
		self show
	] on: Error do: [ :error | self errorCr: 'Error in the debugger: ', error printString ]
]

{ #category : #rendering }
CpDebuggerView >> renderCallStack [

	| lastContext |

	self removeChildrenAtSlotNamed: #'call-stack'.

	lastContext := exception signalerContext.
	[ lastContext isNotNil ] whileTrue: [
		self renderCallStackLine: lastContext.
		lastContext := lastContext sender ]
]

{ #category : #rendering }
CpDebuggerView >> renderCallStackLine: aContext [

	(self appendChild: CpContextLineView new atSlotNamed: #'call-stack')
		context: aContext ;
		beSelected: aContext == currentContext ;
		when: CpClickEvent basicPrimary send: #updateCurrentContext: to: self ;
		render
]

{ #category : #rendering }
CpDebuggerView >> renderCurrentContext [

	self currentContextView
		context: currentContext ;
		render
]

{ #category : #rendering }
CpDebuggerView >> renderException [

	self exceptionView
		exception: exception ;
		render
]

{ #category : #rendering }
CpDebuggerView >> renderSourceCode: aDictionary [

	self currentContextView renderSourceCode: aDictionary
]

{ #category : #actions }
CpDebuggerView >> show [

	self styleAt: #display put: #block
]

{ #category : #'event handling' }
CpDebuggerView >> updateCurrentContext: aClickEvent [

	| contextLineView selectedContext |

	contextLineView := aClickEvent currentTarget.

	selectedContext := contextLineView context.
	currentContext = selectedContext
		ifTrue: [ ^ self ].

	self callStackLineView beSelected: false.
	currentContext := selectedContext.
	self renderCurrentContext.
	self callStackLineView beSelected: true
]
