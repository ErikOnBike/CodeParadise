Class {
	#name : #CpPropertyEntity,
	#superclass : #CpPropertyModel,
	#instVars : [
		'#id => CpPropertySlot'
	],
	#classVars : [
		'#LanguageText'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #'accessing - language' }
CpPropertyEntity class >> addVolume: aVolume locale: aSymbol [

	LanguageText addVolume: aVolume locale: aSymbol
]

{ #category : #'accessing - language' }
CpPropertyEntity class >> count: anInteger text: aSymbolOrParamText [

	^ self count: anInteger text: aSymbolOrParamText format: nil
]

{ #category : #'accessing - language' }
CpPropertyEntity class >> count: anInteger text: aSymbolOrParamText format: aDictionary [

	^ LanguageText count: anInteger key: aSymbolOrParamText format: aDictionary
]

{ #category : #accessing }
CpPropertyEntity class >> defineLabeledProperties [

	<propertyDefinition>

	| labelsByProperty label |

	labelsByProperty := self labelsByProperty.

	self propertySlotsDo: [ :each |

		"Use defined label or otherwise the property name"
		label := labelsByProperty at: each name ifAbsent: [ each name ].

		each addDefinition: (CpPropertyValue name: #label value: label) ]
]

{ #category : #accessing }
CpPropertyEntity class >> definePropertyConstraints [

	<propertyDefinition>

	self propertyConstraints keysAndValuesDo: [ :propertyName :constraints |
		(self propertySlotAt: propertyName)
			addAllDefinitions: constraints ]
]

{ #category : #adding }
CpPropertyEntity class >> for: aSymbol addConstraint: aPropertyConstraint to: aDictionary [

	"Convenience method to add PropertyConstraints to a Collection.
	For readability in the calling method, the Property name is the
	first argument."

	(aDictionary at: aSymbol ifAbsentPut: [ Set new ])
		add: aPropertyConstraint
]

{ #category : #'accessing - language' }
CpPropertyEntity class >> index: anInteger text: aSymbolOrParamText [

	^ self index: anInteger text: aSymbolOrParamText format: nil
]

{ #category : #'accessing - language' }
CpPropertyEntity class >> index: anInteger text: aSymbolOrParamText format: aDictionary [

	^ LanguageText index: anInteger key: aSymbolOrParamText format: aDictionary
]

{ #category : #testing }
CpPropertyEntity class >> isRunningServerSide [

	"Answer whether the receiver is executing in a server environment"

	^ (Smalltalk classNamed: #CpDomElement) isNil
]

{ #category : #accessing }
CpPropertyEntity class >> labelsByProperty [

	"Answer a Dictionary containing the labels of the properties.
	The keys are the property names, the values the labels.

	Subclasses should add their property/label combinations."

	^ Dictionary new
]

{ #category : #'accessing - language' }
CpPropertyEntity class >> postInstallOnce [

	<environment: #browser>

	LanguageText := CpMultiLanguageText defaultLanguage: (CpTextLanguage locale: #nl)
]

{ #category : #accessing }
CpPropertyEntity class >> propertyConstraints [

	"Answer a Dictionary of PropertyConstraints.
	The keys are the property names and the value is a collection of PropertyConstraint instances."

	^ Dictionary new
]

{ #category : #'accessing - language' }
CpPropertyEntity class >> text: aSymbolOrParamText [

	^ self text: aSymbolOrParamText format: nil
]

{ #category : #'accessing - language' }
CpPropertyEntity class >> text: aSymbolOrParamText format: aDictionary [

	^ LanguageText key: aSymbolOrParamText format: aDictionary
]

{ #category : #resources }
CpPropertyEntity class >> timestampNow [

	"Answer the current timestamp as seconds since Unix epoch (midnight Jan 1, 1970, UTC).

	Implementation:
	Since currently the tiny image for CodeParadise does not support any Date and Time classes,
	use a simple Unix timestamp. This value can be retrieved in both environments. It allows
	easy comparison and storage."

	(Smalltalk classNamed: #DateAndTime)
		ifNotNil: [ :dateAndTimeClass | ^ dateAndTimeClass now asUnixTime ].

	(Smalltalk classNamed: #CpJavaScriptClass)
		ifNotNil: [ :jsClass | ^ ((jsClass forName: #Date) apply: #now) // 1000 ].

	self error: 'No Data or DateAndTime class available in the current environment'
]

{ #category : #accessing }
CpPropertyEntity >> id [

	"Answer the (unique) id of the receiver"

	^ id
]

{ #category : #testing }
CpPropertyEntity >> isNew [

	^ id isNil
]
