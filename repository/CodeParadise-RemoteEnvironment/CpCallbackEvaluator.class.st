"
I am responsible to evaluate JavaScript callback functions.
To be able to make use of me, please be sure to have me loaded inside an application.
This can be done by sending the #beLoaded message to my class side from one of the
classes installed in the application. Some application types might do this by default
(look for references to me to see where I am already loaded).

Implementation:
I create and register a Process which will be used to execute specific (primitive) methods.
This allows executing code without interruption to allow the return of values in a
synchronous way.

"
Class {
	#name : #CpCallbackEvaluator,
	#superclass : #Object,
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #'processing - private' }
CpCallbackEvaluator class >> createCallbackEvaluatorProcess [

	"Create an callback evaluation process, register it and start it"

	| callbackEvaluatorProcess |

	"Create process with highest priority to handle evaluations as fast as possible (without interruptions)"
	callbackEvaluatorProcess := Process
		forContext: [ [

			"Wait for callbacks to become available"
			Processor activeProcess suspend.

			"Evaluate the current callback"
			self evaluateCallback ] repeat ] asContext
		priority: Processor highestPriority.

	"Register the callback evaluation process so the VM (plugin) can activate it"
	self registerCallbackEvaluatorProcess: callbackEvaluatorProcess.
	callbackEvaluatorProcess name: self name.

	"Start the process (which will actually put it to sleep waiting for the first callback)"
	callbackEvaluatorProcess resume
]

{ #category : #'processing - private' }
CpCallbackEvaluator class >> currentCallbackBlockAndArguments [

	"Answer the current callback block and arguments (anArray) as an Array
	(with both values in the specified order: block first, arguments second)"

	<primitive: 'primitiveCallbackEvaluatorCurrentCallbackBlockAndArguments' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #'processing - private' }
CpCallbackEvaluator class >> currentCallbackResult: anObject [

	"Store the result for the current callback.
	This method will fail if called outside the callback handling in #evaluateCallback."

	<primitive: 'primitiveCallbackEvaluatorCurrentCallbackResult:' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #'processing - private' }
CpCallbackEvaluator class >> evaluateCallback [

	"Evaluate the current callback"

	| callbackAndArguments block arguments result |

	(callbackAndArguments := self currentCallbackBlockAndArguments)
		ifNil: [ ^ self ].

	"Retrieve callback block and arguments (and fix arguments if needed)"
	block := callbackAndArguments first.
	arguments := callbackAndArguments second.
	arguments size = block numArgs
		ifFalse: [
			"Create correct sized arguments Array (potentially losing arguments or adding nils)"
			| receivedArguments |
			receivedArguments := arguments.
			arguments := Array new: block numArgs.
			arguments
				replaceFrom: 1
				to: (receivedArguments size min: arguments size)
				with: receivedArguments
				startingAt: 1 ].

	"Evaluate block"
	result := block valueWithArguments: arguments.

	"Store result back in JavaScript callback object"
	self currentCallbackResult: result
]

{ #category : #'class initialization' }
CpCallbackEvaluator class >> postInstallOnce [

	"Register the callback evaluation process once"

	self registerCallbackEvaluatorProcess
]

{ #category : #'class initialization' }
CpCallbackEvaluator class >> postSnapshotOnce [

	"Register the callback evaluation process once"

	self registerCallbackEvaluatorProcess
]

{ #category : #'processing - private' }
CpCallbackEvaluator class >> registerCallbackEvaluatorProcess [

	"Register a new or reregister the existing callback evaluation process"

	Process allInstancesDo: [ :each |
		each name = self name
			ifTrue: [
				self registerCallbackEvaluatorProcess: each.
				^ self ] ].

	self createCallbackEvaluatorProcess
]

{ #category : #'processing - private' }
CpCallbackEvaluator class >> registerCallbackEvaluatorProcess: eventHandlerProcess [

	"Register the process which handles callback evaluation to allow it to be activated when a callback is executed"

	<primitive: 'primitiveCallbackEvaluatorRegisterProcess:' module: 'CpSystemPlugin'>
	self primitiveFailed
]
