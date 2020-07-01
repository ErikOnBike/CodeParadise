Extension { #name : #Class }

{ #category : #'*RemoteEnvironment' }
Class >> cpEncodeWith: anEncoder [

	"This extension method should not be present in the ClientEnvironment!
	Otherwise classes within Announcements will be installed on the server."

	self flag: #todo. "Add logic which works for both ClientEnvironment and ServerEnvironment"
	anEncoder encodeClass: self
]

{ #category : #'*RemoteEnvironment' }
Class >> cpRequiredClasses [

	"Answer a collection of Classes the receiver is dependent on in the ClientEnvironment"

	^ #()
]

{ #category : #'*RemoteEnvironment' }
Class >> postInstall [

	"Perform any necessary initialization after receiver is installed in the ClientEnvironment.
	In contrast with a class side #initialize, this method should be called from subclasses
	using [[[ super postInstall ]]]."

	<clientEnvironment>

]

{ #category : #'*RemoteEnvironment' }
Class >> subclass: className instanceVariableNames: instVarNames classVariableNames: classVarNames [

	"Create a new Class in the same package as the receiver"

	<clientEnvironment>

	^ self
		subclass: className
		instanceVariableNames: instVarNames
		classVariableNames: classVarNames
		package: self category
]
