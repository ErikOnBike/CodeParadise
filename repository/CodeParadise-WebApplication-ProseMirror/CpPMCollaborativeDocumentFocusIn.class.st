Class {
	#name : #CpPMCollaborativeDocumentFocusIn,
	#superclass : #Announcement,
	#instVars : [
		'selection'
	],
	#category : #'CodeParadise-WebApplication-ProseMirror-Announcements'
}

{ #category : #'instance creation' }
CpPMCollaborativeDocumentFocusIn class >> selection: aDictionary [

	^ self basicNew
		initializeWithSelection: aDictionary ;
		yourself
]

{ #category : #initialization }
CpPMCollaborativeDocumentFocusIn >> initializeWithSelection: aDictionary [

	self initialize.

	selection := aDictionary
]

{ #category : #accessing }
CpPMCollaborativeDocumentFocusIn >> selection [

	^ selection
]
