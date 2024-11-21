"
I represent a JavaScript function.
I am used in CpJavaScriptEventTarget to represent an event handler.
Smalltalk blocks can be wrapped in an instance of me using:
	CpJavaScriptFunction wrap: [ ""some block"" ]

"
Class {
	#name : #CpJavaScriptFunction,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #private }
CpJavaScriptFunction class >> currentArguments [

	"Answer the currently executing function's arguments (an Array).
	This method should only be called while the receiver's block is
	being executed."

	<primitive: 'primitiveJavaScriptFunctionCurrentArguments' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #private }
CpJavaScriptFunction class >> currentSetResult: anObject [

	"Set the currently executing function's result value.
	This method should only be called while the receiver's block is
	being executed."

	<primitive: 'primitiveJavaScriptFunctionCurrentSetResult:' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #converting }
CpJavaScriptFunction class >> wrap: aBlock [

	"Answer a JavaScriptFunction proxy which can be used to execute
	Smalltalk code in places where a JavaScript function is required.

	Implementation:
	Wrap the Block in a Context to allow execution by a Process (internally).
	This allows Smalltalk calling JavaScript calling Smalltalk calling
	JavaScript constructs as well as recursive calls (even within the Block
	where the Block evaluates itself).
	The Block below makes sure the correct arguments are retrieved (which
	come from JavaScript) and the result is stored again for the JavaScript
	code performing this function (i.e. Block).
	Since the Context will be used inside a Process that will be created
	when the function gets executed, we need to terminate this (i.e. the
	active) Process at the end of the Block."

	^ (super wrap: [
			| arguments |

			"Retrieve and resize arguments to match the Block"
			arguments := self currentArguments.
			arguments size = aBlock numArgs
				ifFalse: [
					"Create correct sized arguments Array (potentially losing arguments or adding nils)"
					| receivedArguments |
					receivedArguments := arguments.
					arguments := Array new: aBlock numArgs.
					arguments
						replaceFrom: 1
						to: (receivedArguments size min: arguments size)
						with: receivedArguments
						startingAt: 1 ].

			"Execute the Block and store the result (or the error instance if an error occurred)"
			self currentSetResult: ([ aBlock valueWithArguments: arguments ] on: Error do: [ :error |
				(CpJavaScriptError message: error messageText)
					rawPropertyAt: #cause put: error ;
					yourself ]).

			"Stop execution"
			Processor activeProcess terminate ] asContext)

		"Add the original Block as property to the new JavaScript Function instance"
		rawPropertyAt: #_st_block put: aBlock ;
		yourself
]

{ #category : #converting }
CpJavaScriptFunction >> asBlock [

	"Answer the Smalltalk Block used to create the receiver (if any)"

	^ self rawPropertyAt: #_st_block
]

{ #category : #converting }
CpJavaScriptFunction >> asJavaScriptFunction [

	^ self
]

{ #category : #operations }
CpJavaScriptFunction >> call: anObject withArguments: anArray [

	"Call the the receiver's proxied JavaScript object (i.e. function)
	with the specified arguments.
	Because of the similar names, the JavaScript methods 'apply()' and
	'call' are both mapped onto this #call:withArguments:"

	^ self apply: #apply withArguments: { self . anArray }
]

{ #category : #operations }
CpJavaScriptFunction >> call: anObject withArguments: anArray resultAs: aClass [

	"Call the the receiver's proxied JavaScript object (i.e. function)
	with the specified arguments.
	Because of the similar names, the JavaScript methods 'apply()' and
	'call' are both mapped onto this #call:withArguments:"

	^ self apply: #apply withArguments: { self . anArray } resultAs: aClass
]
