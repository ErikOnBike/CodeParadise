"
I represent a JavaScript function. I can be used for callbacks and Promises.
I am also used in CpJavaScriptEventTarget to represent an event handler.
Smalltalk blocks can be wrapped in an instance of me using:
	CpJavaScriptFunction wrap: [ ""some block"" ]

Within the CpJavaScriptObject >> #apply:... range of methods, any Block
arguments are automatically wrapped in an instance of me. So there is normally
no need to do the wrapping manually/explicitly. You are free to do so anyway.

Implementation:
The execution of an instance of me is always performed on a separate Process.
This allows multiple instances to run in 'parallel' when used for callbacks
or in Promises where some form of asynchronous operation is required.
Remember this might influence the value of 'Processor activeProcess' outside
and inside a Block of code (within the same method).

"
Class {
	#name : #CpJavaScriptFunction,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Core'
}

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

	| instance executionContext |

	executionContext := [
		| arguments |

		"Retrieve and resize arguments to match the Block"
		arguments := instance arguments.
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
		instance setResult: ([ aBlock valueWithArguments: arguments ] on: Error do: [ :error |
			(CpJavaScriptError message: error messageText)
				rawPropertyAt: #cause put: error ;
				yourself ]).

		"Stop execution"
		Processor activeProcess terminate ] asContext.

	"Create an instance with the newly created execution Context"
	instance := super wrap: executionContext.

	"Add the original Block as property to the new JavaScript Function instance"
	^ instance
		rawPropertyAt: #_st_block put: aBlock ;
		yourself
]

{ #category : #private }
CpJavaScriptFunction >> arguments [

	"Answer the arguments of the receiver's executing JavaScript function (an Array)"

	<primitive: 'primitiveJavaScriptFunctionArguments' module: 'CpSystemPlugin'>
	self primitiveFailed
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

	^ self apply: #apply withArguments: { anObject . anArray }
]

{ #category : #operations }
CpJavaScriptFunction >> call: anObject withArguments: anArray resultAs: aClass [

	"Call the the receiver's proxied JavaScript object (i.e. function)
	with the specified arguments.
	Because of the similar names, the JavaScript methods 'apply()' and
	'call' are both mapped onto this #call:withArguments:"

	^ self apply: #apply withArguments: { anObject . anArray } resultAs: aClass
]

{ #category : #private }
CpJavaScriptFunction >> setResult: anObject [

	"Set the result value for the receiver's executing JavaScript function"

	<primitive: 'primitiveJavaScriptFunctionSetResult:' module: 'CpSystemPlugin'>
	self primitiveFailed
]
