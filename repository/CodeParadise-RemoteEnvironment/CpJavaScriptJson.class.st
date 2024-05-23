Class {
	#name : #CpJavaScriptJson,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #operations }
CpJavaScriptJson class >> parse: aString [

	"Answer a Dictionary representing the object given by the JSON string specified"

	^ self apply: #parse withArguments: { aString }
]

{ #category : #operations }
CpJavaScriptJson class >> stringify: aDictionary [

	"Answer a String representation of the specified Dictionary"

	^ self apply: #stringify withArguments: { aDictionary }
]
