"
I am a Model in a Model-View-Presenter pattern.
I announce when my value changed.

"
Class {
	#name : 'CpModel',
	#superclass : 'Object',
	#instVars : [
		'announcer'
	],
	#category : 'CodeParadise-WebApplication-MVP-Core',
	#package : 'CodeParadise-WebApplication-MVP',
	#tag : 'Core'
}

{ #category : 'announcing' }
CpModel class >> whenChangedSend: selector to: anObject [

	"Intentionally left blank"
]

{ #category : 'announcing' }
CpModel >> announce: anAnnouncement [

	"Let the receiver announce the specified Announcement"

	self announcer announce: anAnnouncement
]

{ #category : 'accessing' }
CpModel >> announcer [

	^ announcer
]

{ #category : 'accessing' }
CpModel >> application [

	"Answer the application in which the receiver is running.

	Implementation:
	The current application (ie session) is stored in an application context (dynamic variable)."

	^ CpCurrentApplicationContext application

]

{ #category : 'presenter' }
CpModel >> display [

	^ self displayIn: self application applicationPresenter
]

{ #category : 'presenter' }
CpModel >> displayIn: aPresenter [

	^ aPresenter createChildPresenterForModel: self
]

{ #category : 'initialization' }
CpModel >> initialize [

	super initialize.

	announcer := Announcer new
]

{ #category : 'presenter' }
CpModel >> preferredPresenterClass [

	"Answer the preferred Presenter class for the receiver (in its current state).
	By default the class with a matching name will be used (if present in the image).
	The matching name is created by postfixing #Presenter (optionally replacing an
	existing postfix #Model).
	Otherwise an error is raised to make clear a presenter class should be implemented
	or a subclass should override this method to answer a specific presenter class."

	| className presenterClass |

	className := (self class name withoutSuffix: #Model) asSymbol , #Presenter.
	presenterClass := Smalltalk classNamed: className.

	"If no Presenter class is found, raise an error to indicate the class should be created
	or the subclass should implement #preferredPresenterClass"
	presenterClass
		ifNil: [ self error: 'The Presenter class ', className , ' does not exist. Either create it or implement ' , self class name , ' >> #preferredPresenterClass to answer a specific class' ].

	^ presenterClass
]

{ #category : 'dependencies' }
CpModel >> release [

	announcer ifNotNil: [
		announcer subscriptions reset.
		announcer := nil ].

	super release
]

{ #category : 'announcing' }
CpModel >> removeSubscription: aSubscription [

	"Remove the specified subscription from the receiver"

	^ self announcer removeSubscription: aSubscription
]

{ #category : 'announcing' }
CpModel >> unsubscribe: anObject [

	"Unsubscribe the specified Object from Announcements of the receiver"

	^ self announcer unsubscribe: anObject
]

{ #category : 'announcing' }
CpModel >> valueChanged [
	
	"Announce the fact that the receiver's value changed.

	Implementation:
	This method is for compatibility with Model and NewValueHolder"

	self announce: (ValueChanged newValue: self)
]

{ #category : 'announcing' }
CpModel >> when: anAnnouncementClass do: aValuable [

	"Let the sender subscribe to the specified announcement of the receiver.
	See Announcer>>#when:do:"

	^ self announcer when: anAnnouncementClass do: aValuable
]

{ #category : 'announcing' }
CpModel >> when: anAnnouncementClass send: aSymbol to: anObject [

	"Let the sender subscribe to the specified announcement of the receiver.
	See Announcer>>#when:send:to:"

	^ self announcer when: anAnnouncementClass send: aSymbol to: anObject
]

{ #category : 'announcing' }
CpModel >> whenChangedDo: aBlock [

	"Let the sender subscribe to the value changed announcement of the receiver.

	Implementation:
	This method is for compatibility with Model and NewValueHolder"

	^ self when: ValueChanged do: aBlock
]

{ #category : 'announcing' }
CpModel >> whenChangedSend: aSymbol to: anObject [

	"Let the sender subscribe to the value changed announcement of the receiver

	Implementation:
	This method is for compatibility with Model and NewValueHolder"

	^ self when: ValueChanged send: aSymbol to: anObject
]
