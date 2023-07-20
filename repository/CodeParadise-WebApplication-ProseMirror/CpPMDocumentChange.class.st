Class {
	#name : #CpPMDocumentChange,
	#superclass : #CpCustomEvent,
	#category : #'CodeParadise-WebApplication-ProseMirror-Events'
}

{ #category : #converting }
CpPMDocumentChange >> asCollaborativeChangeAnnouncement [

	^ CpPMCollaborativeDocumentChange
		steps: self steps
		version: self version
		selection: self selection
]

{ #category : #private }
CpPMDocumentChange >> selection [

	^ self detail at: #selection
]

{ #category : #private }
CpPMDocumentChange >> steps [

	^ self detail at: #steps
]

{ #category : #private }
CpPMDocumentChange >> version [

	^ self detail at: #version
]
