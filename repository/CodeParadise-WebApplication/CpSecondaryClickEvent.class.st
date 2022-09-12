Class {
	#name : #CpSecondaryClickEvent,
	#superclass : #CpAnyClickEvent,
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #announcing }
CpSecondaryClickEvent class >> handlesClickEvent: aClickEvent [

	"Accept only secondary click"

	^ aClickEvent isSecondaryButtonPressed
]

{ #category : #initialization }
CpSecondaryClickEvent class >> postInstallOnce [

	CpHtmlElement document
		when: CpContextMenuEvent send: #preventContextMenu: to: self
]

{ #category : #'event handling' }
CpSecondaryClickEvent class >> preventContextMenu: aContextMenuEvent [

	aContextMenuEvent preventDefault
]

{ #category : #testing }
CpSecondaryClickEvent >> isPrimaryButtonPressed [

	^ false
]

{ #category : #testing }
CpSecondaryClickEvent >> isSecondaryButtonPressed [

	^ true
]
