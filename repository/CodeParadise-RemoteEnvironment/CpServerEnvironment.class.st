"
I am a Server Environment. I am part of a combo ClientEnvironment/ServerEnvironment which together represent a RemoteEnvironment for Smalltalk code execution. I send Classes and CompiledMethods (ie no source code) to the ClientEnvironment for installation there. I ask the ClientEnvironment to create instances of the Classes installed and I ask the ClientEnvironment to send messages to Classes or instances. To address instances of Classes I send an identifier (String) with my request to instantiate Classes. I receive the Announcements the ClientEnvironment sends back to me.

I create a new instance whenever a new ClientEnvironment makes a connection. There is currently no limit on the number of instances created (except for resource limitations of the system I am running on). Whenever a new instance is created and initial code is installed I let (my class side) Announcer announce that the instance is loaded. My instances will announce when they are reloaded or stopped.

The ClientEnvironment and I share an identifier (String).

Examples/usage:
Add Class to newly connected ClientEnvironments:
	[[[
		CpServerEnvironment announcer when: CpClientLoaded do: [ :clientLoaded |
			clientLoaded environment addClass: MyClientBehavior ]
	]]]

Instantiate a Class in the ClientEnvironment and let it perform behavior (#myBehavior and #myOtherBehavior: 42):
	[[[
		CpServerEnvironment announcer when: CpClientLoaded do: [ :clientLoaded |
			clientLoaded environment
				addClass: MyClientBehavior ;
				clientCreateInstanceOf: MyBehavior withId: #client ;
				clientPerform: #myBehavior receiver: #client ;
				clientPerform: #myOtherBehavior: withArguments: { 42 } receiver: #client ]
	]]]

See also CpServerApplication and subclasses for examples of installing behavior in a ClientEnvironment.
"
Class {
	#name : #CpServerEnvironment,
	#superclass : #CpEnvironment,
	#instVars : [
		'encoder',
		'encoderMutex',
		'installedClasses',
		'installedMethods',
		'installationMutex',
		'installationChecker',
		'announcer',
		'loaded'
	],
	#classVars : [
		'ClassSideAnnouncer'
	],
	#category : #'CodeParadise-RemoteEnvironment-Core'
}

