Class {
	#name : #CpJavaScriptFunction,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #operations }
CpJavaScriptFunction >> call: anObject withArguments: anArray [

	"Call the the receiver's proxied JavaScript object (i.e. function)
	with the specified arguments.
	Because of the similar names, the JavaScript methods 'apply()' and
	'call' are both mapped onto this #call:withArguments:"

	^ self apply: #apply withArguments: { self . anArray }
]
