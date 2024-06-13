"
I represent the JavaScript JSON namespace and I also work as a Proxy for JavaScript objects.
For the former I have the two #parse:/#stringify: methods.
For the latter I implement #at: and #at:put: and a DNU to allow access to fields.

"
Class {
	#name : #CpJavaScriptJSON,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #operations }
CpJavaScriptJSON class >> parse: aString [

	"Answer a Dictionary representing the object given by the JSON string specified"

	^ self apply: #parse withArguments: { aString }
]

{ #category : #operations }
CpJavaScriptJSON class >> stringify: aDictionary [

	"Answer a String representation of the specified Dictionary"

	^ self apply: #stringify withArguments: { aDictionary }
]

{ #category : #accessing }
CpJavaScriptJSON >> at: aString [

	"Answer the property with the specified name or nil if such a property does not exist"

	^ self propertyAt: aString
]

{ #category : #accessing }
CpJavaScriptJSON >> at: aString put: anObject [

	"Store the specified value in the property with the specified name"

	^ self propertyAt: aString put: anObject
]

{ #category : #'reflective operations' }
CpJavaScriptJSON >> doesNotUnderstand: aMessage [

	"Accept getters and setters"

	| key isSetter |

	"Check for keyword message"
	key := aMessage selector asString.
	(key first isLetter or: [ key first = $_ ])
		ifFalse: [ ^ super doesNotUnderstand: aMessage ].

	"Check for too many arguments (not a simple setter)"
	isSetter := key endsWith: ':'.
	(isSetter and: [ aMessage arguments size > 1 ])
		ifTrue: [ ^ super doesNotUnderstand: aMessage ].

	isSetter
		ifTrue: [ self at: key allButLast put: aMessage arguments first ]
		ifFalse: [ ^ self at: key ]
]

{ #category : #evaluating }
CpJavaScriptJSON >> value [

	"To allow accessing #value through a message send"

	^ self at: #value
]
