Extension { #name : #Exception }

{ #category : #'*CodeParadise-RemoteEnvironment' }
Exception >> asJavaScriptError [

	"Answer the receiver's JavaScript representation or nil if none is availble.

	Implementation:
	Assume that if another Error object is present as a tag we have a JavaScript
	error stored there. Tag is (almost) unused in default Pharo image."

	<applicationExtension>

	^ tag isErrorObject
		ifTrue: [ tag ]
		ifFalse: [ nil ]
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Exception >> cause [

	"Answer the cause of the Exception or nil if no underlying cause
	(typically another Exception) is known."

	<applicationExtension>

	^ tag isErrorObject
		ifTrue: [ tag ]
		ifFalse: [ nil ]
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Exception >> isErrorObject [

	"Answer whether the receiver represents an Error"

	<applicationExtension>

	^ true
]
