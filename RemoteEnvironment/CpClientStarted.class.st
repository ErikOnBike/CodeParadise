"
I am Announcement for the starting of the ClientEnvironment.
I know the application identifier (a String) of the ClientEnvironment (which is needed for routing).
"
Class {
	#name : #CpClientStarted,
	#superclass : #Announcement,
	#instVars : [
		'app'
	],
	#category : #'RemoteEnvironment-Core-Announcements'
}

{ #category : #'instance creation' }
CpClientStarted class >> app: identifier [

	^ self new
		app: identifier ;
		yourself
]

{ #category : #accessing }
CpClientStarted >> app [

	^ app
]

{ #category : #accessing }
CpClientStarted >> app: identifier [

	app := identifier
]
