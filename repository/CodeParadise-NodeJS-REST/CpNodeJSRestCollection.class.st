Class {
	#name : #CpNodeJSRestCollection,
	#superclass : #Object,
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #'request handling' }
CpNodeJSRestCollection class >> handleRequest: aRestRequest response: aServerResponse [

	"Handle the specified message and answer true if handled"

	self allSubclassesDo: [ :each |
		(each tryToHandleRequest: aRestRequest response: aServerResponse)
			ifTrue: [ ^ true ] ].

	^ false
]

{ #category : #private }
CpNodeJSRestCollection class >> performEndpointOperation: aSelector withParameters: anArray response: aServerResponse [

	"Perform the specified REST endpoint operation.

	Implementation:
	Since parameters can reference the request body which is retrieved
	using event mechanism, first retrieve this information.
	Invoke the operation once all parameters are ready."

	self resolveParametersIn: anArray thenDo: [
		| arguments response |
		arguments := anArray collect: [ :each | each value ].
		response := [ self perform: aSelector withArguments: arguments ] on: Error do: [ :error | error ].
		self writeResponse: response to: aServerResponse ]
]

{ #category : #enumerating }
CpNodeJSRestCollection class >> resolveParametersIn: anArray thenDo: aBlock [

	"Resolve all parameters in the specified parameter collection
	and perform the specified block when done"

	self resolveParametersStartingAt: 1 in: anArray thenDo: aBlock
]

{ #category : #enumerating }
CpNodeJSRestCollection class >> resolveParametersStartingAt: anInteger in: anArray thenDo: aBlock [

	"Resolve the specified parameter in the specified parameter collection
	and continu to next, perform the specified block when fully done"

	anInteger < anArray size
		ifTrue: [
			(anArray at: anInteger)
				resolveThenDo: [ self resolveParametersStartingAt: anInteger + 1 in: anArray thenDo: aBlock ] ]
		ifFalse: [ aBlock value ]
]

{ #category : #private }
CpNodeJSRestCollection class >> tryToHandleRequest: aRestRequest response: aServerResponse [

	"Try to handle the specified REST request and answer true if handled.

	Implementation:
	All my class methods represent (possible) endpoints. Try each in turn."

	self class selectorsAndMethodsDo: [ :selector :method |

		| endpoint |

		endpoint := CpNodeJSRestEndpoint fromCompiledMethod: method.

		(endpoint isValid and: [ endpoint handleRequest: aRestRequest response: aServerResponse ])
			ifTrue: [ ^ true ] ].

	^ false
]

{ #category : #private }
CpNodeJSRestCollection class >> writeResponse: anObject to: aServerResponse [

	"TODO"
]
