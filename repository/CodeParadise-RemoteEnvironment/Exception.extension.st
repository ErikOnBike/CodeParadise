Extension { #name : #Exception }

{ #category : #'*CodeParadise-RemoteEnvironment' }
Exception >> asJavaScriptError [

	"Answer the receiver's JavaScript representation or nil if none is availble"

	<applicationExtension>

	^ (tag isErrorObject and: [ tag isJavaScriptObject ])
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

{ #category : #'*CodeParadise-RemoteEnvironment' }
Exception >> isSqliteError [

	"Answer whether the receiver represents a Sqlite Error"

	<applicationExtension>

	^ false
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Exception >> rootCause [

	"Answer the root cause of the Exception. The root cause is the 'lowest'
	cause found in the chain of Exceptions. If an Exception does not have
	a lower cause, the Exception itself is the root cause."

	<applicationExtension>

	^ tag isErrorObject
		ifTrue: [ tag rootCause ]
		ifFalse: [ self ]
]
