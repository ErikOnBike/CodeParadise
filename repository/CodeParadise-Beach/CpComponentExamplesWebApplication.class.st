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

{ #category : #actions }
CpComponentExamplesWebApplication >> clientShowIndex [

	"Show the index at the client (replacing default screen)"

	self sendMessage: (MessageSend
		receiver: self clientBehaviorClass clientId
		selector: #showIndex
		arguments: {})

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

{ #category : #actions }
CpComponentExamplesWebApplication >> load [

	super load.

	self clientShowIndex

]

{ #category : #actions }
CpComponentExamplesWebApplication >> reload [

	super reload.

	self clientShowIndex

]
