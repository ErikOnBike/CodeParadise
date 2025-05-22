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

{ #category : #'class initialization' }
CpJavaScriptFunction class >> postInstallOnce [

	"Install a function which allows calling Smalltalk's #perform:withArguments: code.

	Implementation:
	This performer function is used internally by the CodeParadise System plugin."

	self getClass
		propertyAt: #smalltalkPerformer
		put: (self wrap: [ :instance :selector :arguments |
			instance perform: selector asSymbol withArguments: arguments ])
]

{ #category : #'class initialization' }
CpJavaScriptFunction class >> postSnapshotOnce [

	self postInstallOnce
]

{ #category : #converting }
CpJavaScriptFunction class >> wrap: aBlock [

	"Answer a JavaScriptFunction proxy which can be used to execute
	Smalltalk code in places where a JavaScript function is required.

	Implementation:
	Wrap the Block in a Context to allow execution by the VM interpreter.
	This allows Smalltalk calling JavaScript calling Smalltalk calling
	JavaScript constructs as well as recursive calls (even within the Block
	where the Block evaluates itself).
	The Block below makes sure the correct arguments are retrieved (which
	come from JavaScript) and the result is stored again for the JavaScript
	code performing this function (i.e. Block).
	The Context will be executed in a new Process, so the Process needs
	termination once the Block is evaluated and the result is stored."

	| instance |

	instance := super wrap: [

		"Execute the Block and store the result (or the error instance if an error occurred)"
		instance setResult: ([ aBlock valueWithArguments: (instance arguments: aBlock numArgs) ] on: Error do: [ :error |
			(CpJavaScriptError message: error messageText)
				rawPropertyAt: #cause put: error ;
				yourself ]).

		"Terminate the Process running this context"
		Processor activeProcess terminate ] asContext.

	"Add the original Block to the new JavaScript Function instance"
	^ instance
		setBlock: aBlock ;
		yourself
]

{ #category : #private }
CpJavaScriptFunction >> arguments: anInteger [

	"Answer the arguments of the receiver's executing JavaScript function (an Array),
	matching the number of arguments specified.
	If too many arguments are present, the last will be ignored.
	If not enough arguments are present, nils will be added."

	<primitive: 'primitiveJavaScriptFunctionArguments:' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #converting }
CpJavaScriptFunction >> asBlock [

	"Answer the Smalltalk Block used to create the receiver (if any)"

	<primitive: 'primitiveJavaScriptFunctionBlock' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #converting }
CpJavaScriptFunction >> asJavaScriptFunction [

	^ self
]

{ #category : #converting }
CpJavaScriptFunction >> asRelaxedJsonObjectValue [

	"Answer a representation of the receiver to be used in a relaxed JSON Object.
	This means the representation allows JavaScriptFunction property values too.

	JSON values can either be: String, Number (Float or Integer), Boolean, nil,
	a Dictionary-like value (Dictionary, OrderedDictionary or subclasses)
	or an Array of such elements.
	This variant accepts JavaScriptFunction values too."

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
CpJavaScriptFunction >> handleValueError [

	"Check if an exception was thrown"
	(self primLastExceptionAs: self exceptionClass)
		ifNotNil: [ :exception | ^ exception rootException signal ].

	"Log (generic) error"
	self errorCr: 'Error when evaluating function'.
	self consoleError.

	self primitiveFailed
]

{ #category : #private }
CpJavaScriptFunction >> setBlock: aBlock [

	"Set the Block which was used to create the receiver (using class side #wrap:)"

	<primitive: 'primitiveJavaScriptFunctionSetBlock:' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #private }
CpJavaScriptFunction >> setResult: anObject [

	"Set the result value for the receiver's executing JavaScript function"

	<primitive: 'primitiveJavaScriptFunctionSetResult:' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #operations }
CpJavaScriptFunction >> value [

	"Evaluate the receiver without any arguments"

	<primitive: 'primitiveJavaScriptFunctionValue' module: 'CpSystemPlugin'>
	self handleValueError
]

{ #category : #operations }
CpJavaScriptFunction >> value: anObject [

	"Evaluate the receiver with a single argument"

	<primitive: 'primitiveJavaScriptFunctionValue:' module: 'CpSystemPlugin'>
	self handleValueError
]

{ #category : #operations }
CpJavaScriptFunction >> value: arg1Object value: arg2Object [

	"Evaluate the receiver with two arguments"

	<primitive: 'primitiveJavaScriptFunctionValue:value:' module: 'CpSystemPlugin'>
	self handleValueError
]

{ #category : #operations }
CpJavaScriptFunction >> value: arg1Object value: arg2Object value: arg3Object [

	"Evaluate the receiver with two arguments"

	<primitive: 'primitiveJavaScriptFunctionValue:value:value:' module: 'CpSystemPlugin'>
	self handleValueError
]

{ #category : #operations }
CpJavaScriptFunction >> valueWithArguments: anArray [

	"Evaluate the receiver with the specified arguments"

	<primitive: 'primitiveJavaScriptFunctionValueWithArguments:' module: 'CpSystemPlugin'>
	self handleValueError
]
