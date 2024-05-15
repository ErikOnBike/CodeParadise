"
I am a base Announcement for the ready state of a ClientEnvironment.
I know the application identifier (a String) of the ClientEnvironment (which is needed for routing).
"
Class {
	#name : 'CpClientReady',
	#superclass : 'Announcement',
	#instVars : [
		'variables',
		'environment'
	],
	#category : 'CodeParadise-RemoteEnvironment-Core-Announcements',
	#package : 'CodeParadise-RemoteEnvironment',
	#tag : 'Core-Announcements'
}

{ #category : 'organization' }
CpClientReady class >> variables: aDictionary environment: anEnvironment [

	^ self new
		variables: aDictionary ;
		environment: anEnvironment ;
		yourself
]

{ #category : 'accessing' }
CpClientReady >> app [

	^ self variableAt: CpClientEnvironment variableNameApp
]

{ #category : 'accessing' }
CpClientReady >> environment [

	^ environment
]

{ #category : 'accessing' }
CpClientReady >> environment: anEnvironment [

	environment := anEnvironment
]

{ #category : 'accessing' }
CpClientReady >> variableAt: aSymbol [ 

	^ variables at: aSymbol ifAbsent: [ nil ]
]

{ #category : 'accessing' }
CpClientReady >> variables [ 

	"Answer copy to make sure my instance variable does not change."

	^ variables copy
]

{ #category : 'accessing' }
CpClientReady >> variables: aDictionary [ 

	variables := aDictionary
]
