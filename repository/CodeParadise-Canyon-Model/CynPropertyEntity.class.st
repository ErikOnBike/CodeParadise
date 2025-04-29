"
I am an Entity based on the PropertyModel. I am responsible for loading and storing my instances.
I therefore know about my instance's identity. I also expect to live in a multi-language environment
and therefore offer support for this.

Since Entities might need different behaviors for different situations, every class or subclass
can store configuration information to influence the required behavior.
This information by default includes support for multi-language support. If Canyon-App is also
loaded, support for REST API client is also present. Other types of information are for the user
to decide.

Configuration information is inherited through the subclass chain. If a configuration item is not
present on a subclass, it will ask the parent for this information. This allows defaults to be set
in a single location. If using #configAt:ifAbsentPut: it will store the confuration item at the
receiver of the message (not in the root) if the configuration item does not exist yet. Similarly,
removing a configuration item using #removeConfigAt: will only remove the item in the receiver and
not from any super class configuration.

"
Class {
	#name : #CynPropertyEntity,
	#superclass : #CynPropertyModel,
	#instVars : [
		'#id => CpPropertySlot'
	],
	#classInstVars : [
		'#config'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #'accessing - language' }
CynPropertyEntity class >> addVolume: aVolume locale: aSymbol [

	self languageText
		addVolume: aVolume locale: aSymbol
]

{ #category : #'accessing - configuration' }
CynPropertyEntity class >> configAt: aSymbol [

	"Answer the specified configuration item or nil if not present.
	By default configuration entries are inherited from class to subclasses."

	^ self configAt: aSymbol ifAbsent: [ nil ]
]

{ #category : #'accessing - configuration' }
CynPropertyEntity class >> configAt: aSymbol ifAbsent: aBlock [

	"Answer the specified configuration item.
	By default configuration entries are inherited from class to subclasses."

	"For CpPropertyEntity #config will never be empty"
	config ifNil: [ ^ self superclass configAt: aSymbol ifAbsent: aBlock ].

	^ config at: aSymbol ifAbsent: [
		self = CynPropertyEntity
			ifTrue: [ aBlock value ]
			ifFalse: [ self superclass configAt: aSymbol ifAbsent: aBlock ] ]
]

{ #category : #'accessing - configuration' }
CynPropertyEntity class >> configAt: aSymbol ifAbsentPut: aBlock [

	"Answer the specified configuration item or add a new one.
	By default configuration entries are inherited from class to subclasses."

	^ self configAt: aSymbol ifAbsent: [ self configAt: aSymbol put: aBlock value ]
]

{ #category : #'accessing - configuration' }
CynPropertyEntity class >> configAt: aSymbol put: anObject [

	"Store the specified configuration item.
	By default configuration entries are inherited from class to subclasses."

	^ (config ifNil: [ config := Dictionary new ])
		at: aSymbol put: anObject
]

{ #category : #'accessing - language' }
CynPropertyEntity class >> count: anInteger text: aSymbolOrTextReference [

	^ self count: anInteger text: aSymbolOrTextReference format: nil
]

{ #category : #'accessing - language' }
CynPropertyEntity class >> count: anInteger text: aSymbolOrTextReference format: aDictionary [

	^ self languageText
		count: anInteger key: aSymbolOrTextReference format: aDictionary
]

{ #category : #accessing }
CynPropertyEntity class >> definePropertyConstraints [

	<propertyDefinition>

	self propertyConstraints keysAndValuesDo: [ :propertyName :constraints |
		(self propertySlotAt: propertyName)
			addAllDefinitions: constraints ]
]

{ #category : #accessing }
CynPropertyEntity class >> for: aSymbol addConstraint: aPropertyConstraint to: aDictionary [

	"Convenience method to add PropertyConstraints to a Collection.
	For readability in the calling method, the Property name is the
	first argument."

	(aDictionary at: aSymbol ifAbsentPut: [ Set new ])
		add: aPropertyConstraint
]

{ #category : #'accessing - language' }
CynPropertyEntity class >> index: anInteger text: aSymbolOrTextReference [

	^ self index: anInteger text: aSymbolOrTextReference format: nil
]

{ #category : #'accessing - language' }
CynPropertyEntity class >> index: anInteger text: aSymbolOrTextReference format: aDictionary [

	^ self languageText
		index: anInteger key: aSymbolOrTextReference format: aDictionary
]

{ #category : #'accessing - language' }
CynPropertyEntity class >> languageText [

	^ self configAt: #languageText ifAbsent: [ self error: 'No languageText is set by default, please fix this' ]
]

{ #category : #'accessing - language' }
CynPropertyEntity class >> languageText: aLanguageText [

	self configAt: #languageText put: aLanguageText
]

{ #category : #'class initialization' }
CynPropertyEntity class >> postInstallOnce [

	config := Dictionary new
]

{ #category : #accessing }
CynPropertyEntity class >> propertyConstraints [

	"Answer a Dictionary of PropertyConstraints.
	The keys are the property names and the value is a collection of PropertyConstraint instances."

	^ Dictionary new
]

{ #category : #'accessing - configuration' }
CynPropertyEntity class >> removeConfigAt: aSymbol [

	"Remove the specified configuration item and answer its original value.
	Answer nil if the specified configuration does not exist.
	By default configuration entries are inherited from class to subclasses."

	config ifNil: [ ^ nil ].

	^ config removeKey: aSymbol ifAbsent: [ nil ]
]

{ #category : #'accessing - language' }
CynPropertyEntity class >> text: aSymbolOrParamText [

	^ self text: aSymbolOrParamText format: nil
]

{ #category : #'accessing - language' }
CynPropertyEntity class >> text: aSymbolOrTextReference format: aDictionary [

	^ self languageText
		key: aSymbolOrTextReference format: aDictionary
]

{ #category : #resources }
CynPropertyEntity class >> timestampNow [

	"Answer the current timestamp as seconds since Unix epoch (midnight Jan 1, 1970, UTC).

	Implementation:
	Since currently the tiny image for CodeParadise does not support any Date and Time classes,
	use a simple Unix timestamp. This value can be retrieved in both environments. It allows
	easy comparison and storage."

	(Smalltalk classNamed: #DateAndTime)
		ifNotNil: [ :dateAndTimeClass | ^ dateAndTimeClass now asUnixTime ].

	(Smalltalk classNamed: #CpJavaScriptClass)
		ifNotNil: [ :jsClass | ^ ((jsClass forName: #Date) apply: #now) // 1000 ].

	self error: 'No Date or DateAndTime class available in the current environment'
]

{ #category : #accessing }
CynPropertyEntity >> id [

	"Answer the (unique) id of the receiver"

	^ id
]

{ #category : #testing }
CynPropertyEntity >> isNew [

	"Answer whether the receiver is new (has not been written)"

	^ id isNil
]
