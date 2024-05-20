Class {
	#name : #CpNodeJSRestEndpoint,
	#superclass : #Object,
	#instVars : [
		'method',
		'pathPattern',
		'requiredParams',
		'operation'
	],
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #'instance creation' }
CpNodeJSRestEndpoint class >> fromCompiledMethod: aCompiledMethod [

	^ self basicNew
		initializeWithCompiledMethod: aCompiledMethod ;
		yourself
]

{ #category : #'request handling' }
CpNodeJSRestEndpoint >> handleRequest: aRestRequest response: aServerResponse [

	"Handle the specified REST request and answer true if handled"

	| parameters |

	method = aRestRequest method
		ifFalse: [ ^ false ].

	(pathPattern matchesPath: aRestRequest path)
		ifFalse: [ ^ false ].

	"Collect parameters"
	parameters := Array new: requiredParams size.
	requiredParams keysAndValuesDo: [ :index :parameter |
		parameters at: index put: (parameter valueFromRequest: aRestRequest forEndpoint: self) ].

	"Perform the operation (which is a class method)"
	operation methodClass instanceSide
		performEndpointOperation: operation selector
		withParameters: parameters
		response: aServerResponse.

	^ true
]

{ #category : #initialization }
CpNodeJSRestEndpoint >> initialize [

	super initialize.

	requiredParams := IdentityDictionary new
]

{ #category : #initialization }
CpNodeJSRestEndpoint >> initializeWithCompiledMethod: aCompiledMethod [

	| pragmaHandlers |

	self initialize.

	pragmaHandlers := Dictionary new
		at: #restMethod:path: put: [ :pragma |
			method := pragma arguments first.
			pathPattern := CpNodeJSRestPathPattern fromString: pragma arguments second ] ;
		at: #restParam:from: put: [ :pragma |
			requiredParams
				at: pragma arguments first
				ifPresent: [ self error: 'REST endpoint param ', pragma arguments first printString, ' defined multiple times' ]
				ifAbsentPut: [ CpNodeJSRestParameter fromLocation: pragma arguments second ] ] ;
		at: #restParam:from:at: put: [ :pragma |
			requiredParams
				at: pragma arguments first
				ifPresent: [ self error: 'REST endpoint param ', pragma arguments first printString, ' defined multiple times' ]
				ifAbsentPut: [ CpNodeJSRestParameter fromLocation: pragma arguments second at: pragma arguments third ] ] ;
		yourself.

	"Handle all pragmas to fill my instance variables"
	aCompiledMethod pragmas do: [ :each |
		pragmaHandlers at: each keyword ifPresent: [ :handler |
			handler value: each ] ].

	"The operation is our CompiledMethod (which is a class side method, don't need explicit receiver)"
	operation := aCompiledMethod.
	
	self validate
]

{ #category : #testing }
CpNodeJSRestEndpoint >> isValid [

	"Answer whether the receiver is a valid endpoint.

	Implementation:
	Assume the receiver is initialized on a CompiledMethod.
	In this case the validate method has been executed.
	IF method is nil it means the receiver is completely
	'empty' and therefore is not valid."

	^ method isNotNil
]

{ #category : #accessing }
CpNodeJSRestEndpoint >> pathParameterFrom: aPath at: aSymbol [

	^ pathPattern parameterNamed: aSymbol fromPath: aPath
]

{ #category : #validating }
CpNodeJSRestEndpoint >> validate [

	"Validate the receiver is a complete and correct instance OR completely 'empty'"

	"Check for the 'empty' case"
	method ifNil: [
		self validateEmpty.
		^ self ].

	(pathPattern isNil or: [ pathPattern isEmpty ])
		ifNil: [ self error: 'REST endpoint definition is missing a path pattern' ].

	"Check for presence of all required parameters"
	requiredParams size = operation numArgs
		ifFalse: [ self error: 'REST endpoint definition does not have the correct number of parameters defined, expected ', operation numArgs printString, ' received ', requiredParams size printString ].
	1 to: requiredParams size do: [ :parameterIndex |
		requiredParams at: parameterIndex ifAbsent: [ self error: 'REST endpoint definition is missing a definition for parameter ', parameterIndex printString ] ].

	"Check if path parameters exist (only one we know right now, others are in message)"
	requiredParams valuesDo: [ :each |
		(each isPathParameter and: [ (pathPattern hasParameterNamed: each key) not ])
			ifTrue: [ self error: 'REST endpoint definition refers to path parameter ', each key, ' which does not exist' ] ]
]

{ #category : #validating }
CpNodeJSRestEndpoint >> validateEmpty [

	"Validate the receiver is completely 'empty'"

	(method isNil and: [ pathPattern isNil and: [ requiredParams isEmpty ] ])
		ifFalse: [ self error: 'REST endpoint definition is partly given, elements are missing' ]
]
