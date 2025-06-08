Class {
	#name : #CynModelDeleted,
	#superclass : #Announcement,
	#instVars : [
		'model'
	],
	#category : #'CodeParadise-Canyon-Model-Announcements'
}

{ #category : #accessing }
CynModelDeleted class >> model: aModel [

	^ self basicNew
		initializeWithModel: aModel ;
		yourself
]

{ #category : #initialization }
CynModelDeleted >> initializeWithModel: aModel [

	self initialize.

	model := aModel
]

{ #category : #accessing }
CynModelDeleted >> model [

	^ model
]
