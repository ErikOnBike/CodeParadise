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

	| serverEnvironment applicationClass |

	serverEnvironment := aClientLoaded environment ifProduction: [ ^ self ].

	"Only install instances of the receiver in WebApplications"
	applicationClass := CpServerApplication applicationClassWithId: aClientLoaded app.
	(applicationClass isNil or: [ applicationClass isWebApplication not ])
		ifTrue: [ ^ self ].

	^ self on: serverEnvironment
]

{ #category : #initialization }
CpClientDebuggerSupport class >> initialize [

	"Perform this method to have all applications receive debugger support.
	Otherwise add support manually sending #addDebugger to a specific Application instance."

	CpServerEnvironment whenClientLoadedSend: #clientLoaded: to: self
]

{ #category : #'instance creation' }
CpClientDebuggerSupport class >> on: anEnvironment [

	| instance |

	instance := self basicNew
		initializeWithEnvironment: anEnvironment ;
		yourself.

	self traceCr: 'Debugger installed ', instance printString.

	^ instance
]

{ #category : #initialization }
CpClientDebuggerSupport class >> release [

	<script>

	CpServerEnvironment unsubscribe: self.

	super release
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
		addInstallationChecker: (CpPackageInstallationChecker package: CpDebuggerView package) ;
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
