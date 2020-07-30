"
I am a base Announcement for the ready state of a ClientEnvironment.
I know the application identifier (a String) of the ClientEnvironment (which is needed for routing).
"
Class {
	#name : #CpClientReady,
	#superclass : #Announcement,
	#instVars : [
		'app',
		'environment'
	],
	#category : #'CodeParadise-RemoteEnvironment-Core-Announcements'
}

{ #category : #organization }
CpClientReady class >> app: identifier environment: anEnvironment [

	^ self new
		app: identifier ;
		environment: anEnvironment ;
		yourself
]

{ #category : #accessing }
CpClientReady >> app [

	^ app
]

{ #category : #accessing }
CpClientReady >> app: identifier [

	app := identifier
]

{ #category : #accessing }
CpClientReady >> environment [

	^ environment
]

{ #category : #accessing }
CpClientReady >> environment: anEnvironment [

	environment := anEnvironment
]
