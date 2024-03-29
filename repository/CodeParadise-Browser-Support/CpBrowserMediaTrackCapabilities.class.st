Class {
	#name : #CpBrowserMediaTrackCapabilities,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-MediaStreams'
}

{ #category : #accessing }
CpBrowserMediaTrackCapabilities class >> getClassName [

	"Browsers implement me as a regular object/dictionary, therefore override the class I represent"

	^ 'Object'
]

{ #category : #'reflective operations' }
CpBrowserMediaTrackCapabilities >> doesNotUnderstand: aMessage [

	"Convenience method to allow accessing properties directly.
	There is no explicit class for this information just an Object/dictionary
	like element. Since it will/should only contain properties, simply
	transform any request into a property access (if arguments are compatible)."

	aMessage arguments
		ifEmpty: [ ^ self propertyAt: #aMessage selector ].
	aMessage arguments size = 1
		ifTrue: [
			self propertyAt: aMessage selector put: aMessage arguments first.
			^ self ].

	^ self apply: aMessage selector withArguments: aMessage arguments
]
