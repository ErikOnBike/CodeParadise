Class {
	#name : #CpSecondaryClickEvent,
	#superclass : #CpAnyClickEvent,
	#classVars : [
		'ContextMenuSubscription',
		'PreventDefaultContextMenu'
	],
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #announcing }
CpSecondaryClickEvent class >> addListenerTo: anElement [

	PreventDefaultContextMenu = #lazy
		ifTrue: [ self preventDefaultContextMenu ].

	^ super addListenerTo: anElement
]

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

{ #category : #actions }
CpSecondaryClickEvent class >> lazyPreventDefaultContextMenu [

	"Prevent default handling of ContextMenu in the browser only if the receiver is added as listener to a DOM element.
	The default handling might iterfere with the receiver.
	If the handler is already installed, it will remain installed."

	PreventDefaultContextMenu = #on
		ifTrue: [ ^ self ].

	PreventDefaultContextMenu := #lazy
]

{ #category : #'class initialization' }
CpSecondaryClickEvent class >> postInstallOnce [

	"Prevent default handling of ContextMenu lazily, meaning it will be installed when the receiver
	is first added as listener to a DOM element. The context menu needs to be prevented, because it
	interferes with secondary click handling (showing a context menu).
	This behavior can be set using #preventDefaultContextMenu or reset using #resetDefaultContextMenu."

	self lazyPreventDefaultContextMenu
]

{ #category : #actions }
CpSecondaryClickEvent class >> preventDefaultContextMenu [

	"Prevent default handling of ContextMenu in the browser (might interfere with the receiver)"

	| documentBody |

	"Do not prevent the context menu if already on"
	PreventDefaultContextMenu = #on
		ifTrue: [ ^ self ].

	documentBody := CpHtmlElement documentBody.
	ContextMenuSubscription := documentBody when: CpContextMenuEvent send: #preventDefault: to: documentBody.

	PreventDefaultContextMenu := #on
]

{ #category : #actions }
CpSecondaryClickEvent class >> resetDefaultContextMenu [

	"Allow default handling of ContextMenu in the browser (might interfere with the receiver)"

	"Unsubscribe event listener"
	ContextMenuSubscription ifNotNil: [
		ContextMenuSubscription unsubscribe.
		ContextMenuSubscription := nil ].

	PreventDefaultContextMenu := #off
]

{ #category : #testing }
CpSecondaryClickEvent >> isPrimaryButtonPressed [

	^ false
]

{ #category : #testing }
CpSecondaryClickEvent >> isSecondaryButtonPressed [

	^ true
]
