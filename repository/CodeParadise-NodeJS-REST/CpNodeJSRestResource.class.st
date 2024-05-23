Class {
	#name : #CpNodeJSRestResource,
	#superclass : #Object,
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #installing }
CpNodeJSRestResource class >> installClassMethod: aCompiledMethod [

	"Install the specified method.
	If the method represents an EndpointOperation, register it.

	Implementation:
	If the method does not represent a valid EndpointOperation,
	it is unregistered (the possibly previously registered operation
	will be removed)."

	| endpointOperation |

	super installMethod: aCompiledMethod.

	endpointOperation := CpNodeJSRestEndpointOperation fromCompiledMethod: aCompiledMethod.

	endpointOperation isValid
		ifTrue: [ CpNodeJSRestEndpointOperation registerOperation: endpointOperation ]
		ifFalse: [ CpNodeJSRestEndpointOperation unregisterOperation: endpointOperation ]
]

{ #category : #'class initialization' }
CpNodeJSRestResource class >> postInstall [

	"Try to install all endpoint operations of the receiver"

	super postInstall.

	self classSide selectorsAndMethodsDo: [ :selector :method |
		self installClassMethod: method ]
]

{ #category : #installing }
CpNodeJSRestResource class >> removeClassMethod: aCompiledMethod [

	"Remove the specified method.
	Unregister any EndpointOperation associated with this method.

	Implementation:
	To remove an operation an EndpointOperation is created which
	might in fact no correctly represent an EndpointOperation, but
	will identify as such, allowing unregistering it."

	| endpointOperation |

	super removeMethod: aCompiledMethod.

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
