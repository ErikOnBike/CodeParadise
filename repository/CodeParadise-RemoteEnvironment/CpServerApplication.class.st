"
I am a ServerApplication running in a RemoteEnvironment. I am responsible for delegating part of my behavior to a ClientEnvironment. I do not know my ClientEnvironment directly, but I know the ServerEnvironment which communicates with this ClientEnvironment. I have a unique application identifier. I get instantiated whenever a ClientEnvironment is loaded referring to my application identifier.

The ClientEnvironment can take on one of many roles by the behavior I install there. It can for example take on the role of a Worker performing tasks for me or can take on the role of a frontend User Interface or a system interface.

Implementation:
The fact that a ClientEnvironment is loaded is announced by the ServerEnvironment to my class side. The fact that the ClientEnvironment is reloaded or stopped is announced to the instance itself.

"
Class {
	#name : #CpServerApplication,
	#superclass : #Object,
	#instVars : [
		'environment',
		'clientVariables'
	],
	#classInstVars : [
		'announcementSubscription',
		'announcer'
	],
	#category : #'CodeParadise-RemoteEnvironment-Core'
}

{ #category : #accessing }
CpServerApplication class >> allowedPackages [

	"Answer a collection of Packages which are allowed to contain classes to install in the receiver.

	Implementation:
	By default only the application's package (i.e. `self package` below) and the package containing
	the client environment (for some default classes) are allowed.
	Please add specific packages in the subclass. This mechanism is introduced to prevent
	installing too many classes in a client environment by accident.

	A set is answered so no worries about adding packages twice.
	
	An easy way to reference packages is by asking well known classes for their package.
	Like `CpHtmlElement package` to use the WebApplication package. This way there is no problem
	if the package name changes."

	^ Set with: self package with: CpClientEnvironment package with: CpJavaScriptObject package
]

{ #category : #announcing }
CpServerApplication class >> announce: anAnnouncement [

	"Announce the specified Announcement (only if there are interested listeners,
	in which case the announcer is already instantiated)"

	announcer ifNil: [ ^ self ].

	announcer announce: anAnnouncement
]

{ #category : #accessing }
CpServerApplication class >> announcer [

	"Answer the announcer for this specific 'type' of application.
	This announcer can be used for live cycle announcements."

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
CpServerApplication class >> app [

	"Answer the unique identifier (a Symbol) for the receiver.
	A unique identifier is needed to route new sessions to the correct application."

	self subclassResponsibility
]

{ #category : #accessing }
CpServerApplication class >> applicationClassWithId: aSymbol [

	"Answer the class with the given app identifier or answer nil if none exists"

	self allSubclassesDo: [ :each |
		each app == aSymbol
			ifTrue: [ ^ each ] ].

	^ nil
]

{ #category : #support }
CpServerApplication class >> clientLoaded: anAnnouncement [

	"Create and answer a new instance of the receiver if the ClientEnvironment loaded
	matches the receiver's unqiue app identifier.
	If the receiver does not match, answer nil."

 	anAnnouncement app = self app
		ifFalse: [ ^ nil ].

	self validateClientVersion: (anAnnouncement variableAt: #CLIENT_VERSION).

	"Create new instance and call the load handler (faking the loaded event which triggered this invocation)"
	^ (self newInEnvironment: anAnnouncement environment) 
		clientVariables: anAnnouncement variables ;
		load: anAnnouncement ;
		yourself
]

{ #category : #testing }
CpServerApplication class >> hasAbstractTag [

	"Answer whether the receiver has the 'isAbstract' tag set"

	^ self classSide includesSelector: #isAbstractTag
]

{ #category : #tags }
CpServerApplication class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #testing }
CpServerApplication class >> isMvpWebApplication [

	^ false
]

{ #category : #testing }
CpServerApplication class >> isWebApplication [

	^ false
]

{ #category : #'instance creation' }
CpServerApplication class >> newInEnvironment: aServerEnvironment [

	"Create new instance of the receiver"

	^ self new
		environment: aServerEnvironment ;
		setUp ;
		yourself
]

{ #category : #support }
CpServerApplication class >> register [

	"Register the receiver by subscribing to the ClientLoaded Announcement of the CpServerEnvironment.
	When a new ClientEnvironment is started matching the receiver's app-identifier a new instance of
	the receiver is created which receives a newly assigned ServerEnvironment (for communicating with
	the ClientEnvironment)."

	self unregister.

	announcementSubscription := CpServerEnvironment whenClientLoadedSend: #clientLoaded: to: self
]

{ #category : #'class initialization' }
CpServerApplication class >> release [

	"Release any class side resource. Subclasses can override."

	self unregister
]

{ #category : #announcing }
CpServerApplication class >> removeSubscription: aSubscription [

	announcer ifNil: [ ^ aSubscription ].

	^ announcer removeSubscription: aSubscription
]

{ #category : #support }
CpServerApplication class >> unregister [

	"Unregister by unsubscribing from the CpServerEnvironment. See #register"

	announcementSubscription ifNil: [ ^ self ].

	CpServerEnvironment removeSubscription: announcementSubscription.
	announcementSubscription := nil
]

{ #category : #support }
CpServerApplication class >> validateClientVersion: aString [

	"Validate version match between Client and Server.
	Subclasses might override this behavior.

	Implementation:
	Currently a strict check is performed on the client version (a monotonic increasing counter)."

	aString = CpClientEnvironment version
		ifFalse: [ self error: 'Incompatible ClientEnvironment, please match CodeParadise and ClientEnvironment repos' ]
]

{ #category : #announcing }
CpServerApplication class >> whenLoadedSend: aSymbol to: anObject [

	^ self announcer
		when: CpApplicationLoaded
		send: aSymbol
		to: anObject
]

{ #category : #announcing }
CpServerApplication class >> whenReloadedSend: aSymbol to: anObject [

	^ self announcer
		when: CpApplicationReloaded
		send: aSymbol
		to: anObject
]

{ #category : #announcing }
CpServerApplication class >> whenStoppedSend: aSymbol to: anObject [

	^ self announcer
		when: CpApplicationStopped
		send: aSymbol
		to: anObject
]

{ #category : #installing }
CpServerApplication >> addInstallationChecker [

	"If the receiver should perform strict checking, add an InstallationChecker
	to the receiver's (server) environment. This checker is setup to check if
	only classes and methods from a known set of Packages are installed or if
	a method is a known extension method."

	self useStrictInstallationChecking
		ifFalse: [ ^ self ].

	"Add an InstallationChecker with the receiver's allowed Packages.
	And add the InstallationChecker for extension methods.
	The later is the 'slower' check, so it is performed if the Packages checker
	did not allow the installation (of Methods).
	Both InstallationCheckers receive the collection of allowed elements
	(Packages or extension method categories) to prevent the dynamic creation
	of these collections on each call to #isClassAllowed: or #isMethodAllowed:"
	environment
		addInstallationChecker: (CpApplicationPackageInstallationChecker applicationClass: self class) ;
		addInstallationChecker: (CpExtensionMethodInstallationChecker extensionMethodCategories: self extensionMethodCategories)
]

{ #category : #announcing }
CpServerApplication >> announceLoaded [

	self classSideAnnounce: (CpApplicationLoaded application: self)
]

{ #category : #announcing }
CpServerApplication >> announceReloaded [

	self classSideAnnounce: (CpApplicationReloaded application: self)
]

{ #category : #announcing }
CpServerApplication >> announceStopped [

	self classSideAnnounce: (CpApplicationStopped application: self)
]

{ #category : #announcing }
CpServerApplication >> classSideAnnounce: anAnnouncement [

	self class announce: anAnnouncement
]

{ #category : #accessing }
CpServerApplication >> clientVariableAt: aSymbol [ 

	^ clientVariables at: aSymbol ifAbsent: [ nil ]
]

{ #category : #accessing }
CpServerApplication >> clientVariables [ 

	^ clientVariables 
]

{ #category : #accessing }
CpServerApplication >> clientVariables: aDictionary [ 

	clientVariables := aDictionary
]

{ #category : #accessing }
CpServerApplication >> environment [

	"Answer the ServerEnvironment of the receiver"

	^ environment
]

{ #category : #accessing }
CpServerApplication >> environment: aServerEnvironment [

	"Set the ServerEnvironment of the receiver to the specified value and install an InstallationChecker"

	environment := aServerEnvironment.

	self addInstallationChecker
]

{ #category : #accessing }
CpServerApplication >> extensionMethodCategories [

	"Answer the collection of extension method categories needed for the receiver"

	^ #(applicationExtension)
]

{ #category : #installing }
CpServerApplication >> installClass: aClass [

	"Install the specified class in the receiver's environment"

	self environment
		addClass: aClass
]

{ #category : #installing }
CpServerApplication >> installExtensionMethods [

	"Install the extension methods from known Classes"

	self extensionMethodCategories do: [ :each |
		self installExtensionMethodsFor: each ]
]

{ #category : #installing }
CpServerApplication >> installExtensionMethodsFor: aSymbol [

	"Install the extension methods for specified (pragma) Symbol.

	Implementation:
	First find senders of specified Symbol and then explicitly check for
	pragma in both instance and class methods."

	((CpFinder allSendersOf: aSymbol) collect: [ :each | each methodClass ]) asSet
		do: [ :eachClass |

			"Install instance methods"
			(Pragma allNamed: aSymbol in: eachClass) do: [ :eachPragma |
				self installMethod: eachPragma method ].

			"Install class methods"
			(Pragma allNamed: aSymbol in: eachClass class) do: [ :eachPragma |
				self installMethod: eachPragma method ] ]
]

{ #category : #installing }
CpServerApplication >> installMethod: aCompiledMethod [

	"Install the specified method in the receiver's environment"

	self environment
		addMethod: aCompiledMethod
]

{ #category : #deprecated }
CpServerApplication >> installRequiredClass: aClass [

	"Install the specified class in the receiver's environment.
	This will also result in validating whether the required class
	is part of an allowed package (see class method #allowedPackages)"

	self flag: #deprecatedMethod.
	self warnCr: 'Deprecation: The method #installRequiredClass: is deprecated.'.
	self warnCr: 'Please use #installClass:'.
	self warnCr: 'IMPORTANT: Please also update your Application class to specify all #allowedPackages'.
	self warnCr: 'CodeParadise will check ALL classes and methods against this collection.'.
	self warnCr: 'Failing to set the appropriate allowed packages, may result in classes or methods not getting installed anymore.'.

	self installClass: aClass
]

{ #category : #actions }
CpServerApplication >> load [

	"Perform any actions needed when the ClientEnvironment belonging to the receiver loaded (for the first time)"

	"Install required extensions"
	self installExtensionMethods.

	"Install the extension method to convert a Block to a JavaScriptFunction. Because of circular dependencies
	this can't be done by defining that method as an extension method."
	self installMethod: BlockClosure >> #asJavaScriptFunction.

	"Install the JavaScriptObject proxy which allows a transparent use of JavaScript objects inside CodeParadise.
	And install the JavaScriptFunction proxy which allows Smalltalk Blocks to be used as JavaScript functions."
	self
		installClass: CpJavaScriptObject ;
		installClass: CpJavaScriptFunction
]

{ #category : #'private - actions' }
CpServerApplication >> load: anAnnoucement [

	"Perform any actions needed when the ClientEnvironment belonging to the receiver loaded (for the first time).

	Implementation:
	Because timing can sometimes be an issue, there are pre and post load messages."

	self
		preLoad ;
		load ;
		postLoad.

	self announceLoaded
]

{ #category : #updating }
CpServerApplication >> methodChanged: anAnnouncement [

	"Update any known methods in the ClientEnvironment, add new or remove old methods.
	Answer whether the method is added to/removed from the ClientEnvironment."

	| method |

	(self environment ifNil: [ ^ false ]) isRunning
		ifFalse: [ ^ false ].

	method := anAnnouncement method.
	method ifNil: [ ^ false ].

	^ anAnnouncement isMethodRemoved
		ifTrue: [ self environment removeMethod: method ]
		ifFalse: [ self environment updateMethod: method ]
]

{ #category : #actions }
CpServerApplication >> postLoad [

	"Perform any actions after the actual load"
]

{ #category : #actions }
CpServerApplication >> postReload [

	"Perform any actions after the actual reload"
]

{ #category : #actions }
CpServerApplication >> preLoad [

	"Perform any actions needed before the actual load"
]

{ #category : #actions }
CpServerApplication >> preReload [

	"Perform any actions needed before the actual reload"
]

{ #category : #'private - actions' }
CpServerApplication >> reconnect: anAnnouncement [

	"The client reconnected to the server, perform any required updates.
	The client might have been gone for a short or long time, actions
	might need to take this into account."
]

{ #category : #initialization }
CpServerApplication >> release [

	"Release the receiver's instance variables"

	environment ifNotNil: [
		environment release.
		environment := nil ].

	clientVariables := nil.

	super release
]

{ #category : #actions }
CpServerApplication >> reload [

	"Perform any actions needed when the ClientEnvironment belonging to the receiver reloaded"
]

{ #category : #'private - actions' }
CpServerApplication >> reload: anAnnouncement [

	"Client environment restarted. Update client variables and reload application."

	self clientVariables: anAnnouncement variables.

	self
		preReload ;
		reload ;
		postReload.

	self announceReloaded
]

{ #category : #initialization }
CpServerApplication >> setUp [

	"Setup the receiver to handle reload and stop events from client and handle code updates
	from the server. Subclasses can add behavior which needs to be executed before #load
	but after #initialize.

	Implementation: the client load event can't be caught here, since it already took place.
	It will be handled in CpServerApplication >> #clientLoaded"

	self environment
		when: CpClientReloaded send: #reload: to: self ;
		when: CpClientReconnected send: #reconnect: to: self ;
		when: CpClientStopped send: #stop: to: self.

	"Ensure the receiver reacts to methods being changed on the server"
	SystemAnnouncer uniqueInstance weak
		when: MethodAdded, MethodModified, MethodRemoved
		send: #methodChanged: to: self
]

{ #category : #actions }
CpServerApplication >> stop [

	"Perform any actions needed when the ClientEnvironment belonging to the receiver stopped.
	The receiver is unusable after being stopped. Subclasses wanting to add behavior should
	perform such behavior before calling 'super stop'."

	self release
]

{ #category : #'private - actions' }
CpServerApplication >> stop: anAnnouncement [

	"ClientEnvironment stopped. Stop receiver."

	self stop.

	self announceStopped
]

{ #category : #installing }
CpServerApplication >> useStrictInstallationChecking [

	"Answer a Boolean indicating whether strict checking should be performed
	on code being installed in the ClientEnvironment for the receiver.
	By default strict checking is on."

	^ true
]
