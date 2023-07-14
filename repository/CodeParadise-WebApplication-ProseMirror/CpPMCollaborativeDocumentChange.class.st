Class {
	#name : #CpPMCollaborativeDocumentChange,
	#superclass : #Announcement,
	#instVars : [
		'steps',
		'selection',
		'version'
	],
	#category : #'CodeParadise-WebApplication-ProseMirror-Announcements'
}

{ #category : #'instance creation' }
CpPMCollaborativeDocumentChange class >> steps: aCollection selection: aDictionary version: anInteger [

	^ self basicNew
		initializeWithSteps: aCollection selection: aDictionary version: anInteger ;
		yourself
]

{ #category : #accessing }
CpPMCollaborativeDocumentChange >> content [

	^ nil
]

{ #category : #initialization }
CpPMCollaborativeDocumentChange >> initializeWithSteps: aCollection selection: aDictionary version: anInteger [

	self initialize.

	steps := aCollection.
	selection := aDictionary.
	version := anInteger
]

{ #category : #accessing }
CpPMCollaborativeDocumentChange >> selection [

	^ selection
]

{ #category : #accessing }
CpPMCollaborativeDocumentChange >> steps [

	^ steps
]

{ #category : #accessing }
CpPMCollaborativeDocumentChange >> version [

	^ version
]
