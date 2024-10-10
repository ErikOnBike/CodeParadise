Class {
	#name : #CpViewInspectorRequest,
	#superclass : #Announcement,
	#instVars : [
		'viewTagName'
	],
	#category : #'CodeParadise-WebApplication-Development-Announcements'
}

{ #category : #accessing }
CpViewInspectorRequest class >> viewTagName: aString [

	^ self basicNew
		initializeWithViewTagName: aString ;
		yourself
]

{ #category : #initialization }
CpViewInspectorRequest >> initializeWithViewTagName: aString [

	self initialize.

	viewTagName := aString
]

{ #category : #actions }
CpViewInspectorRequest >> perform [

	<serverEnvironment>

	self subclassResponsibility
]

{ #category : #actions }
CpViewInspectorRequest >> performIn: anEnvironment [

	<serverEnvironment>

	self perform
]

{ #category : #view }
CpViewInspectorRequest >> viewClass [

	"Answer the View class of the receiver"

	<serverEnvironment>

	viewTagName ifNil: [ ^ nil ].

	"Find by iterating over all class to match on tag name"
	CpTemplateComponent allSubclassesDo: [ :each |
		each tagName = viewTagName
			ifTrue: [ ^ each ] ].

	^ nil
]
