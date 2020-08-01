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
	#category : #'CodeParadise-WebApplication-Core'
}

{ #category : #accessing }
CpWebClientBehavior class >> clientId [

	"Answer my identifier inside the ClientEnvironment"

	^ #client
]

{ #category : #initialization }
CpWebClientBehavior class >> createIn: aServerEnvironment [

	"Create an instance of the receiver in the specified ServerEnvironment"

	aServerEnvironment clientCreateInstanceOf: self withId: self clientId
]

{ #category : #accessing }
CpWebClientBehavior class >> eventHandlerClass [

	^ CpBaseEventHandler
]

{ #category : #initialization }
CpWebClientBehavior class >> installIn: aServerEnvironment [

	"Install the receiver in the specified ServerEnvironment"

	aServerEnvironment addClass: self
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

{ #category : #initialization }
CpWebClientBehavior >> initialize [

	"Add special event handler for Views"

	super initialize.

	self installBrowserEventHandler
]

{ #category : #initialization }
CpWebClientBehavior >> installBrowserEventHandler [

	"Install the event handler for the receiver"

	CpBrowserEventHandler current
		delegate: self class eventHandlerClass new
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
