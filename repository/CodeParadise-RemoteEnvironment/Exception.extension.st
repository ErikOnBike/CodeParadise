Extension { #name : #Exception }

{ #category : #'*CodeParadise-RemoteEnvironment' }
Exception >> cause [

	"Answer the cause of the Exception or nil if no underlying cause
	(typically another Exception) is known."

	<applicationExtension>

	^ nil
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Exception >> isErrorObject [

	"Answer whether the receiver represents an Error"

	<applicationExtension>

	^ true
]
