Class {
	#name : #CpSecondaryClickEvent,
	#superclass : #CpAnyClickEvent,
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #testing }
CpSecondaryClickEvent class >> handlesClickEvent: aClickEvent [

	"Accept only secondary click"

	^ aClickEvent isSecondaryButtonPressed
]

{ #category : #initialization }
CpSecondaryClickEvent class >> postInstallOnce [

	CpHtmlElement document
		when: CpContextMenuEvent send: #preventDefault: to: CpHtmlElement document
]

{ #category : #testing }
CpSecondaryClickEvent >> isPrimaryButtonPressed [

	^ false
]

{ #category : #testing }
CpSecondaryClickEvent >> isSecondaryButtonPressed [

	^ true
]
