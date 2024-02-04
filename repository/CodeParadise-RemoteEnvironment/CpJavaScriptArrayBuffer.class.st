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
