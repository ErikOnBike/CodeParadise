"
I am application Behavior to be performed inside a ClientEnvironment. I work for a WebApplication.
I only live in a ClientEnvironment.
"
Class {
	#name : 'CpWebClientBehavior',
	#superclass : 'Object',
	#category : 'CodeParadise-WebApplication-Core',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Core'
}

{ #category : 'accessing' }
CpWebClientBehavior class >> clientId [

	"Answer my identifier inside the ClientEnvironment"

	^ #client
]

{ #category : 'initialization' }
CpWebClientBehavior class >> createIn: aServerEnvironment [

	"Create an instance of the receiver in the specified ServerEnvironment"

	aServerEnvironment clientCreateInstanceOf: self withId: self clientId
]

{ #category : 'initialization' }
CpWebClientBehavior class >> installIn: aServerEnvironment [

	"Install the receiver in the specified ServerEnvironment"

	aServerEnvironment addClass: self
]

{ #category : 'updating' }
CpWebClientBehavior class >> updateStyleViewClass: aViewClass in: aServerEnvironment [

	"Update the style of the specified View in the ClientEnvironment belonging to the specified ServerEnvironment"

	aServerEnvironment sendMessage: (MessageSend
		receiver: self clientId
		selector: #updateStyleViewClass:
		arguments: { aViewClass name })

]

{ #category : 'updating' }
CpWebClientBehavior class >> updateTemplateViewClass: aViewClass in: aServerEnvironment [

	"Update the template of the specified View in the ClientEnvironment belonging to the specified ServerEnvironment"

	aServerEnvironment sendMessage: (MessageSend
		receiver: self clientId
		selector: #updateTemplateViewClass:
		arguments: { aViewClass name })

]

{ #category : 'accessing' }
CpWebClientBehavior >> clientEnvironment [

	^ CpClientEnvironment current
]

{ #category : 'actions' }
CpWebClientBehavior >> endSession [

	"End the client session"

	self clientEnvironment exit
]

{ #category : 'actions' }
CpWebClientBehavior >> removeLoader [

	"Remove the loader running in the HTML page starting this client"

	(CpHtmlElement elementWithId: 'loader-block')
		ifNotNil: [ :loaderBlock | loaderBlock remove ].
	(CpHtmlElement elementWithId: 'loader-style')
		ifNotNil: [ :loaderStyle | loaderStyle remove ]
]

{ #category : 'updating' }
CpWebClientBehavior >> updateStyleViewClass: viewClassName [

	"Update the style of the specified View"

	(self viewClassForName: viewClassName)
		updateStyle ;
		updateGlobalStyle
]

{ #category : 'updating' }
CpWebClientBehavior >> updateTemplateViewClass: viewClassName [

	"Update the template of the specified View"

	(self viewClassForName: viewClassName)
		updateTemplate
]

{ #category : 'support' }
CpWebClientBehavior >> viewClassForName: aSymbol [

	"Answer the View class matching the specified Symbol.

	Implementation:
	It is assumed that if a Class exists it is a View class."

	^ Smalltalk classNamed: aSymbol
]
