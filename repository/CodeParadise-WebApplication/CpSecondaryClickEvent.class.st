Class {
	#name : #CpSecondaryClickEvent,
	#superclass : #CpAnyClickEvent,
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #initialization }
CpSecondaryClickEvent class >> beLoaded [

	"Make sure the ContextMenu event is a required (pre-installed) class,
	otherwise the #postInstallOnce will not work correctly"

	CpContextMenuEvent beLoaded
]

{ #category : #testing }
CpSecondaryClickEvent class >> handlesClickEvent: aClickEvent [

	"Accept only secondary click"

	^ aClickEvent isSecondaryButtonPressed
]

{ #category : #'class initialization' }
CpSecondaryClickEvent class >> postInstallOnce [

	"Prevent default handling of ContextMenu by default (because it interferes with secondary click).
	This behavior can be reset using #resetDefaultContextMenu"

	self preventDefaultContextMenu
]

{ #category : #actions }
CpSecondaryClickEvent class >> preventDefaultContextMenu [

	"Prevent default handling of ContextMenu by default (because it can interfere with secondary click)"

	| documentBody |

	self resetDefaultContextMenu.

	documentBody := CpHtmlElement documentBody.

	Smalltalk at: #PreventDefaultContextMenu put: (documentBody
		when: CpContextMenuEvent send: #preventDefault: to: documentBody)
]

{ #category : #actions }
CpSecondaryClickEvent class >> resetDefaultContextMenu [

	"Reset the default handling of ContextMenu"

	| subscription |

	subscription := (Smalltalk at: #PreventDefaultContextMenu)
		ifNil: [ ^ self ].

	"Unsubscribe event listener"
	subscription unsubscribe.

	"Reset the global value"
	Smalltalk at: #PreventDefaultContextMenu put: nil
]

{ #category : #testing }
CpSecondaryClickEvent >> isPrimaryButtonPressed [

	^ false
]

{ #category : #testing }
CpSecondaryClickEvent >> isSecondaryButtonPressed [

	^ true
]
