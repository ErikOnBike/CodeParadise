Class {
	#name : 'CpViewAnnouncement',
	#superclass : 'Announcement',
	#instVars : [
		'viewId',
		'announcement'
	],
	#category : 'CodeParadise-WebApplication-MVP-Core',
	#package : 'CodeParadise-WebApplication-MVP',
	#tag : 'Core'
}

{ #category : 'instance creation' }
CpViewAnnouncement class >> forView: aView announcing: anAnnouncement [

	^ self new
		viewId: aView id asSymbol ;
		announcement: anAnnouncement ;
		yourself
]

{ #category : 'accessing' }
CpViewAnnouncement >> announcement [

	^ announcement
]

{ #category : 'accessing' }
CpViewAnnouncement >> announcement: anAnnouncement [

	announcement := anAnnouncement
]

{ #category : 'accessing' }
CpViewAnnouncement >> viewId [

	^ viewId
]

{ #category : 'accessing' }
CpViewAnnouncement >> viewId: identifier [

	viewId := identifier
]
