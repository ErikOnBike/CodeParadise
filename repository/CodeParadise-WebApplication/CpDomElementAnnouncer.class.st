Class {
	#name : #CpDomElementAnnouncer,
	#superclass : #Announcer,
	#instVars : [
		'element'
	],
	#category : #'CodeParadise-WebApplication-DOM'
}

{ #category : #'instance creation' }
CpDomElementAnnouncer class >> new [

	self shouldNotImplement
]

{ #category : #'instance creation' }
CpDomElementAnnouncer class >> newFor: anElement [

	^ self basicNew
		initializeWith: anElement ;
		yourself
]

{ #category : #accessing }
CpDomElementAnnouncer >> element [

	^ element
]

{ #category : #initialization }
CpDomElementAnnouncer >> initializeWith: anElement [

	self initialize.

	element := anElement
]

{ #category : #'registration api' }
CpDomElementAnnouncer >> when: anAnnouncementClass do: aBlock [

	anAnnouncementClass addListenerTo: self element.

	super when: anAnnouncementClass do: aBlock
]

{ #category : #'registration api' }
CpDomElementAnnouncer >> when: anAnnouncementClass send: aSymbol to: anObject [

	anAnnouncementClass addListenerTo: self element.

	super when: anAnnouncementClass send: aSymbol to: anObject
]
