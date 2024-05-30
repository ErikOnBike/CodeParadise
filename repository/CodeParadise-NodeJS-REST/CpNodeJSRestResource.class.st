Class {
	#name : #CpNodeJSRestResource,
	#superclass : #Object,
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #installing }
CpNodeJSRestResource class >> installClassMethod: aCompiledMethod [

	"Install the specified method.
	If the method represents an EndpointOperation, register it."

	super installMethod: aCompiledMethod.

	self registerOperation: aCompiledMethod
]

{ #category : #'class initialization' }
CpNodeJSRestResource class >> postInstall [

	"Try to install all endpoint operations of the receiver"

	super postInstall.

	self classSide selectorsAndMethodsDo: [ :selector :method |
		self installClassMethod: method ]
]

{ #category : #'registering endpoints' }
CpNodeJSRestResource class >> registerOperation: aCompiledMethod [

	"Register the specified CompiledMethod as an EndpointOperation (if it is valid).

	Implementation:
	If the method does not represent a valid EndpointOperation, it is unregistered
	(the possibly previously registered operation will be removed)."

	| endpointOperation |

	endpointOperation := CpNodeJSRestEndpointOperation fromCompiledMethod: aCompiledMethod.

	endpointOperation isValid
		ifTrue: [ CpNodeJSRestEndpointOperation registerOperation: endpointOperation ]
		ifFalse: [ CpNodeJSRestEndpointOperation unregisterOperation: endpointOperation ]
]

{ #category : #installing }
CpNodeJSRestResource class >> removeClassMethod: aCompiledMethod [

	"Remove the specified method.
	Unregister any EndpointOperation associated with this method."

	super removeMethod: aCompiledMethod.

	self unregisterOperation: aCompiledMethod
]

{ #category : #'registering endpoints' }
CpNodeJSRestResource class >> unregisterOperation: aCompiledMethod [

	"Unregister the EndpointOperation associated with the specified CompiledMethod.

	Implementation:
	First an EndpointOperation is created from the specified CompiledMethod. This
	endpoint might not be valid, but will identify as endpoint, allowing unregistering."

	| endpointOperation |

	endpointOperation := CpNodeJSRestEndpointOperation unsafeFromCompiledMethod: aCompiledMethod.

	CpNodeJSRestEndpointOperation unregisterOperation: endpointOperation
]

{ #category : #converting }
CpNodeJSRestResource >> asDictionary [

	"Answer a Dictionary representing the receiver"

	self subclassResponsibility
]

{ #category : #operations }
CpNodeJSRestResource >> toJSON [

	"Answer a JSON representation (a String) of the receiver.
	This method is assumed to be used to represent the full
	receiver (used when performing a GET operation for example)."

	^ CpJavaScriptJSON stringify: self asDictionary
]