{ #category : #announcing }
CpServerEnvironment class >> announce: anAnnouncement [

	"Let the receiver annouce the specified Announcement"

	self announcer announce: anAnnouncement
]

{ #category : #accessing }
CpServerEnvironment class >> announcer [

	"Answer the class side Announcer"

	^ ClassSideAnnouncer ifNil: [ ClassSideAnnouncer := Announcer new ]
]

{ #category : #accessing }
CpServerEnvironment class >> clientClass [

	^ CpClientEnvironment
]

{ #category : #accessing }
CpServerEnvironment class >> communicatorClass [

	^ CpServerCommunicator
]

{ #category : #'message encoding' }
CpServerEnvironment class >> encodedMessageForPerform: aSymbol withArguments: anArray receiver: identifier [

	"Answer an encoded message (a ByteArray) for performing method on the ClientEnvironment"

	^ (self messageForPerform: aSymbol withArguments: anArray receiver: identifier) cpEncoded
]

{ #category : #accessing }
CpServerEnvironment class >> invalidSessionMessage [

	^ self
		encodedMessageForPerform: #invalidSession
		withArguments: {}
		receiver: nil
]

{ #category : #'message encoding' }
CpServerEnvironment class >> messageForPerform: aSymbol withArguments: anArray receiver: identifier [

	"Answer a MessageSend for performing methods on the ClientEnvironment"

	^ MessageSend
		receiver: identifier
		selector: aSymbol
		arguments: anArray

]

{ #category : #'instance creation' }
CpServerEnvironment class >> newWithId: id [

	"Create new instance of the receiver with the specified identifier"

	^ self new
		id: id ;
		yourself
]

{ #category : #announcing }
CpServerEnvironment class >> removeSubscription: aSubscription [

	^ self announcer removeSubscription: aSubscription
]

{ #category : #announcing }
CpServerEnvironment class >> resetAnnouncer [

	<script>

	"Reset the class side announcer to prevent keeping references to registered applications"

	ClassSideAnnouncer ifNotNil: [
		ClassSideAnnouncer subscriptions reset.
		ClassSideAnnouncer := nil ]
]

{ #category : #announcing }
CpServerEnvironment class >> unsubscribe: anObject [

	^ self announcer
		unsubscribe: anObject
]

{ #category : #announcing }
CpServerEnvironment class >> whenClientLoadedSend: aSymbol to: anObject [

	^ self announcer
		when: CpClientLoaded
		send: aSymbol
		to: anObject
]

{ #category : #'adding/removing' }
CpServerEnvironment >> addClass: aClass [

	"Add the specified Class to the client environment of the receiver and answer it.
	If an installation checker is present a check is performed if the class is allowed.

	Implementation:
	Since the Class can depend on other classes a collection of Classes might need to be
	installed. This collection requires an order. For example to prevent the installation
	of a subclass before its superclass."

	"Validate the class has no breakpoints (which will currently fail in the client)"
	aClass containsDebuggingCode
		ifTrue: [ self error: 'It is not allowed to have debugging code (breakpoints) in client code' ].

	installationMutex critical: [

		"Select all the required classes in 'dependency order' (which are not already installed)"
		self allReferencedClassesFromClass: aClass do: [ :each |

			"If an installation checker is installed it will check if the class
			is allowed. An error is raised here if it is not.
			Typically the Application is the installation checker for the receiver.
			As a failsafe, only classes defined in a package in the collection of
			allowed application packages are allowed. This is to prevent accidental
			installation of Classes which (indirectly) refer to more classes and then
			resulting in trying to install the full Pharo IDE in a tiny image (which
			will fail with a crash). If the following error occurs, please check if
			the application's #allowedPackages method contains all packages allowed."
			installationChecker ifNotNil: [
				(installationChecker isClassAllowed: each)
					ifFalse: [ self error: 'Trying to install ', each name, ' from ', each package name, ' which is not allowed by the installation checker' ] ].

			"Remember which Classes are installed (in order) for reloading"
			self installedClasses add: each.

			"Install in ClientEnvironment"
			self installClass: each ].

		"Perform the post installation on all the installed (possibly inter dependent) classes"
		self postInstallClasses.

		^ aClass ]
]

{ #category : #accessing }
CpServerEnvironment >> addInstallationChecker: anInstallationChecker [

	"Add the installation checker to the receiver"

	installationChecker := installationChecker
		ifNotNil: [ anInstallationChecker chainTo: installationChecker ]
		ifNil: [ anInstallationChecker ]
]

{ #category : #'adding/removing' }
CpServerEnvironment >> addMethod: aCompiledMethod [

	"Add the specified CompiledMethod to the client environment of the receiver and answer it.
	If the CompiledMethod is marked server side only, it will not be installed."

	| methodElement |

	aCompiledMethod isServerSideOnly
		ifTrue: [ ^ aCompiledMethod ].

	installationMutex critical: [

		"Check the CompiledMethod may be installed"
		installationChecker ifNotNil: [
			(installationChecker isMethodAllowed: aCompiledMethod)
				ifFalse: [ self error: ('Trying to install {1} from {2} which is not allowed by the installation checker' format: { aCompiledMethod . aCompiledMethod package name }) ] ].

		"Keep CompiledMethod for re-installation on reload"
		(self hasInstalledClass: aCompiledMethod methodClass instanceSide)
			ifFalse: [

				"Only methods which are not part of installed classes need to be remembered.
				Others will be installed anyway on reload/restart."
				methodElement := Association key: aCompiledMethod methodClass value: aCompiledMethod selector.
				(installedMethods includes: methodElement)
					ifFalse: [ installedMethods add: methodElement ] ].

		"Install the method"
		self installMethod: aCompiledMethod.

		"Install Classes that are referenced from the method"
		self referencedClassesFromMethod: aCompiledMethod do: [ :each | self addClass: each ].

		^ aCompiledMethod ]
]

{ #category : #'installing - support' }
CpServerEnvironment >> allReferencedClassesFromClass: aClass do: aBlock [

	"Evaluate the specified Block for the specified Class and all Classes it dependents on.
	Process the class hierarchy first and then the referenced Classes."

	| processing |

	processing := OrderedCollection new.

	"Process the Class and its required classes (superclasses and the ones needed for initialization)"
	self withAllRequiredClassesFromClass: aClass do: [ :each |
		aBlock value: each.
		processing add: each ].

	"Process the dependent Classes from the Class and its superclasses"
	processing do: [ :each |
		self referencedClassesFromClass: each do: [ :eachDependent |
			self allReferencedClassesFromClass: eachDependent do: aBlock ] ]
]

{ #category : #announcing }
CpServerEnvironment >> announce: anAnnouncement [

	"Let the receiver announce the specified Announcement"

	[ self announcer announce: anAnnouncement ] on: Error do: [ :error |

		"Add 'location' of the error, by appending the Announcement description"
		error messageText: (String streamContents: [ :stream |
			stream
				nextPutAll: error messageText ;
				nextPutAll: ' (occurred while handling the Announcement: ' ;
				print: anAnnouncement ;
				nextPut: $) ]).
		self handleError: error ]
]

{ #category : #accessing }
CpServerEnvironment >> announcer [

	^ announcer
]

{ #category : #accessing }
CpServerEnvironment >> beLoaded [

	loaded := true
]

{ #category : #'remote execution' }
CpServerEnvironment >> clientAssignId [

	"Assign the receiver's id to the client environment.

	Implementation:
	Setting the receiver to nil indicates the ClientEnvironment as receiver."

	self sendMessage: (MessageSend
		receiver: nil
		selector: #id:
		arguments: { self id })
]

{ #category : #'remote execution' }
CpServerEnvironment >> clientCreateInstanceOf: aClass withId: identifier [

	"Let the ClientEnvironment create an instance of the specified class with the specified identifier.

	Implementation:
	Setting the receiver to nil indicates the ClientEnvironment as receiver."

	self sendMessage: (MessageSend
		receiver: nil
		selector: #createInstanceOf:withId:
		arguments: { aClass name . identifier })

]

{ #category : #testing }
CpServerEnvironment >> clientKnowsClass: aClass [

	"Answer whether the specified Class is known by the receiver's client environment.
	This is when the Class is installed by the receiver or is pre-installed in the ClientEnvironment."

	^ (self hasInstalledClass: aClass) or: [ self class clientClass hasPreInstalledClass: aClass ]
]

{ #category : #'remote execution' }
CpServerEnvironment >> clientPerform: aSymbol [

	"Send message to client to perform the specified selector on the client environment.

	Implementation:
	Setting the receiver to nil indicates the ClientEnvironment as receiver."

	self sendMessage: (MessageSend
		receiver: nil
		selector: aSymbol)
]

{ #category : #'input/output' }
CpServerEnvironment >> flushSendMessages [

	"Send any pending messages"

	encoder ifNil: [ ^ self ].

	"Only send non-empty messages"
	[ encoder bytes ifNotEmpty: [ :message | self sendEncodedMessage: message ] ] ensure: [ encoder := nil ]
]

{ #category : #'event handling' }
CpServerEnvironment >> handleClientAnnouncement: anAnnouncement [

	"Handle the specified Announcement received from the client"

	encoderMutex critical: [

		"Create encoder to aggregate all messages sent to client during the handling
		of the Announcement"
		encoder := CpObjectEncoder new.

		"Handle the received announcement by re-announcing it"
		[ self announce: anAnnouncement.

		"Send the aggregated messages to the client"
		self flushSendMessages ] ensure: [ encoder := nil ] ]
]

{ #category : #'event handling' }
CpServerEnvironment >> handleMessageReceived: aByteArray [

	"Handle the message received from the client.
	The message is assumed to be holding encoded Announcement instances.
	Let the receiver handle the Announcements."

	| decoder |

	decoder := CpObjectDecoder on: aByteArray.
	decoder cacheString: self id.

	[ decoder hasMoreData ] whileTrue: [
		self handleClientAnnouncement: decoder decodeNext ]
]

{ #category : #testing }
CpServerEnvironment >> hasAnnouncer: anAnnouncer [

	^ announcer
		ifNotNil: [ announcer == anAnnouncer ]
		ifNil: [ false ]
]

{ #category : #testing }
CpServerEnvironment >> hasInstallationChecker [

	^ installationChecker isNotNil
]

{ #category : #testing }
CpServerEnvironment >> hasInstalledClass: aClass [

	"Answer whether the specified Class is installed in the client environment through the receiver"

	"Safety check"
	self installedClasses ifNil: [ ^false ].

	^ self installedClasses includes: aClass
]

{ #category : #initialization }
CpServerEnvironment >> initialize [

	"Initialize the receiver with empty installation Collections and new Mutexes"

	super initialize.

	encoderMutex := Mutex new.
	installedClasses := OrderedCollection new.
	installedMethods := OrderedCollection new.
	installationMutex := Mutex new.
	loaded := false.
	announcer := Announcer new.

	"Add subscription to reinstall already registered code in the client environment if restarted"
	self
		when: CpClientStarted send: #started: to: self ;
		when: CpClientStopped send: #stop to: self
]

{ #category : #installing }
CpServerEnvironment >> installClass: aClass [

	"Install the specified Class in the client environment.
	To have the Class being reinstalled on reload, use #addClass:.

	Implementation:
	Setting the receiver to nil indicates the ClientEnvironment as receiver."

	self sendMessage: (MessageSend
		receiver: nil
		selector: #installClass:
		arguments: { self partialClassForClass: aClass })
]

{ #category : #installing }
CpServerEnvironment >> installMethod: aCompiledMethod [

	"Install the specified CompiledMethod in the client environment.
	To have the CompiledMethod being reinstalled on reload, use #addMethod:.

	Implementation:
	Setting the receiver to nil indicates the ClientEnvironment as receiver."

	self sendMessage: (MessageSend
		receiver: nil
		selector: #installMethod:
		arguments: { aCompiledMethod })
]

{ #category : #installing }
CpServerEnvironment >> installRegisteredCode [

	"Install the already registered CompiledMethods and Classes in the client environment.
	This is normally only done at reload."

	installationMutex critical: [

		| classes |

		"First install the methods, which might add base feature to the image"
		self installedMethods do: [ :eachMethodElement |
			self installMethod: (eachMethodElement key) >> (eachMethodElement value) ].

		"Install classes by re-adding them. Additional dependencies will be installed
		this way. Such dependencies might arise when methods are changed. Although
		these dependencies are added when the method is installed, the order of installation
		might be wrong on reload."
		classes := installedClasses.
		installedClasses := OrderedCollection new.
		classes do: [ :each | self addClass: each ] ]
]

{ #category : #accessing }
CpServerEnvironment >> installedClasses [

	^ installedClasses
]

{ #category : #accessing }
CpServerEnvironment >> installedMethods [

	^ installedMethods
]

{ #category : #testing }
CpServerEnvironment >> isLoaded [

	^ loaded
]

{ #category : #'installing - support' }
CpServerEnvironment >> partialClassForClass: aClass [

	"Answer the PartialClass representing the specified Class
	with only the allowed methods for installation.

	For example regular extension methods will not be installed
	if the Package they are defined in is not set as an allowed
	Package in the Application."

	| partialClass |

	partialClass := CpPartialClass on: aClass.

	"Instance methods"
	aClass instanceSide methodDictionary keysAndValuesDo: [ :selector :compiledMethod |
		(installationChecker isNil or: [ installationChecker isMethodAllowed: compiledMethod ])
			ifTrue: [ partialClass addInstSelector: selector ] ].

	"Class methods"
	aClass classSide methodDictionary keysAndValuesDo: [ :selector :compiledMethod |
		(installationChecker isNil or: [ installationChecker isMethodAllowed: compiledMethod ])
			ifTrue: [ partialClass addClassSelector: selector ] ].

	^ partialClass
]

{ #category : #installing }
CpServerEnvironment >> postInstallClasses [

	"Perform the post install of the classes installed in the client environment.

	Implementation:
	The classes can have inter dependencies, therefore perform this method only
	after a class is added using #addClass:. After #addClass: any dependencies will
	have been sent to the client. The post installation can then be done on all
	these inter dependent classes."

	self sendMessage: (MessageSend
		receiver: nil
		selector: #postInstallClasses)
]

{ #category : #'installing - support' }
CpServerEnvironment >> referencedClassesFromClass: aClass do: aBlock [

	"Perform the specified Block on the referenced Classes from the specified Class"

	"Handle classes referenced in class and instance methods"
	self referencedClassesFromMethods: aClass classSide methods do: aBlock.
	self referencedClassesFromMethods: aClass instanceSide methods do: aBlock
]

{ #category : #'installing - support' }
CpServerEnvironment >> referencedClassesFromClassMethod: aSymbol in: aClass do: aBlock [

	"Evaluate the specified Block for the specified method.
	Ignore if such a method does not exist in the specified Class."

	aClass classSide
		compiledMethodAt: aSymbol ifPresent: [ :compiledMethod |
			self referencedClassesFromMethod: compiledMethod do: aBlock ]
]

{ #category : #'installing - support' }
CpServerEnvironment >> referencedClassesFromClassMethods: aCollection in: aClass do: aBlock [

	"Evaluate the specified Block for the specified methods.
	Ignore any methods that do not exist on the specified Class."

	aCollection do: [ :each |
		self referencedClassesFromClassMethod: each in: aClass do: aBlock ]
]

{ #category : #'installing - support' }
CpServerEnvironment >> referencedClassesFromMethod: aCompiledMethod do: aBlock [

	"Evaluate the specified Block for the specified CompiledMethod.
	If an InstallationChecker is present, only allowed methods will be handled.
	This is to prevent installation of a Class which is referenced for another
	environment or another purpose."

	"Check if the method is allowed, before handling the referenced classes"
	(installationChecker isNil or: [ installationChecker isMethodAllowed: aCompiledMethod ])
		ifFalse: [ ^ self ].

	"Handle all referenced Classes"
	aCompiledMethod referencedClasses do: [ :each |

		"Check if the referenced Class should be ignored"
		(aCompiledMethod shouldIgnoreReference: each)
			ifFalse: [ aBlock value: each ] ]
]

{ #category : #'installing - support' }
CpServerEnvironment >> referencedClassesFromMethods: aCollection do: aBlock [

	"Evaluate the specified Block for all classes which are referenced
	in the specified Collection of CompiledMethods"

	aCollection do: [ :each |
		self referencedClassesFromMethod: each do: aBlock ]
]

{ #category : #initialization }
CpServerEnvironment >> release [

	"Release the receiver's instance variables"

	announcer ifNotNil: [
		announcer subscriptions reset.
		announcer := nil ].
	loaded := nil.
	encoder := nil.
	encoderMutex := nil.
	installedClasses := nil.
	installedMethods := nil.
	installationMutex := nil.
	installationChecker := nil.

	super release
]

{ #category : #installing }
CpServerEnvironment >> removeMethod: aCompiledMethod [

	"Remove the specified CompiledMethod if it's a known method.
	Answer whether the method is removed."

	| methodElement removed |

	removed := false.

	installationMutex critical: [

		(self hasInstalledClass: aCompiledMethod methodClass instanceSide)
			ifTrue: [ removed := true ] "Will remove the method below"
			ifFalse: [

				"Only methods which are not part of installed classes need to be remembered.
				Others will be installed based on the class definition during reload/restart.
				Prevent this method from being remembered as needing installation."
				methodElement := Association key: aCompiledMethod methodClass value: aCompiledMethod selector.
				(installedMethods includes: methodElement)
					ifTrue: [
						installedMethods remove: methodElement.
						removed := true ] ].

		"Remove the method"
		removed
			ifTrue: [ self uninstallMethod: aCompiledMethod ].

		^ removed ]
]

{ #category : #announcing }
CpServerEnvironment >> removeSubscription: aSubscription [

	"Remove the specified subscription from the receiver"

	^ self announcer removeSubscription: aSubscription
]

{ #category : #'input/output' }
CpServerEnvironment >> sendMessage: aMessageSend [

	"Send the specified MessageSend to the server"

	"Either add message to existing encoder or encode message and send it directly"
	encoderMutex critical: [
		encoder
			ifNotNil: [ encoder encode: aMessageSend ]
			ifNil: [ self sendMessageDirectly: aMessageSend ] ]
]

{ #category : #'input/output' }
CpServerEnvironment >> sendMessageDirectly: aMessageSend [

	"Send the specified MessageSend to the server (without waiting)"

	self sendEncodedMessage: aMessageSend cpEncoded
]

{ #category : #support }
CpServerEnvironment >> started: anAnnouncement [

	"The ClientEnvironment belonging to the receiver (re)started.
	Install the Classes and CompiledMethods already registered with the receiver.
	Let interested parties know about the ClientEnvironment (re)loaded."

	| announcementClass loadedAnnouncer |

	"Assign client id on first time"
	self isLoaded
		ifFalse: [ self clientAssignId ].

	self installRegisteredCode.

	"On first time started announce Loaded, for restarts afterwards announce Reloaded.
	Loading is announced by the class side Announcer since interested parties do not
	know about the receiver's existance yet and can therefore not subscribe to it."
	self isLoaded
		ifFalse: [
			announcementClass := CpClientLoaded.
			loadedAnnouncer := self class announcer ]
		ifTrue: [
			announcementClass := CpClientReloaded.
			loadedAnnouncer := self announcer ].

	self beLoaded.

	loadedAnnouncer announce: (announcementClass variables: anAnnouncement variables environment: self)
]

{ #category : #support }
CpServerEnvironment >> stop [

	"Stop the receiver. The receiver is unusable after being stopped."

	self
		flushSendMessages ;
		stopCommunication ;
		release
]

{ #category : #installing }
CpServerEnvironment >> uninstallMethod: aCompiledMethod [

	"Remove the specified CompiledMethod in the client environment.

	Implementation:
	Setting the receiver to nil indicates the ClientEnvironment as receiver."

	self sendMessage: (MessageSend
		receiver: nil
		selector: #removeMethod:
		arguments: { aCompiledMethod })
]

{ #category : #announcing }
CpServerEnvironment >> unsubscribe: anObject [

	"Unsubscribe the specified Object from Announcements of the receiver"

	^ self announcer unsubscribe: anObject
]

{ #category : #updating }
CpServerEnvironment >> updateCommunicatorWith: aMessageChannel [

	"Replace the receiver's Communicator MessageChannel with a new one
	(this can happen in case a connection is reset or a session is resumed)."

	self hasCommunicator
		ifFalse: [ self communicator: self createCommunicator ].

	self communicator messageChannel: aMessageChannel
]

{ #category : #installing }
CpServerEnvironment >> updateMethod: aCompiledMethod [

	"Update the specified CompiledMethod if it's a known method.
	Answer whether the method is updated."

	| methodClass |

	methodClass := aCompiledMethod methodClass instanceSide.
	(self clientKnowsClass: methodClass)
		ifFalse: [ ^ false ].

	"Check if the method is allowed"
	(installationChecker isNil or: [ installationChecker isMethodAllowed: aCompiledMethod ])
		ifFalse: [ ^ false ].

	self addMethod: aCompiledMethod.
	^ true
]

{ #category : #accessing }
CpServerEnvironment >> variableAt: nameString [

	"Answer the value (a String) of the environment variable with the specified name
	or nil if a variable with the specified name does not exist.
	Case sensitivity is not defined, for compatibility best use all uppercase names."

	^ OSEnvironment current
		at: #nameString ifAbsent: [ nil ]
]

{ #category : #accessing }
CpServerEnvironment >> variableNames [

	"Answer an array with the names of available environment variables."

	^ OSEnvironment current keys
]

{ #category : #deprecated }
CpServerEnvironment >> when: anAnnouncementClass do: aBlock [

	self flag: #deprecatedMethod.
	self warnCr: 'Use of any Announcer''s #when:do: is deprecated, please use #when:do:for:'.

	^ self when: anAnnouncementClass do: aBlock for: aBlock receiver
]

{ #category : #announcing }
CpServerEnvironment >> when: anAnnouncementClass do: aBlock for: anObject [

	"Subscribe anObject to announcements of anAnnouncementClass class. 
	 When announced, aBlock is evaluated."

	^ self announcer
		when: anAnnouncementClass do: aBlock for: anObject
]

{ #category : #announcing }
CpServerEnvironment >> when: anAnnouncementClass send: aSymbol to: anObject [

	"Let the sender subscribe to the specified announcement of the receiver.
	See Announcer>>#when:send:to:"

	^ self announcer when: anAnnouncementClass send: aSymbol to: anObject
]

{ #category : #'installing - support' }
CpServerEnvironment >> withAllRequiredClassesFromClass: aClass do: aBlock [

	"Evaluate the specified Block for the specified Class, its superclasses
	and the classes required for initialization.

	Implementation:
	The classes referenced in the class side methods #beLoaded, #postInstall
	and #postInstallOnce are considered required classes. These need to be
	present/installed before the specified Class is installed."

	"Validate the class is not obsolete. Sometimes during class updates, including Iceberg operations,
	a class can become obsolete. When a debugger in the CodeParadise class loader code is triggered
	during a class update, it might leave such a class obsolete. Installing an obsolete class is of
	course useless."
	aClass isObsolete
		ifTrue: [ self error: ('Obsolete class {1} is referenced, please manually remove references. Application(s) might have become unstable.' format: { aClass name }) ].

	"Only add unknown Classes (i.e. Classes which are not already present in the default tiny image or have been installed)"
	(self clientKnowsClass: aClass)
		ifTrue: [ ^ self ].

	"First, handle the classes required for initialization"
	self
		referencedClassesFromClassMethods: #(beLoaded postInstall postInstallOnce)
		in: aClass
		do: [ :eachClass | self withAllRequiredClassesFromClass: eachClass do: aBlock ].

	"Secondly, handle the superclasses"
	self withAllRequiredClassesFromClass: aClass superclass do: aBlock.

	"Finally, handle the class itself"
	aBlock value: aClass
]
