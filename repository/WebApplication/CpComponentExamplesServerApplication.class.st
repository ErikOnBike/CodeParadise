Class {
	#name : #CpComponentExamplesServerApplication,
	#superclass : #CpWebApplication,
	#category : #'WebApplication-Examples'
}

{ #category : #accessing }
CpComponentExamplesServerApplication class >> app [

	"Answer the unique identifier (a Symbol) for the receiver"

	^ #'Component-Examples'
]

{ #category : #accessing }
CpComponentExamplesServerApplication class >> clientBehaviorClass [

	^ CpComponentExamplesClientBehavior
]

{ #category : #installing }
CpComponentExamplesServerApplication >> installExtensionMethods [

	"Install the extension methods from known Classes"

	super installExtensionMethods.

	(Pragma allNamed: #webApplicationFontAwesomeExtension in: String) do: [ :each |
		self environment addMethod: each method ]
]
