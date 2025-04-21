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
CpWebApplication class >> allowedPackages [

	"Answer a collection of Packages which are allowed to contain classes to install in the receiver.

	Add packages with HTMLElement and CpBrowserWindow classes.

	See comment in superclass."

	^ super allowedPackages, { CpHtmlElement package . CpBrowserWindow package }
]

{ #category : #accessing }
CpWebApplication class >> app [

	"Answer the receiver unique name (used in URL to access the application as well)"

	^ (self nameWithoutPrefix withoutSuffix: #WebApplication) asKebabCase asSymbol
]

{ #category : #accessing }
CpWebApplication class >> clientBehaviorClass [

	"Answer the class representing the WebClientBehavior.
	By default the class with a matching name will be used (if present in the image).
	The matching name is created by replacing the postfix #WebApplication with #WebClientBehavior.
	Otherwise the default implementation as answered by #defaultClientBehaviorClass
	or a subclass should override this method to answer a specific class."

	| className clientBehaviorClass | 

	className := (self name withoutSuffix: #WebApplication) asSymbol , #WebClientBehavior.
	clientBehaviorClass := Smalltalk classNamed: className.

	"If no class is found, answer the default implementation"
	^ clientBehaviorClass
		ifNil: [ self defaultClientBehaviorClass ]
]

{ #category : #'event handling' }
CpWebApplication class >> clientLoaded: anAnnouncement [

	"Handle the client loaded event and remove the loader afterwards"

	(super clientLoaded: anAnnouncement)
		ifNotNil: [ :application | application removeLoader ]
]

{ #category : #accessing }
CpWebApplication class >> defaultClientBehaviorClass [

	"Answer the default class for the receiver's WebClientBehavior"

	^ CpWebClientBehavior
]

{ #category : #'class initialization' }
CpWebApplication class >> initialize [

	IdentifierGenerator := CpWebIdentifierGenerator new
]

{ #category : #tags }
CpWebApplication class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #testing }
CpWebApplication class >> isWebApplication [

	^ true
]

{ #category : #'development support' }
CpWebApplication class >> openInBrowser [

	<script>

	WebBrowser openOn: 'http://localhost:8080/static/app.html?' , self app
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
CpWebApplication >> addInstallationChecker [

	super addInstallationChecker.

	"Add an InstallationChecker for the browser environment"
	environment
		addInstallationChecker: CpEnvironmentMethodInstallationChecker browser
]

{ #category : #accessing }
CpWebApplication >> clientBehaviorClass [

	"Answer the class of the receiver's ClientBehavior"

	^ self class clientBehaviorClass
]

{ #category : #actions }
CpWebApplication >> clientEndSession [

	self sendMessage: (MessageSend
		receiver: self clientBehaviorClass clientId
		selector: #endSession)
]

{ #category : #actions }
CpWebApplication >> end [

	"End the receiver by asking the client to end the session.

	Ending the receiver will result in stopping the receiver.
	When done the client will announce it has ended.
	This in turn will perform server side cleanup.
	Therefore no need to perform any cleanup here."

	self clientEndSession
]

{ #category : #installing }
CpWebApplication >> extensionMethodCategories [

	"Answer the collection of extension method categories needed for the receiver"

	^ super extensionMethodCategories,
		#(webApplicationExtension)
]

{ #category : #actions }
CpWebApplication >> forceEnd [

	"End the receiver unconditionally first by asking the client to end the session,
	when the client does not respond in a timely fashion end the session server side.
	Letting the client end the session, will allow the user to be informed properly."

	[
		"Perform regular end behavior"
		self end.

		"Validate the received ended within 5 seconds"
		[
			(Delay forSeconds: 5) wait.

			"If not, end forcefully by faking a stop request"
			self isEnded
				ifFalse: [ environment fakeStop ] ] forkAt: Processor systemBackgroundPriority named: 'Stopping server environment'.
	] ifCurtailed: [

		"End forcefully in case of errors"
		self isEnded
			ifFalse: [ environment fakeStop ]
	]
]

{ #category : #testing }
CpWebApplication >> isEnded [

	"Answer whether the receiver ended (has become unusable)"

	^ environment isNil
]

{ #category : #actions }
CpWebApplication >> load [

	"Perform the initial loading of the receiver"

	super load.

	"Install the base HTMLElement class and Window proxy"
	self
		installClass: CpHtmlElement ;
		installClass: CpBrowserWindow.

	"Install the ClientBehavior"
	self clientBehaviorClass
		installIn: self environment ;
		createIn: self environment
]

{ #category : #updating }
CpWebApplication >> methodChanged: anAnnouncement [

	"Update the View if a resource method is updated.
	Answer a Boolean indicating whether the method is installed in the client.

	Implementation:
	Answer true is the super call answered true, since the method got installed.
	The method is only checked for presence of specific CSS or HTML pragmas.
	Since methods could call other methods, it is assumed the style or template
	of a CpTemplateComponent (subclass of CpWebComponent) is changed, whenever
	either a CSS or HTML tagged method is changed."

	| method pragma resourceType methodClass |

	(super methodChanged: anAnnouncement)
		ifFalse: [ ^ false ].

	method := anAnnouncement method.
	pragma := method pragmaAt: self class webResourcePragmaName.
	pragma ifNil: [ ^ true ].

	"Changes are only relevant for CpTemplateComponent or subclasses"
	methodClass := method methodClass instanceSide.
	(methodClass includesBehavior: CpTemplateComponent)
		ifFalse: [ ^ true ].

	resourceType := pragma argumentAt: 1.
	resourceType == self class webResourceCSS
		ifTrue: [
			methodClass withAllSubclassesDo: [ :c |
				(self environment clientKnowsClass: c)
					ifTrue: [ self updateStyleViewClass: c ] ].
			^ true ].
	resourceType == self class webResourceHTML
		ifTrue: [
			methodClass withAllSubclassesDo: [ :c |
				(self environment clientKnowsClass: c)
					ifTrue: [ self updateTemplateViewClass: c ] ].
			^ true ].

	^ true
]

{ #category : #actions }
CpWebApplication >> postReload [

	"Remove the loader after reload"

	super postReload.

	self removeLoader
]

{ #category : #actions }
CpWebApplication >> reload [

	"Perform reloading of the receiver"

	super reload.

	"Create an instance of the ClientBehavior in the ClientEnvironment
	(class is already installed during initial #load)"
	self clientBehaviorClass createIn: self environment
]

{ #category : #updating }
CpWebApplication >> removeLoader [

	"Remove the loader in the client"

	self sendMessage: (MessageSend
		receiver: self clientBehaviorClass clientId
		selector: #removeLoader)
]

{ #category : #'input/output' }
CpWebApplication >> sendMessage: aMessageSend [

	self environment sendMessage: aMessageSend
]

{ #category : #updating }
CpWebApplication >> updateStyleViewClass: aViewClass [

	self clientBehaviorClass updateStyleViewClass: aViewClass in: self environment
]

{ #category : #updating }
CpWebApplication >> updateTemplateViewClass: aViewClass [

	self clientBehaviorClass updateTemplateViewClass: aViewClass in: self environment
]
