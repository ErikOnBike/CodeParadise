Class {
	#name : #CpClientDebuggerSupport,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'CodeParadise-WebApplication-Debugger-Support'
}

{ #category : #'event handling' }
CpClientDebuggerSupport class >> clientLoaded: aClientLoaded [

	"A new client is loaded create a new instance of the receiver
	(it will register as listener to the environment and therefore remain 'alive')"

	| instance |

	instance := self basicNew
		initializeWithEnvironment: aClientLoaded environment ;
		yourself.

	self crTrace: 'Debugger installed ', instance printString
]

{ #category : #initialization }
CpClientDebuggerSupport class >> initialize [

	CpServerEnvironment whenClientLoadedSend: #clientLoaded: to: self
]

{ #category : #actions }
CpClientDebuggerSupport >> debuggerSourceCodeAlert: aString [

	self debuggerSourceCodeResponse: { #error -> aString } asDictionary
]

{ #category : #actions }
CpClientDebuggerSupport >> debuggerSourceCodeResponse: aDictionary [

	"Send the source code response to the client"

	environment sendMessage: (MessageSend
		receiver: CpDebuggerView name
		selector: #sourceCodeResponse:
		arguments: { aDictionary })
]

{ #category : #initialization }
CpClientDebuggerSupport >> initializeWithEnvironment: anEnvironment [

	self initialize.

	environment := anEnvironment.

	environment
		addClass: CpDebuggerView ;
		when: CpSourceCodeRequest send: #sourceCodeRequest: to: self
]

{ #category : #'event handling' }
CpClientDebuggerSupport >> sourceCodeRequest: aSourceCodeRequest [

	| methodClass method |

	[
		methodClass := Smalltalk classNamed: aSourceCodeRequest className.
		methodClass ifNil: [
			self debuggerSourceCodeAlert: 'Unknown class ', aSourceCodeRequest className printString.
			^ self ].

		method := methodClass lookupSelector: aSourceCodeRequest selector.
		method ifNil: [
			self debuggerSourceCodeAlert: 'No method ', aSourceCodeRequest selector printString, ' in class (or one of its superclasses) ', methodClass printString.
			^ self ].

		aSourceCodeRequest openBrowser
			ifTrue: [ method browse ]
			ifFalse: [
				self debuggerSourceCodeResponse: {
					#className -> aSourceCodeRequest className.
					#selector -> aSourceCodeRequest selector.
					#sourceCode -> (method sourceCode replaceAll: Character cr with: Character lf).
					#isLocalMethod -> (CpClientEnvironment hasPreInstalledClass: methodClass)
				} asDictionary ]
	] on: Error do: [ :error | self debuggerSourceCodeAlert: 'Error during source code request: ', error printString ]
]
