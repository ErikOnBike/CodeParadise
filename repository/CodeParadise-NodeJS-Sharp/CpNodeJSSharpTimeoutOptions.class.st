Class {
	#name : #CpNodeJSSharpTimeoutOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpTimeoutOptions >> seconds [

	"Number of seconds after which processing will be stopped.

	Type: Integer"

	^ options at: #seconds
]

{ #category : #accessing }
CpNodeJSSharpTimeoutOptions >> seconds: anInteger [

	"Number of seconds after which processing will be stopped.

	Type: Integer"

	options at: #seconds put: anInteger
]
