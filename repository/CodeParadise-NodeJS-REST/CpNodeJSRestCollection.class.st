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

{ #category : #'request handling' }
CpNodeJSRestCollection class >> performEndpointOperation: aSelector withArguments: anArray response: aServerResponse [

	"Perform the specified REST endpoint operation.

	Implementation:
	Since parameters can reference the request body which is retrieved
	using event mechanism, first retrieve this information.
	Invoke the operation once all parameters are ready."

	
]

{ #category : #'request handling' }
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
