Class {
	#name : #CpWaInterfaceInstaller,
	#superclass : #Object,
	#instVars : [
		'typeDict',
		'elementDict',
		'type',
		'element',
		'typeAttributes',
		'elementAttributes',
		'properties',
		'methods',
		'events'
	],
	#category : #'CodeParadise-WebApplication-WebAwesome-Support'
}

{ #category : #accessing }
CpWaInterfaceInstaller class >> allowedValueFromTypeDescription: aString [

	"Answer a value representing the specified type description.

	Implementation:
	String values are answered as Strings.
	A known/recognised type is converted into a Smalltalk class.
	An Array type (typical in TypeScript) is converted into an Array with a Smalltalk class as single array item.
	The TS undefined and null are converted to the nil value.
	Everything else is converted to the Smalltalk class Object."

	| typeString type isArray |

	typeString := aString trimmed.

	"Check for String value"
	(typeString first = $' and: [ typeString last = $' ])
		ifTrue: [ ^ typeString copyFrom: 2 to: typeString size - 1 ].

	"Check for undefined or null (which we ignore)"
	(typeString = #undefined or: [ typeString = #null ])
		ifTrue: [ ^ nil ].

	"Check for an Array"
	(isArray := typeString endsWith: '[]')
		ifTrue: [ typeString := (typeString allButLast: 2) trimmed ].

	"Check for a known type"
	typeString = #string
		ifTrue: [ type := String ].
	typeString = #number	"Unfortunately TypeScript does not distinguish between integers/floats and generic numbers"
		ifTrue: [ type := Number ].
	typeString = #boolean
		ifTrue: [ type := Boolean ].

	(#(Element VirtualElement HTMLElement HTMLFormElement HTMLSlotElement) includes: typeString)
		ifTrue: [ type := CpHtmlElement ].

	typeString = #CSSNumberish
		ifTrue: [ type := Number ].

	typeString = #Keyframe
		ifTrue: [ type := Dictionary ].

	typeString = #IconAnimation
		ifTrue: [ type := String ].

	(Smalltalk classNamed: typeString) ifNotNil: [ :class |
		type := class ].

	(self typeStringContainsFunction: typeString)
		ifTrue: [ type := BlockClosure ].

	type ifNotNil: [
		^ isArray
			ifTrue: [ { type } ]
			ifFalse: [ type ] ].

	"Unknown type, use generic Object"
	^ Object
]

{ #category : #accessing }
CpWaInterfaceInstaller class >> allowedValuesFromTypeDescription: aString [

	"Answer a collection of values represented by the specified type description.

	Implementation:
	Only if an actual value (not just a type/Class) is known will it be answered."

	| values |

	values := ((aString substrings: '|')
		collect: [ :each | self allowedValueFromTypeDescription: each ])
			reject: [ :each | each isNil ].

	"Collect the actual values (not just a type/Class)"
	values := values select: [ :each | each isArray not and: [ each isClass not ] ].

	^ values ifEmpty: [ nil ]
]

{ #category : #accessing }
CpWaInterfaceInstaller class >> classFromTypeDescription: aString [

	"Answer a Smalltalk class representing the specified type description.

	Implementation:
	This method uses the #allowedValueFromTypeDescription: which answers String
	instances for (typically) enumerated values. Here we convert it back to String
	as a Class."

	^ (self allowedValueFromTypeDescription: aString) ifNotNil: [ :value |
		value isString
			ifTrue: [ String ]
			ifFalse: [ value ] ]
]

{ #category : #private }
CpWaInterfaceInstaller class >> from: aDictionary atPath: aCollection [

	"Answer the value at the specified path (sequencable collection of keys)
	or nil if that path does not exist"

	^ aCollection inject: aDictionary into: [ :result :each |
		result isDictionary
			ifTrue: [ result at: each ifAbsent: [ nil ] ] ]
]

{ #category : #accessing }
CpWaInterfaceInstaller class >> generateComment: aString indent: anInteger [

	"Generate a comment from the specified String with the specified indentation count.
	The String can be multi-line. The String will be sanitized before usage, meaning
	whitespace before a line ending is ignored. Line endings are also made consistent
	using <cr> instead of <lf> or <cr>/<lf> combinations.

	Be aware: there will NOT be a final <cr>, so the result will end with a comment
	marker (the double quote)."

	^ String streamContents: [ :stream |

		anInteger timesRepeat: [ stream tab ].
		stream nextPut: $".

		(self sanitizeComment: aString) do: [ :each |
			stream nextPut: each.
			(each = Character cr and: [ stream peek ~= Character cr ])
				ifTrue: [ anInteger timesRepeat: [ stream tab ] ] ].

		stream nextPut: $" ]
]

{ #category : #actions }
CpWaInterfaceInstaller class >> installAll [

	<script>

	| typeDefinition elementDefinition |

	self traceCr: 'Reading WebAwesome framework components'.

	typeDefinition := ZnClient new
		get: 'https://cdn.jsdelivr.net/npm/@awesome.me/webawesome@latest/dist/web-types.json' ;
		contents.
	elementDefinition := ZnClient new
		get: 'https://cdn.jsdelivr.net/npm/@awesome.me/webawesome@latest/dist/custom-elements.json' ;
		contents.

	self
		installFromTypeDict: (NeoJSONReader fromString: typeDefinition)
		elementDict: (NeoJSONReader fromString: elementDefinition).

	self traceCr: 'Done'
]

{ #category : #actions }
CpWaInterfaceInstaller class >> installClass: aSymbol asSubclassOf: aClass inTag: aString [

	^ (Smalltalk classNamed: aSymbol)
		ifNil: [

			self traceCr: 'Creating new component ', aSymbol.
			(aClass << aSymbol
				tag: aString ;
				package: 'CodeParadise-WebApplication-WebAwesome') install ]
]

{ #category : #actions }
CpWaInterfaceInstaller class >> installFromTypeDict: typeDictionary elementDict: elementDictionary [

	self basicNew
		initializeWithTypeDict: typeDictionary elementDict: elementDictionary ;
		install
]

{ #category : #actions }
CpWaInterfaceInstaller class >> installMethodSource: sourceString selector: aSymbol protocol: protocolString in: aClass [

	| normalizedSourceCode |

	normalizedSourceCode := sourceString replaceAll: Character lf with: Character cr.

	"Check for presence of existing method"
	(aClass includesSelector: aSymbol)
		ifTrue: [
			| sourceCode |
			sourceCode := (aClass >> aSymbol) sourceCode.

			sourceCode = normalizedSourceCode
				ifFalse: [ self halt ] ].

	aClass compile: sourceString classified: protocolString
]

{ #category : #accessing }
CpWaInterfaceInstaller class >> sanitizeComment: aString [

	"Answer a sanitized version of the specified comment content.

	Implementation:
	All double quotes are escaped. All line endings are replaced by <cr>.
	When <cr>/<lf> combinations are present, they will be replaced by a single <cr>.
	Any space (<space> or <char>) in front of a line ending will be removed.
	All other whitespace will be kept/maintained as is, including any trailing
	line endings."

	| whitespaceStream lastIsCr comment |

	whitespaceStream := WriteStream on: (String new: 10).
	lastIsCr := false.

	comment := String streamContents: [ :stream |
		aString do: [ :each |

			"Keep track of whitespace before actually adding it to the result"
			(each = Character space or: [ each = Character tab ])
				ifTrue: [ whitespaceStream nextPut: each ]
				ifFalse: [

					"Handle and keep track of line endings, replacing cr/lf by cr only (ignore lf after cr)"
					(lastIsCr and: [ each = Character lf ])
						ifFalse: [

							(each = Character cr or: [ each = Character lf ])
								ifTrue: [

									"Write a single line ending and reset (i.e. ignore) whitespace"
									stream cr.
									whitespaceStream resetToStart ]
								ifFalse: [

									"Write any pending whitespace"
									whitespaceStream isEmpty
										ifFalse: [
											stream nextPutAll: whitespaceStream contents.
											whitespaceStream resetToStart ].

									"Write character (and escape comment marker)"
									stream nextPut: each.
									each = $"
										ifTrue: [ stream nextPut: $" ] ] ].

					lastIsCr := each = Character cr ] ] ].

	"Remove line endings at end"
	^ comment trimRight: [ :char | char = Character cr ]
]

{ #category : #accessing }
CpWaInterfaceInstaller class >> typeNameFromTypeDescription: aString [

	"Answer a Smalltalk class name (or combination like 'NumberOrString' representing
	the specified type description.

	Implementation:
	Use the classFromTypeDescription to retrieve type information. Remove nil and Object because
	Object will be the default type if all else fails (and everything is an Object anyway ;-)."

	| values |

	"Retrieve classes (but ignore nil and Object)"
	values := (((aString substrings: '|')
		collect: [ :each | self classFromTypeDescription: each ])
			reject: [ :each | each isNil or: [ each = Object ] ]) asSet
				asSortedCollection: [ :a :b | (a isArray ifTrue: [ a first ] ifFalse: [ a ]) nameWithoutPrefix < (b isArray ifTrue: [ b first ] ifFalse: [ b ]) nameWithoutPrefix ].

	"If no specific value found assume Object"
	values ifEmpty: [ ^ #Object ].

	"Single value (may include actual value, not a class)"
	values size = 1
		ifTrue: [
			values anyOne ifNotNil: [ :value |
				^ (value isClass
					ifTrue: [ value ]
					ifFalse: [ value class ]) nameWithoutPrefix ] ].

	"Check for all Strings explicitly"
	(values allSatisfy: [ :each | each = String or: [ each isArray and: [ each first = String ] ] ])
		ifTrue: [ ^ #String ].

	"Check for situation: <type> | <type>[]"
	values size = 2
		ifTrue: [
			| type |
			type := values anyOne.
			type isArray
				ifTrue: [ type := type first ].
			(values allSatisfy: [ :each | each = type or: [ each isArray and: [ each first = type ] ] ])
				ifTrue: [ ^ type nameWithoutPrefix ] ].

	^ #Or join: (values collect: [ :each | each nameWithoutPrefix ])
]

{ #category : #accessing }
CpWaInterfaceInstaller class >> typeStringContainsFunction: aString [

	^ aString first = $( and: [ aString includesSubstring: ') => ' ]
]

{ #category : #accessing }
CpWaInterfaceInstaller >> className [

	"Answer the element's class name"

	^ element at: #name
]

{ #category : #'accessing - field members' }
CpWaInterfaceInstaller >> defaultValueFromFieldMember: aDictionary [

	"Answer the default value for the specified field member.

	Implementation:
	Since field member definitions are sometimes not fully defined, first try the information from the type definition."

	| attributeName |

	attributeName := aDictionary at: #attribute ifAbsent: [ aDictionary at: #name ].

	"Try the information in the type definition"
	(self from: typeAttributes atPath: { attributeName . #value . #default })
		ifNotNil: [ :defaultValue | ^ self valueFromString: defaultValue trimmed ].

	"Try the information in the element definition"
	(self from: elementAttributes atPath: { attributeName . #default })
		ifNotNil: [ :defaultValue | ^ self valueFromString: defaultValue trimmed ].

	"No default value present"
	^ nil
]

{ #category : #'accessing - field members' }
CpWaInterfaceInstaller >> descriptionFromMember: aDictionary [

	"Answer the description for the specified field member.

	Implementation:
	Since field member definitions are sometimes not fully defined, first try the information from the type definition."

	| attributeName |

	attributeName := aDictionary at: #attribute ifAbsent: [ aDictionary at: #name ].

	"Try the information in the type definition"
	(self from: typeAttributes atPath: { attributeName . #description })
		ifNotNil: [ :description | ^ description ].

	"Try the information in the element definition"
	(self from: elementAttributes atPath: { attributeName . #description })
		ifNotNil: [ :description | ^ description ].

	"Try the field member definition itself"
	aDictionary at: #description ifPresent: [ :description |
		^ description ].

	self error: 'Can''t retrieve description from element'
]

{ #category : #iterating }
CpWaInterfaceInstaller >> eventMembersDo: aBlock [

	(elementDict at: #modules) do: [ :eachModule |
		(eachModule at: #declarations ifAbsent: [ #() ]) do: [ :eachDeclaration |
			(self from: eachDeclaration atPath: #(kind)) = #class
				ifTrue: [
					(self from: eachDeclaration atPath: #(superclass name)) = #Event
						ifTrue: [ aBlock value: eachDeclaration ] ] ] ]
]

{ #category : #iterating }
CpWaInterfaceInstaller >> fieldMembersFromElementDo: aBlock [

	"Evaluate the specified Block for all public field members of the current element"

	self publicMembers: #field fromElementDo: aBlock
]

{ #category : #'accessing - field members' }
CpWaInterfaceInstaller >> fieldTypeFromFieldMember: aDictionary [

	"Answer the field type for the specified field member.

	Implementation:
	Since field member definitions are sometimes not fully defined, first try the information from the type definition."

	| attributeName |

	attributeName := aDictionary at: #attribute ifAbsent: [ aDictionary at: #name ].

	"Try the field member definition itself for the specific parsedType definition"
	(self from: aDictionary atPath: #(parsedType text))
		ifNotNil: [ :fieldType | ^ fieldType ].

	"Try the information in the type definition"
	(self from: typeAttributes atPath: { attributeName . #value . #type })
		ifNotNil: [ :fieldType | ^ fieldType ].

	"Try the information in the element definition"
	(self from: elementAttributes atPath: { attributeName . #type . #text })
		ifNotNil: [ :fieldType | ^ fieldType ].

	"Try the field member definition itself"
	(self from: aDictionary atPath: #(type text))
		ifNotNil: [ :fieldType | ^ fieldType ].

	"Handle specific field"
	attributeName = #modal
		ifTrue: [ ^ 'Object' ].

	self error: 'Can''t retrieve field type from element'
]

{ #category : #'instance creation' }
CpWaInterfaceInstaller >> from: aDictionary atPath: aCollection [

	^ self class from: aDictionary atPath: aCollection
]

{ #category : #initialization }
CpWaInterfaceInstaller >> initializeWithTypeDict: typeDictionary elementDict: elementDictionary [

	self initialize.

	typeDict := typeDictionary.
	elementDict := elementDictionary
]

{ #category : #actions }
CpWaInterfaceInstaller >> install [

	"Install all the components of the WebAwesome interface.

	Implementation:
	Components are installed from 2 different definitions.
	A type and an element definition. The type and element definition
	are selected per component before installing the component.
	This allows different methods to use these 'current' type and
	element definitions."

	self typesDo: [ :each |
		self
			setupType: each ;
			installComponent ].

	"Install the Event (currently just empty classes)"
	events := Set new.

	self selectEvents.

	events do: [ :each | each install ]
]

{ #category : #actions }
CpWaInterfaceInstaller >> installComponent [

	"Install the component using the currently selected definitions.

	Implementation:
	Gather all relevant info first, then create the actual class and its methods."

	| componentClass |

	self traceCr: 'Installing component: ', self className.

	self
		selectProperties ;
		selectMethods.

	componentClass := self class installClass: self className asSymbol asSubclassOf: WaElement inTag: 'Elements'.

	properties do: [ :each | each installMethodsIn: componentClass ].

	methods do: [ :each |
		each isUnwanted
			ifFalse: [ each installIn: componentClass ] ]
]

{ #category : #testing }
CpWaInterfaceInstaller >> isClassDeclaration: aDictionary [

	"Answer whether the specidied Declaration is a Class declaration"

	^ aDictionary
		at: #kind
		ifPresent: [ :kind | kind = #class ]
		ifAbsent: [ false ]
]

{ #category : #testing }
CpWaInterfaceInstaller >> isModule: aDictionary forTag: aString [

	"Answer whether the specified module (a Dictionary) is for the specified HTML tag.

	Implementation:
	In the module's declaration a tag name is present. Compare it with the specified tag."

	"Ensure we have a module"
	(aDictionary at: #kind) = 'javascript-module'
		ifFalse: [ ^ false ].

	"Ensure we have a component"
	((aDictionary at: #path) beginsWith: 'components/')
		ifFalse: [ ^ false ].

	"Ensure we have our visual component (not some library component)"
	^ (aDictionary at: #declarations)
		detect: [ :each | each at: #tagName ifPresent: [ :tagName | tagName = aString ] ifAbsent: [ false ] ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #testing }
CpWaInterfaceInstaller >> isPublicMember: aDictionary [

	"Answer whether the specified member is public.

	Implementation:
	Members are public by default or can be marked public explicitly (other values are: #private and #protected)."

	^ aDictionary
		at: #privacy
		ifPresent: [ :privacy | privacy = #public ]
		ifAbsent: [ true ]
]

{ #category : #iterating }
CpWaInterfaceInstaller >> membersFromElementDo: aBlock [

	"Evaluate the specified Block for each member (Dictionary) of the current element"

	(element at: #members ifAbsent: [ #() ])
		do: aBlock
]

{ #category : #iterating }
CpWaInterfaceInstaller >> methodMembersFromElementDo: aBlock [

	"Evaluate the specified Block for all public method members of the current element"

	self publicMembers: #method fromElementDo: aBlock
]

{ #category : #iterating }
CpWaInterfaceInstaller >> publicMembers: aSymbol fromElementDo: aBlock [

	"Evaluate the specified Block for all public members (of the specified type) of the current element"

	self membersFromElementDo: [ :each |
		"Only members which have a description and are marked public are considered 'public'"
		((each at: #kind) = aSymbol and: [ (each includesKey: #description) and: [ self isPublicMember: each ] ])
			ifTrue: [ aBlock value: each ] ]
]

{ #category : #accessing }
CpWaInterfaceInstaller >> selectAttributesFromElement [

	"Create a Dictionary with attribute name -> attribute object (Dictionary) from the current element"

	elementAttributes := Dictionary newFrom: ((element at: #attributes)
		collect: [ :each | (each at: #name) -> each ])
]

{ #category : #accessing }
CpWaInterfaceInstaller >> selectAttributesFromType [

	"Create a Dictionary with attribute name -> attribute object (Dictionary) from the current type"

	typeAttributes := Dictionary newFrom: ((type at: #attributes)
		collect: [ :each | (each at: #name) -> each ])
]

{ #category : #'accessing - field members' }
CpWaInterfaceInstaller >> selectEventFromFieldMember: eventMemberDictionary [

	"Add a new event from the specified field member"

	| event |

	event := (CpWaInterfaceEvent new
		name: (eventMemberDictionary at: #name) ;
		yourself).

	"Add event properties"
	(eventMemberDictionary at: #members ifAbsent: [ #() ]) do: [ :each |
		(self from: each atPath: #(kind)) = #field
			ifTrue: [ event addPropertyName: (each at: #name) typeDescription: each ] ].

	events add: event
]

{ #category : #accessing }
CpWaInterfaceInstaller >> selectEvents [

	"Select events"

	self eventMembersDo: [ :each |
		self selectEventFromFieldMember: each ]
]

{ #category : #'accessing - field members' }
CpWaInterfaceInstaller >> selectMethodFromFieldMember: methodMemberDictionary [

	"Add a new method from the specified field member"

	| method |

	method := (CpWaInterfaceMethod new
		name: (methodMemberDictionary at: #name) ;
		returnTypeDescription: (self from: methodMemberDictionary atPath: #(return type text)) ;
		description: (self descriptionFromMember: methodMemberDictionary) ;
		instanceSide: (methodMemberDictionary at: #static ifPresent: [ :static | static not ] ifAbsent: [ true ]) ;
		yourself).

	"Add method parameters"
	(methodMemberDictionary at: #parameters ifAbsent: [ #() ]) withIndexDo: [ :each :index |
		| name |
		name := each at: #name.
		(name beginsWith: '{')
			ifTrue: [ name := 'param', index printString ].
		method addParameterName: name typeDescription: each ].

	methods add: method.

	"Also add any alternatives (with optional parameters removed)"
	methods addAll: method createAlternatives
]

{ #category : #accessing }
CpWaInterfaceInstaller >> selectMethods [

	"Select methods for the current type"

	self methodMembersFromElementDo: [ :each |
		self selectMethodFromFieldMember: each ]
]

{ #category : #accessing }
CpWaInterfaceInstaller >> selectProperties [

	"Select properties for the current type.

	Implementation:
	The attribute definitions for the current type and current element are also selected,
	because some member definitions (from the current element) do not provide all required
	information to create a Property. These member definitions however contain more than
	is available in the attributes (or in the 'js.properties' field which we therefore do
	not use at the moment)."

	"We're using the attribute definitions from both the current type and current element"
	self
		selectAttributesFromType ;
		selectAttributesFromElement.

	"Perform some sanity checks on the definitions"
	typeAttributes keysDo: [ :each |
		(elementAttributes includesKey: each)
			ifFalse: [ self warnCr: 'Attribute "', each, '" present in type definition, but not in element definition' ] ].

	elementAttributes keysDo: [ :each |
		(typeAttributes includesKey: each)
			ifFalse: [ self warnCr: 'Attribute "', each, '" present in element definition, but not in type definition' ] ].

	"Select all properties using the members of the current element"
	self fieldMembersFromElementDo: [ :each |
		self selectPropertyFromFieldMember: each ]
]

{ #category : #'accessing - field members' }
CpWaInterfaceInstaller >> selectPropertyFromFieldMember: fieldMemberDictionary [

	"Add a new property from the specified field member.

	Implementation:
	If no type can be derived from this field member, do NOT add it."

	| property |

	property := (CpWaInterfaceProperty new
		name: (fieldMemberDictionary at: #name) ;
		typeDescription: (self fieldTypeFromFieldMember: fieldMemberDictionary) ;
		defaultValue: (self defaultValueFromFieldMember: fieldMemberDictionary) ;
		description: (self descriptionFromMember: fieldMemberDictionary) ;
		readonly: (fieldMemberDictionary at: #readonly ifAbsent: [ false ]) ;
		instanceSide: (fieldMemberDictionary at: #static ifPresent: [ :static | static not ] ifAbsent: [ true ]) ;
		yourself).

	"Skip some unwanted static properties"
	(property instanceSide not and: [ #(css validators) includes: property name ])
		ifTrue: [
			self traceCr: 'Skipping property ', property name.
			^ self ].

	properties add: property
]

{ #category : #accessing }
CpWaInterfaceInstaller >> setupType: aDictionary [

	"Select the relevant definitions (type and element) for the specified type.

	Implementation:
	Modules have a declaration and exports. We are only interested in the declaration.
	So ignore the bigger module and only answer its (element) declaration."

	| tagName |

	type := aDictionary.
	tagName := type at: #name.
	element := (((elementDict at: #modules) detect: [ :each | self isModule: each forTag: tagName ])
		at: #declarations)
			detect: [ :each | self isClassDeclaration: each ]
			ifNone: [ self halt ].

	"(Re)set the properties and methods for this type"
	properties := Set new.
	methods := Set new
]

{ #category : #accessing }
CpWaInterfaceInstaller >> typesDo: aBlock [

	(self from: typeDict atPath: #(contributions html elements))
		do: aBlock
]

{ #category : #accessing }
CpWaInterfaceInstaller >> valueFromString: aString [

	aString = #true
		ifTrue: [ ^ true ].
	aString = #false
		ifTrue: [ ^ false ].
	(aString = #undefined or: [ aString = #null ])
		ifTrue: [ ^ nil ].
	(aString isNotEmpty and: [ aString first = $' and: [ aString last = $' ] ])
		ifTrue: [ ^ aString copyFrom: 2 to: aString size - 1 ].
	aString = #Infinity
		ifTrue: [ ^ Float infinity ].
	(aString allSatisfy: [ :each | each isDigit ])
		ifTrue: [ ^ Number readFrom: aString ].

	"Very special case, but let's just play along"
	aString = 'new Date()'
		ifTrue: [ ^ DateAndTime now ].

self halt.
	^ nil
]

{ #category : #accessing }
CpWaInterfaceInstaller >> version [

	^ typeDict at: #version
]
