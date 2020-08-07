"
I am a ServerApplication with Web-specific behavior. I work with WebComponents, meaning I know how to update their appearance (template and style).

"
Class {
	#name : #CpWebApplication,
	#superclass : #CpServerApplication,
	#classVars : [
		'IdentifierGenerator'
	],
	#category : #'CodeParadise-WebApplication-Core'
}

{ #category : #accessing }
CpWebApplication class >> clientBehaviorClass [

	^ CpWebClientBehavior
]

{ #category : #'class initialization' }
CpWebApplication class >> initialize [

	IdentifierGenerator := CpWebIdentifierGenerator new
]

{ #category : #accessing }
CpWebApplication class >> webResourceCSS [

	^ #css
]

{ #category : #accessing }
CpWebApplication class >> webResourceHTML [

	^ #html
]

{ #category : #accessing }
CpWebApplication class >> webResourcePragmaName [

	^ #webResource:
]

{ #category : #installing }
CpWebApplication >> installExtensionMethods [

	"Install the extension methods from known Classes"

	(Pragma allNamed: #webApplicationExtension in: String) do: [ :each |
		self environment addMethod: each method ]
]

{ #category : #actions }
CpWebApplication >> load [

	"Perform the initial loading of the receiver"

	super load.

	"Install required extensions"
	self installExtensionMethods.

	"Install an instance the ClientBehavior in the ClientEnvironment"
	self class clientBehaviorClass
		installIn: self environment ;
		createIn: self environment
]

{ #category : #updating }
CpWebApplication >> methodChanged: anAnnouncement [

	"Update the View if a resource method is uodated.
	Answer a Boolean indicating whether the method is installed in the client.
	Implementation: Answer true is the super call answered true, since the method got installed."

	| method pragma resourceType methodClass |

	(super methodChanged: anAnnouncement)
		ifFalse: [ ^ false ].

	method := anAnnouncement method.
	methodClass := method methodClass instanceSide.
	pragma := method pragmaAt: self class webResourcePragmaName.
	pragma ifNil: [ ^ true ].
	resourceType := pragma argumentAt: 1.
	resourceType == self class webResourceCSS
		ifTrue: [
			self updateStyleViewClass: methodClass.
			^ true ].
	resourceType == self class webResourceHTML
		ifTrue: [
			self updateTemplateViewClass: methodClass.
			^ true ].

	^ true
]

{ #category : #actions }
CpWebApplication >> reload [

	"Perform reloading of the receiver"

	super reload.

	"Create an instance of the ClientBehavior in the ClientEnvironment (class is already installed)"
	self class clientBehaviorClass createIn: self environment
]

{ #category : #actions }
CpWebApplication >> stop [

	"Stop the receiver by releasing it"

	self release
]

{ #category : #updating }
CpWebApplication >> updateStyleViewClass: aViewClass [

	self class clientBehaviorClass updateStyleViewClass: aViewClass in: self environment
]

{ #category : #updating }
CpWebApplication >> updateTemplateViewClass: aViewClass [

	self class clientBehaviorClass updateTemplateViewClass: aViewClass in: self environment
]
