"
I am Announcement for the starting of the ClientEnvironment.
I know the application identifier (a String) of the ClientEnvironment (which is needed for routing).
"
Class {
	#name : #CpClientStarted,
	#superclass : #Announcement,
	#instVars : [
		'variables'
	],
	#category : #'CodeParadise-RemoteEnvironment-Core-Announcements'
}

{ #category : #'instance creation' }
CpClientStarted class >> variables: aDictionary [ 

	^ self new
		variables: aDictionary ;
		yourself
]

{ #category : #accessing }
CpClientStarted >> app [

	^ self variableAt: CpClientEnvironment variableNameApp
]

{ #category : #accessing }
CpClientStarted >> variableAt: aSymbol [ 

	^ variables at: aSymbol ifAbsent: [ nil ]
]

{ #category : #accessing }
CpClientStarted >> variables [ 

	"Answer copy to make sure my instance variable does not change."

	^ variables copy
]

{ #category : #accessing }
CpClientStarted >> variables: aDictionary [ 

	variables := aDictionary
]
