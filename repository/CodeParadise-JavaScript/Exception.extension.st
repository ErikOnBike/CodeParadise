Extension { #name : #Exception }

{ #category : #'*CodeParadise-JavaScript' }
Exception >> asJavaScriptError [

	"Answer the receiver's JavaScript representation or nil if none is availble"

	<applicationExtension>

	^ (tag isErrorObject and: [ tag isJavaScriptObject ])
		ifTrue: [ tag ]
]

{ #category : #'*CodeParadise-JavaScript' }
Exception >> cause [

	"Answer the cause of the Exception or nil if no underlying cause
	(typically another Exception) is known."

	<applicationExtension>

	^ tag isErrorObject
		ifTrue: [ tag ]
]

{ #category : #'*CodeParadise-JavaScript' }
Exception >> isErrorObject [

	"Answer whether the receiver represents an Error"

	<applicationExtension>

	^ true
]

{ #category : #'*CodeParadise-JavaScript' }
Exception >> isSqliteError [

	"Answer whether the receiver represents a Sqlite Error"

	<applicationExtension>

	^ false
]

{ #category : #'*CodeParadise-JavaScript' }
Exception >> rootCause [

	"Answer the root cause of the Exception. The root cause is the 'lowest'
	cause found in the chain of Exceptions. If an Exception does not have
	a lower cause, the Exception itself is the root cause."

	<applicationExtension>

	^ tag isErrorObject
		ifTrue: [ tag rootCause ]
		ifFalse: [ self ]
]

{ #category : #'*CodeParadise-JavaScript' }
Exception >> rootException [

	"Answer the Exception causing (or wrapped in) the receiver. The root exception
	is the 'lowest' exception found in the chain of Exceptions. If an Exception does
	not have a lower cause, the Exception itself is the root exception."

	<applicationExtension>

	^ tag isErrorObject
		ifTrue: [ tag rootException ]
		ifFalse: [ self ]
]
