Extension { #name : #CpPropertyEntity }

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity class >> labelFor: propertySymbol selection: selectionSymbol [

	"Answer the label for the specified selection of the specified property"

	| labelKey labelValue |

	"Create label key"
	labelKey := (String streamContents: [ :stream |
		stream
			nextPutAll: 'app.selection.' ;
			nextPutAll: (self nameWithoutPrefix withoutPrefix: #Canyon) uncapitalized ;
			nextPut: $. ;
			nextPutAll: propertySymbol ;
			nextPut: $. ;
			nextPutAll: selectionSymbol ]) asSymbol.

	"Retrieve label value"
	labelValue := self text: labelKey.

	"If no label value is found and not yet at root, try superclass"
	(labelValue == labelKey and: [ self ~~ CpPropertyEntity ])
		ifTrue: [ labelValue := self superclass labelFor: propertySymbol selection: selectionSymbol ].

	^ labelValue
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> labelFor: propertySymbol selection: selectionSymbol [

	"Answer the label for the specified selection of the specified property"

	^ self class
		labelFor: propertySymbol selection: selectionSymbol
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> pageClass [

	"Answer the page class for the receiver.

	Implementation:
	Either use the specifically mapped name or otherwise the class with matching name."

	^ (CpCanyonAppPage classForModel: self) ifNil: [
		(Smalltalk classNamed: self class name, #Page)
			ifNil: [ self error: 'No Page class found for Model ', self class name ] ]
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

	"Read (all) the resources of the receiver's 'type' using the specified URI.

	If the session has expired this will answer an empty collection."

	^ (self restApiClient getUri: aString timeoutPeriod: anInteger)
		ifNotNil: [ :array | array collect: [ :each | self fromDictionary: each ] ]
		ifNil: [ #() ]
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

	"Show the receiver in its own/preferred Page (with its preferred View)"

	self showInPage: self pageClass
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyEntity >> showInPage: aClass [

	"Show the receiver using the specified Page class (with its preferred View)"

	CpCanyonAppMainView current
		navigateTo: aClass withModel: self
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
