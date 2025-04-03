Extension { #name : #CpPropertyEntity }

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity class >> defineLabeledProperties [

	<propertyDefinition>

	| labelsByProperty label |

	labelsByProperty := self labelsByProperty.

	self propertySlotsDo: [ :each |

		"Use defined label or otherwise the property name"
		label := labelsByProperty at: each name ifAbsent: [ each name ].

		each addDefinition: (CpPropertyValue name: #label value: label) ]
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> inModelView [

	"Answer a new ModelView bound to the receiver"

	^ self preferredViewClass on: self
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> inNewPage [

	"Answer a new Page bound to the receiver"

	^ self pageClass withModel: self
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity class >> labelsByProperty [

	"Answer a Dictionary containing the labels of the properties.
	The keys are the property names, the values the labels.

	Subclasses should add their property/label combinations."

	^ Dictionary new
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> pageClass [

	"Answer a Page class which can be used to show the receiver"

	^ self shouldBeImplemented
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> preferredViewClass [

	"Answer the preferred View class for the receiver"

	^ Smalltalk classNamed: self class name, #View
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity class >> restApiClient [

	"Use the REST API Client stored in my configuration"

	^ self configAt: #restApiClient
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> restApiClient [

	"Answer the REST API Client which allows loading/storing of the receiver.
	By default the class is responsible to know this."

	^ self class restApiClient
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity class >> restApiClient: aRestApiClient [

	"Store the specified REST API Client in my configuration"

	self configAt: #restApiClient put: aRestApiClient
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> restBodyContent [

	"Answer the receiver as body content (String) for a REST request"

	^ CpJavaScriptJSON stringify: self asJsonObjectValue
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> restCreateTimeoutPeriod [

	"Answer the create timeout period in milliseconds"

	^ self restApiClient
		requestTimeoutPeriod
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> restCreateUsingUri: aString timeoutPeriod: anInteger [

	"Create the resource using the specified URI"

	(self restApiClient postUri: aString body: self restBodyContent timeoutPeriod: anInteger)
		ifNotNil: [ :content | self merge: content ]
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> restDelete [

	"Delete the resource"

	"If the resource is new, delete is a no-op"
	self isNew
		ifTrue: [ ^ self ].

	self
		restDeleteUsingUri: self uri
		timeoutPeriod: self restDeleteTimeoutPeriod
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> restDeleteTimeoutPeriod [

	"Answer the delete timeout period in milliseconds"

	^ self restApiClient
		requestTimeoutPeriod
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> restDeleteUsingUri: aString timeoutPeriod: anInteger [

	"Delete the resource using the specified URI"

	(self restApiClient deleteUri: aString timeoutPeriod: anInteger)
		ifNotNil: [ :content | self merge: content ]
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity class >> restRead [

	"Read (all) the resources of the receiver's 'type'"

	^ self
		restReadUsingUri: self uri
		timeoutPeriod: self restReadTimeoutPeriod
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> restRead [

	"Read the resource using its identity"

	"Signal error if receiver does not have an identity"
	self isNew
		ifTrue: [ self error: 'Can''t load a resource without an identity' ].

	self
		restReadUsingUri: self uri
		timeoutPeriod: self restReadTimeoutPeriod
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity class >> restReadTimeoutPeriod [

	"Answer the read timeout period in milliseconds"

	^ self restApiClient
		requestTimeoutPeriod
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> restReadTimeoutPeriod [

	"Answer the read timeout period in milliseconds"

	^ self restApiClient
		requestTimeoutPeriod
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity class >> restReadUsingUri: aString timeoutPeriod: anInteger [

	"Read (all) the resources of the receiver's 'type' using the specified URI"

	^ (self restApiClient getUri: aString timeoutPeriod: anInteger) collect: [ :each |
		self fromDictionary: each ]
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> restReadUsingUri: aString timeoutPeriod: anInteger [

	"Read the resource using the specified URI"

	(self restApiClient getUri: aString timeoutPeriod: anInteger)
		ifNotNil: [ :content | self merge: content ]
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> restUpdateTimeoutPeriod [

	"Answer the Update timeout period in milliseconds"

	^ self restApiClient
		requestTimeoutPeriod
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> restUpdateUsingUri: aString timeoutPeriod: anInteger [

	"Update the resource using the specified URI"

	(self restApiClient putUri: aString body: self restBodyContent timeoutPeriod: anInteger)
		ifNotNil: [ :content | self merge: content ]
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> restWrite [

	"Store the resource"

	self isNew
		ifTrue: [
			self
				restCreateUsingUri: self uri
				timeoutPeriod: self restCreateTimeoutPeriod ]
		ifFalse: [
			self
				restUpdateUsingUri: self uri
				timeoutPeriod: self restUpdateTimeoutPeriod ]
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> show [

	"Show the receiver in its own Page (with its preferred View)"

	CpCanyonAppMainView current
		navigateTo: self pageClass withModel: self
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity class >> uri [

	"Answer the URI where the receiver is located"

	^ self shouldBeImplemented
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> uri [

	"Answer the URI where the receiver is located"

	^ self isNew
		ifTrue: [ self class uri ]
		ifFalse: [ '{1}/{2}' format: { self class uri . id } ]
]
