Class {
	#name : #CpPMCollaborativeDocumentChange,
	#superclass : #Announcement,
	#instVars : [
		'content',
		'steps',
		'version',
		'selection'
	],
	#category : #'CodeParadise-WebApplication-ProseMirror-Announcements'
}

{ #category : #'instance creation' }
CpPMCollaborativeDocumentChange class >> steps: aCollection version: anInteger selection: aDictionary [

	^ self basicNew
		initializeWithSteps: aCollection selection: aDictionary version: anInteger ;
		yourself
]

{ #category : #accessing }
CpPMCollaborativeDocumentChange >> content [

	^ content
]

{ #category : #accessing }
CpPMCollaborativeDocumentChange >> content: aString [

	content := aString
]

{ #category : #testing }
CpPMCollaborativeDocumentChange >> hasContent [

	^ self content isNotNil
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
