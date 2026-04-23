"
I am a ServerApplication with (Web) Worker-specific behavior.
"
Class {
	#name : #CpWorkerApplication,
	#superclass : #CpServerApplication,
	#category : #'CodeParadise-WebApplication-Core'
}

{ #category : #accessing }
CpWorkerApplication class >> allowedPackages [

	"Answer a collection of Packages which are allowed to contain classes to install in the receiver.

	Add packages with CpWorkerBehavior and with CpBrowserWorker class (this package also contains other Browser related classes).

	See comment in superclass."

	^ super allowedPackages, { CpWorkerBehavior package . CpBrowserWorker package }
]

{ #category : #accessing }
CpWorkerApplication class >> app [

	"Answer the receiver unique name (used in URL to access the application as well).
	In contrast with WebApplications, WorkerApplications have a fixed prefix: worker-"

	^ ('worker-', ((self nameWithoutPrefix withoutSuffix: #WorkerApplication) asKebabCase)) asSymbol
]

{ #category : #accessing }
CpWorkerApplication class >> defaultWorkerBehaviorClass [

	"Answer the default class for the receiver's WebClientBehavior"

	^ CpWorkerBehavior
]

{ #category : #tags }
CpWorkerApplication class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #accessing }
CpWorkerApplication class >> workerBehaviorClass [

	"Answer the class representing the WorkerBehavior.
	By default the class with a matching name will be used (if present in the image).
	The matching name is created by replacing the postfix #WorkerApplication with #WorkerBehavior.
	Otherwise the default implementation as answered by #defaultWorkerBehaviorClass
	or a subclass should override this method to answer a specific class."

	| className workerBehaviorClass | 

	className := (self name withoutSuffix: #WorkerApplication) asSymbol , #WorkerBehavior.
	workerBehaviorClass := Smalltalk classNamed: className.

	"If no class is found, answer the default implementation"
	^ workerBehaviorClass
		ifNil: [ self defaultWorkerBehaviorClass ]
]

{ #category : #installing }
CpWorkerApplication >> addInstallationChecker [

	super addInstallationChecker.

	"Add an InstallationChecker for the Worker environment"
	environment
		addInstallationChecker: CpEnvironmentMethodInstallationChecker worker
]

{ #category : #accessing }
CpWorkerApplication >> end [

	"End the receiver by asking the Worker to end the session.

	Ending the receiver will result in stopping the receiver.
	When done the Worker will announce it has ended.
	This in turn will perform server side cleanup.
	Therefore no need to perform any cleanup here."

	self workerEndSession
]

{ #category : #accessing }
CpWorkerApplication >> extensionMethodCategories [

	"Answer the collection of extension method categories needed for the receiver"

	^ super extensionMethodCategories,
		#(workerApplicationExtension)
]

{ #category : #actions }
CpWorkerApplication >> forceEnd [

	"End the receiver unconditionally first by asking the Worker to end the session,
	when the Worker does not respond in a timely fashion end the session server side.
	Letting the Worker end the session, will allow the user to be informed properly."

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
CpWorkerApplication >> isEnded [

	"Answer whether the receiver ended (has become unusable)"

	^ environment isNil
]

{ #category : #actions }
CpWorkerApplication >> load [

	"Perform the initial loading of the receiver"

	super load.

	"Install the WorkerBehavior"
	self workerBehaviorClass
		installIn: self environment ;
		createIn: self environment
]

{ #category : #actions }
CpWorkerApplication >> reload [

	"Perform reloading of the receiver"

	super reload.

	"Create an instance of the WorkerBehavior in the ClientEnvironment
	(class is already installed during initial #load)"
	self workerBehaviorClass createIn: self environment
]

{ #category : #'public api' }
CpWorkerApplication >> sendMessage: aMessageSend [

	self environment sendMessage: aMessageSend
]

{ #category : #accessing }
CpWorkerApplication >> workerBehaviorClass [

	"Answer the class of the receiver's WorkerBehavior"

	^ self class workerBehaviorClass
]

{ #category : #actions }
CpWorkerApplication >> workerEndSession [

	self sendMessage: (MessageSend
		receiver: self workerBehaviorClass workerId
		selector: #endSession)
]
