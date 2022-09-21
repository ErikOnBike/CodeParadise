"
I am application Behavior to be performed inside a ClientEnvironment.
I work for a MvpWebApplication and according to a Model-View-Presenter pattern.
I only live in a ClientEnvironment.
"
Class {
	#name : #CpMvpWebClientBehavior,
	#superclass : #CpWebClientBehavior,
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #creating }
CpMvpWebClientBehavior >> createView: viewClassName withId: identifier atParentId: parentIdentifier atSlotNamed: slotName atIndex: anInteger [

	"Create a new View with the specified identifier (a String) and the specified
	parent (a String or nil if the view does not have a specific parent).
	If a slotName (aString or nil) is specified, the view is created at that slot in the parent.
	The index (anInteger) specifies the child number within the slot (multiple views can be
	present within a single slot).
	The View to create is specified by its class name."

	| parentView view |

	"Find the parent View based on the specified identifier"
	parentView := parentIdentifier
		ifNotNil: [ CpHtmlElement document elementWithId: parentIdentifier ]
		ifNil: [ CpHtmlElement documentBody ].

	"Create instance of the View class specified"
	view := (self viewClassForName: viewClassName) new
		id: identifier ;	"Put id in view element for reference by the EventHandler"
		yourself.

	"Add the view to its parent"
	slotName
		ifNotNil: [
			(anInteger > 0 and: [ (parentView childrenAtSlotNamed: slotName) size >= anInteger ])
				ifTrue: [ parentView replaceChildAtIndex: anInteger with: view atSlotNamed: slotName ]
				ifFalse: [ parentView appendChild: view atSlotNamed: slotName ] ]
		ifNil: [
			| nonSlottedChildren |
			nonSlottedChildren := parentView children reject: [ :each | each isSlotted ].
			(anInteger > 0 and: [ nonSlottedChildren size >= anInteger ])
				ifTrue: [ parentView replaceChild: (nonSlottedChildren at: anInteger) with: view ]
				ifFalse: [ parentView appendChild: view ] ].

	"Register the view instance in ClientEnvironment"
	self clientEnvironment objectRegistry
		registerObject: view
		withId: identifier.

	^ view
]
