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

	"Prevent default handling of ContextMenu (similar to secondary click)"

	| documentBody |

	(documentBody := CpHtmlElement documentBody)
		when: CpContextMenuEvent send: #preventDefault: to: documentBody
]

{ #category : #testing }
CpSecondaryClickEvent >> isPrimaryButtonPressed [

	^ false
]

{ #category : #testing }
CpSecondaryClickEvent >> isSecondaryButtonPressed [

	^ true
]
