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
