"
I represent a JavaScript AarayBuffer which can be used
(and sometimes needs to be used) to convert from/to
byte or word arrays.
"
Class {
	#name : #CpJavaScriptArrayBuffer,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #converting }
CpJavaScriptArrayBuffer >> asByteArray [

	"Create ByteArray instance from the JavaScript ArrayBuffer through a TypedArray (with bytes)"

	^ (CpJavaScriptObject newInstanceFor: #Uint8Array withArguments: { self })
		asSmalltalkObject
]

{ #category : #converting }
CpJavaScriptArrayBuffer >> asWordArray [

	"Create WordArray instance from the JavaScript ArrayBuffer through a TypedArray (with words)"

	^ (CpJavaScriptObject newInstanceFor: #Uint32Array withArguments: { self })
		asSmalltalkObject
]
