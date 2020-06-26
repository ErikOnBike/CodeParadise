"
I am application Behavior to be performed inside a ClientEnvironment. I work for a WebApplication and according to a Model-View-Presenter pattern.
I only live in a ClientEnvironment.
"
Class {
	#name : #CpWebClientBehavior,
	#superclass : #Object,
	#instVars : [
		'eventHandler'
	],
	#category : #'WebApplication-Core'
}

{ #category : #accessing }
CpWebClientBehavior class >> clientId [

	"Answer my identifier inside the ClientEnvironment"

	^ #client
]

{ #category : #accessing }
CpWebClientBehavior class >> cpRequiredClasses [

	^ super cpRequiredClasses, { CpViewEventHandler . CpModelProxy . CpPresenter }
]

{ #category : #creating }
CpWebClientBehavior class >> createPresenter: aPresenter in: aServerEnvironment [

	"Create a new Presenter in the ClientEnvironment belonging to the specified ServerEnvironment"

	aServerEnvironment
		addClass: aPresenter class ;

		clientPerform: #createPresenter:withId:
		withArguments: { aPresenter class name . aPresenter id }
		receiver: self clientId
]

{ #category : #initialization }
CpWebClientBehavior class >> postInstall [

	"Create an instance of the receiver after installation"

	super postInstall.

	CpClientEnvironment current createInstanceOf: self name withId: self clientId
]

{ #category : #updating }
CpWebClientBehavior class >> updateStyleViewClass: aViewClass in: aServerEnvironment [

	"Update the style of the specified View in the ClientEnvironment belonging to the specified ServerEnvironment"

	aServerEnvironment
		clientPerform: #updateStyleViewClass:
		withArguments: { aViewClass name }
		receiver: self clientId

]

{ #category : #updating }
CpWebClientBehavior class >> updateTemplateViewClass: aViewClass in: aServerEnvironment [

	"Update the template of the specified View in the ClientEnvironment belonging to the specified ServerEnvironment"

	aServerEnvironment
		clientPerform: #updateTemplateViewClass:
		withArguments: { aViewClass name }
		receiver: self clientId

]

{ #category : #creating }
CpWebClientBehavior >> createPresenter: aPresenterClass withId: identifier [

	"Create a new Presenter with the specified identifier (a String).
	The View for the Presenter is also created.
	A proxy is created for the Model (which lives in the ServerEnvironment)."

	| presenter |

	presenter := CpClientEnvironment current createInstanceOf: aPresenterClass withId: identifier.
	^ presenter
		id: identifier ;
		model: CpModelProxy new ;
		createView ;
		yourself
]

{ #category : #initialization }
CpWebClientBehavior >> initialize [

	"Add special event handler for Views"

	super initialize.

	CpBrowserEventHandler current
		delegate: CpViewEventHandler new
]

{ #category : #updating }
CpWebClientBehavior >> updateStyleViewClass: aViewClassName [

	"Update the style of the specified View"

	(Smalltalk classNamed: aViewClassName)
		updateStyle
]

{ #category : #updating }
CpWebClientBehavior >> updateTemplateViewClass: aViewClassName [

	"Update the template of the specified View"

	(Smalltalk classNamed: aViewClassName)
		updateTemplate
]
