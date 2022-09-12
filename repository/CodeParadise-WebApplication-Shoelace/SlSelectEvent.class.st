Class {
	#name : #SlSelectEvent,
	#superclass : #SlEvent,
	#category : #'CodeParadise-WebApplication-Shoelace-Events'
}

{ #category : #accessing }
SlSelectEvent >> menuItem [

	"Answer the receiver's menu item which is stored in the event detail dictionary"

	^ self detail at: 'item' ifAbsent: [ nil ]
]

{ #category : #printing }
SlSelectEvent >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ', menuItem: ' ;
		print: self menuItem
]
