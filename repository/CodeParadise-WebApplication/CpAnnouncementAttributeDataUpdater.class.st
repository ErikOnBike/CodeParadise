Class {
	#name : #CpAnnouncementAttributeDataUpdater,
	#superclass : #CpPrefixedAttributeDataUpdater,
	#instVars : [
		'announcementClass'
	],
	#category : #'CodeParadise-WebApplication-Support'
}

{ #category : #accessing }
CpAnnouncementAttributeDataUpdater class >> prefix [

	^ 'announcement-'
]

{ #category : #initialization }
CpAnnouncementAttributeDataUpdater >> initializeWithKey: keyString name: nameString [

	super initializeWithKey: keyString name: nameString.

	"Find the Announcement class for the receiver (see class comment of CpTemplateBasedDomUpdater for an explanation)."
	Announcement allSubclassesDo: [ :each |
		(each name withoutPrefix: #Cp) asKebabCase = name
			ifTrue: [
				announcementClass := each.
				^ self ] ].

	self warnCr: 'Unknown announcement class ', name
]

{ #category : #rendering }
CpAnnouncementAttributeDataUpdater >> renderData: anObject on: anElement [

	"It is assumed the data is a BlockClosure or understands #cull:"

	announcementClass ifNil: [ ^ self ].

	"Remove any previous subscription (when updating)"
	anElement unsubscribe: self.

	"Add a new subscription"
	(self valueFromData: anObject) ifNotNil: [ :block |
		anElement when: announcementClass do: block for: self ]
]
