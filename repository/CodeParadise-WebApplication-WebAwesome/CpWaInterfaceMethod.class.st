Class {
	#name : #CpWaInterfaceMethod,
	#superclass : #Object,
	#instVars : [
		'name',
		'typeDescription',
		'returnTypeDescription',
		'parameters',
		'commonParameterPrefixLength',
		'description',
		'instanceSide'
	],
	#category : #'CodeParadise-WebApplication-WebAwesome-Support'
}

{ #category : #'instance creation' }
CpWaInterfaceMethod class >> copy: aMethod withoutParameter: anInteger [

	^ self basicNew
		initializeFrom: aMethod withoutParameter: anInteger ;
		yourself
]

{ #category : #accessing }
CpWaInterfaceMethod >> addParameterName: aString typeDescription: aDictionary [

	parameters ifNil: [ parameters := OrderedCollection new ].

	parameters add: aString -> aDictionary.

	"Keep track of a common prefix in parameter names"
	commonParameterPrefixLength := commonParameterPrefixLength
		ifNotNil: [ self commonPrefixLength: commonParameterPrefixLength between: aString and: parameters first key ]
		ifNil: [ aString size ]
]

{ #category : #accessing }
CpWaInterfaceMethod >> comment [

	"Answer the comment for the receiver"

	^ String streamContents: [ :stream |
		stream
			nextPutAll: description trimmed ; cr ;
			cr.
		self returnType ifNotNil: [ :returnType |
			stream nextPutAll: 'Return type: ' ; nextPutAll: returnType ; cr ].
		self parameters do: [ :each |
			stream nextPutAll: 'Parameter: ' ; nextPutAll: (self parameterName: each key) ; nextPutAll: ' (' ; nextPutAll: ((self parameterType: each value) ifNil: [ '<unknown>' ]) ; nextPut: $) ; cr ] ]
]

{ #category : #accessing }
CpWaInterfaceMethod >> commonPrefixLength: anInteger between: firstString and: secondString [

	| count |

	"Most common case"
	anInteger = 0
		ifTrue: [ ^ 0 ].

	count := (anInteger min: firstString size) min: secondString size.

	1 to: count do: [ :index |
		(firstString at: index) = (secondString at: index)
			ifFalse: [ ^ index - 1 ] ].

	^ count
]

{ #category : #accessing }
CpWaInterfaceMethod >> copyWithoutParameter: anInteger [

	"Answer a copy of the receiver without the specified parameter (or any following it)"

	^ self class
		copy: self withoutParameter: anInteger
]

{ #category : #accessing }
CpWaInterfaceMethod >> createAlternatives [

	"Answer a Collection with alternatives for the receiver,
	where the optional parameters are left out"

	| alternatives |

	self hasParameters
		ifFalse: [ ^ #() ].

	alternatives := OrderedCollection new.

	self parameters reverseWithIndexDo: [ :each :index |
		(self isOptionalParameter: each value)
			ifTrue: [ alternatives add: (self copyWithoutParameter: index) ]
			ifFalse: [ ^ alternatives ] ].

	^ alternatives
]

{ #category : #accessing }
CpWaInterfaceMethod >> description [

	^ description
]

{ #category : #accessing }
CpWaInterfaceMethod >> description: aString [

	description := aString
]

{ #category : #accessing }
CpWaInterfaceMethod >> from: aDictionary atPath: aCollection [

	^ CpWaInterfaceInstaller from: aDictionary atPath: aCollection
]

{ #category : #testing }
CpWaInterfaceMethod >> hasParameters [

	^ parameters isEmptyOrNil not
]

{ #category : #initialization }
CpWaInterfaceMethod >> initializeFrom: aMethod withoutParameter: anInteger [

	self initialize.

	name := aMethod name.
	typeDescription := aMethod typeDescription.
	returnTypeDescription := aMethod returnTypeDescription.
	description := aMethod description.
	instanceSide := aMethod instanceSide.

	"Add parameters one by one, because it also calculates the common prefix.
	Skip the specified parameter and onwards."
	1 to: anInteger -1 do: [ :index |
		| parameter |
		parameter := aMethod parameters at: index.
		self addParameterName: parameter key typeDescription: parameter value ]
]

{ #category : #initialization }
CpWaInterfaceMethod >> installIn: aClass [

	CpWaInterfaceInstaller
		installMethodSource: self methodSource
		selector: self selector
		protocol: 'actions'
		in: aClass
]

{ #category : #accessing }
CpWaInterfaceMethod >> instanceSide [

	^ instanceSide
]

{ #category : #accessing }
CpWaInterfaceMethod >> instanceSide: aBoolean [

	instanceSide := aBoolean
]

{ #category : #accessing }
CpWaInterfaceMethod >> isOptionalParameter: aDictionary [

	^ (self from: aDictionary atPath: #(optional)) = true
		or: [ (self parameterDefault: aDictionary) isNotNil ]
]

{ #category : #testing }
CpWaInterfaceMethod >> isUnwanted [

	"Answer whether the receiver is an unwanted method.

	The method 'formStateRestoreCallback' is seemingly called by the browser.
	Do not include it in the public API."

	^ name = 'formStateRestoreCallback'
]

{ #category : #accessing }
CpWaInterfaceMethod >> methodSource [

	"Answer the source code for the receiver"

	^ String streamContents: [ :stream |
		stream
			nextPutAll: self selectorAndParameters ; cr ;
			cr ;
			nextPutAll: (CpWaInterfaceInstaller generateComment: self comment indent: 1) ; cr ;
			cr ;
			tab ; nextPutAll: '^ self apply: #' ; nextPutAll: name.
		self hasParameters
			ifTrue: [
				stream nextPutAll: ' withArguments: { '.
				self parameterNames
					do: [ :each | stream nextPutAll: each ]
					separatedBy: [ stream nextPutAll: ' . ' ].
				stream nextPutAll: ' }' ] ]
]

{ #category : #accessing }
CpWaInterfaceMethod >> name [

	^ name
]

{ #category : #accessing }
CpWaInterfaceMethod >> name: aString [

	name := aString
]

{ #category : #accessing }
CpWaInterfaceMethod >> parameterDefault: aDictionary [

	"Answer the parameter default value from the specified parameter definition"

	^ self from: aDictionary atPath: #(default)
]

{ #category : #accessing }
CpWaInterfaceMethod >> parameterName: aSymbol [

	"Answer the normalized parameter name from the specified parameter name"

	^ (self parameters size > 1 and: [ commonParameterPrefixLength > 0 ])
		ifTrue: [ (aSymbol allButFirst: commonParameterPrefixLength) uncapitalized ]
		ifFalse: [ aSymbol ]
]

{ #category : #accessing }
CpWaInterfaceMethod >> parameterNames [

	"Answer the parameter names for the receiver"

	| names |

	self hasParameters
		ifFalse: [ ^ #() ].

	names := OrderedCollection new.

	self parameters do: [ :each |
		| class paramName |
		class := self sourceParameterClass: each value.
		paramName := class canonicalArgumentName.

		"If the bare type is already used, replace all with a parameter name prefix"
		(names includes: paramName)
			ifTrue: [
				names add: paramName.
				names withIndexDo: [ :eachName :index |
					eachName = paramName
						ifTrue: [ names at: index put: (self parameterName: (self parameters at: index) key), class name ] ] ]
			ifFalse: [ names add: paramName ] ].

	^ names
]

{ #category : #accessing }
CpWaInterfaceMethod >> parameterType: aDictionary [

	"Answer the parameter type from the specified parameter definition.

	Implementation:
	The default value is checked first, because it often reveals things like a string or number.
	Sometimes the type is given as constant values too. So check these as well."

	^ (self parameterTypeFromDefault: aDictionary)
		ifNil: [
			(self from: aDictionary atPath: #(type text))
				ifNotNil: [ :type |
					type first = $'
						ifTrue: [ #string ]
						ifFalse: [ type ] ] ]
]

{ #category : #accessing }
CpWaInterfaceMethod >> parameterTypeFromDefault: aDictionary [

	"Answer the parameter type from the default value from the specified parameter definition"

	| default |

	default := self parameterDefault: aDictionary.

	default isEmptyOrNil
		ifTrue: [ ^ nil ].

	"Check for a number"
	default asNumberOrNil
		ifNotNil: [ ^ #number ].

	"Check for a string"
	(default first = $' or: [ default first = $" ])
		ifTrue: [ ^ #string ].

	"Check for a boolean"
	(#(#true #false) includes: default)
		ifTrue: [ ^ #boolean ].

	"Check for an object"
	default first = ${
		ifTrue: [ ^ #object ].

	^ nil
]

{ #category : #accessing }
CpWaInterfaceMethod >> parameters [

	^ parameters ifNil: [ #() ]
]

{ #category : #accessing }
CpWaInterfaceMethod >> returnType [

	"Answer a (in Smalltalk terms) meaningful return type"

	returnTypeDescription ifNil: [ ^ nil ].
	returnTypeDescription = #void
		ifTrue: [ ^ nil ].

	^ returnTypeDescription
]

{ #category : #accessing }
CpWaInterfaceMethod >> returnTypeDescription [

	^ returnTypeDescription
]

{ #category : #accessing }
CpWaInterfaceMethod >> returnTypeDescription: aString [

	returnTypeDescription := aString
]

{ #category : #accessing }
CpWaInterfaceMethod >> selector [

	"Answer the selector for the receiver"

	^ String streamContents: [ :stream |
		stream nextPutAll: name.
		self hasParameters
			ifTrue: [
				self parameters size >= 3
					ifTrue: [ stream nextPutAll: (self parameterName: self parameters first key) capitalized ].
				stream nextPut: $:.
				self parameters allButFirstDo: [ :each |
					stream
						nextPutAll: (self parameterName: each key) ;
						nextPut: $: ] ] ]
]

{ #category : #accessing }
CpWaInterfaceMethod >> selectorAndParameters [

	"Answer the selector and parameters for the receiver"

	| selector paramNames index |

	self hasParameters
		ifFalse: [ ^ self selector ].

	selector := self selector.
	paramNames := self parameterNames.
	index := 1.

	^ String streamContents: [ :stream |
		$: split: selector do: [ :each |

			"The last entry will always be empty"
			each ifNotEmpty: [
				stream
					nextPutAll: each ;
					nextPutAll: ': ' ;
					nextPutAll: (paramNames at: index).
				index := index + 1.

				"Add a space if more parameters will be added"
				index > paramNames size
					ifFalse: [ stream space ] ] ] ]
]

{ #category : #accessing }
CpWaInterfaceMethod >> sourceParameterClass: aDictionary [

	"Answer the parameter class for use in the source from the specified parameter"

	| type |

	type := self parameterType: aDictionary.

	type = #number
		ifTrue: [ ^ Number ].

	type = #string
		ifTrue: [ ^ String ].

	type = #boolean
		ifTrue: [ ^ Boolean ].

	type = #object
		ifTrue: [ ^ Object ].

	"WebAwesome specific types"
	(type beginsWith: 'HTMLElement')
		ifTrue: [ ^ CpHtmlElement ].

	type = #FocusOptions
		ifTrue: [ ^ Object ].

	((type beginsWith: 'string |') or: [ (type includesSubstring: '| string |') or: [ type endsWith: '| string' ] ])
		ifTrue: [ ^ String ].

	type first = ${
		ifTrue: [ ^ Object ].

	self halt
]

{ #category : #accessing }
CpWaInterfaceMethod >> typeDescription [

	^ typeDescription
]

{ #category : #accessing }
CpWaInterfaceMethod >> typeDescription: aString [

	typeDescription := aString
]
