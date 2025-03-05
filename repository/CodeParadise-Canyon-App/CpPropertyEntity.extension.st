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
CpPropertyEntity class >> labelsByProperty [

	"Answer a Dictionary containing the labels of the properties.
	The keys are the property names, the values the labels.

	Subclasses should add their property/label combinations."

	^ Dictionary new
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
