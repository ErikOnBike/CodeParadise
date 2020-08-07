Class {
	#name : #CpComponentExamplesWebApplication,
	#superclass : #CpMvpWebApplication,
	#category : #'CodeParadise-Beach-Examples'
}

{ #category : #accessing }
CpComponentExamplesWebApplication class >> app [

	"Answer the unique identifier (a Symbol) for the receiver"

	^ #'Component-Examples'
]

{ #category : #accessing }
CpComponentExamplesWebApplication class >> clientBehaviorClass [

	^ CpComponentExamplesClientBehavior
]

{ #category : #installing }
CpComponentExamplesWebApplication >> installExtensionMethods [

	"Install the extension methods from known Classes"

	super installExtensionMethods.

	(Pragma allNamed: #webApplicationFontAwesomeExtension in: String) do: [ :each |
		self environment addMethod: each method ].
	(Pragma allNamed: #webApplicationMaterialDesignExtension in: String) do: [ :each |
		self environment addMethod: each method ]
]
