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

{ #category : #accessing }
CpMvpWebClientBehavior class >> eventHandlerClass [

	^ CpViewEventHandler
]

{ #category : #creating }
CpMvpWebClientBehavior >> createView: viewClassName withId: identifier atParentId: parentIdentifier [

	"Create a new View with the specified identifier (a String) and the specified
	parent (a String or nil if the view does not have a specific parent).
	The View to create is specified by its class name."

	| parentView view |

	"Find the parent View based on the specified identifier"
	parentView := parentIdentifier
		ifNotNil: [ CpHtmlElement elementWithId: parentIdentifier ]
		ifNil: [ CpHtmlElement documentBody ].

	"Create instance of the View class specified"
	view := parentView appendChild: ((self viewClassForName: viewClassName) new
		id: identifier ;	"Put id in view element for reference by the EventHandler"
		yourself).

	"Register the view instance in ClientEnvironment"
	CpClientEnvironment current objectRegistry
		registerObject: view
		withId: identifier.

	^ view
]
