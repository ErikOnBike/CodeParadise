"
I am an interface installer. I can read the current Ionic component interfaces and
will install all components and their interfaces.
You can use me repeatedly. Any interface conflicts that arise will be signalled so
nothing will be overwritten accidentally.

You can start me using the following:
	CpIonInterfaceInstaller installAll
"
Class {
	#name : #CpIonInterfaceInstaller,
	#superclass : #Object,
	#instVars : [
		'stream',
		'componentClass'
	],
	#category : #'CodeParadise-WebApplication-Ionic-Support'
}

{ #category : #actions }
CpIonInterfaceInstaller class >> installAll [

	<script>

	| interfaceDefinition stream expectedPrefix |

	self traceCr: 'Reading Ionic framework components'.
	interfaceDefinition := ZnClient new
		get: 'https://github.com/ionic-team/ionic-framework/raw/refs/heads/main/core/src/components.d.ts' ;
		contents.

	"Assume a specific content here (for now), since the file itself is generated.
	There is some comments on the top. Then follows a set of import and export statements.
	Next are the interface definitions we're interested in. Skip the rest."
	self traceCr: 'Parsing component definitions'.
	expectedPrefix := 'interface Ion'.
	stream := interfaceDefinition readStream.

	"Skip comments and import/export statements"
	stream skipSeparators.
	[ stream atEnd not and: [ (stream hasNextAll: expectedPrefix) not ] ] whileTrue: [
		stream
			skipTo: Character lf ;
			skipSeparators ].

	"Handle interface definition"
	[ stream atEnd not and: [ stream hasNextAll: expectedPrefix ] ] whileTrue: [
		self installFromStream: stream ].

	self traceCr: 'Done'
]

{ #category : #'instance creation' }
CpIonInterfaceInstaller class >> installFromStream: aStream [

	(self on: aStream)
		install
]

{ #category : #'instance creation' }
CpIonInterfaceInstaller class >> on: aStream [

	^ self basicNew
		initializeWithStream: aStream ;
		yourself
]

{ #category : #initialization }
CpIonInterfaceInstaller >> initializeWithStream: aStream [

	self initialize.

	stream := aStream
]

{ #category : #installing }
CpIonInterfaceInstaller >> install [

	"Install the interface definition on the receiver's Stream"

	self
		installClass ;
		installMethods
]

{ #category : #installing }
CpIonInterfaceInstaller >> installClass [

	"Install class, assume the stream contains: interface <component name> {"

	| componentName |

	"Skip 'interface '"
	stream skip: 10.

	"Read component name"
	componentName := stream upTo: Character space.
	(componentName beginsWith: #Ion)
		ifFalse: [ self error: 'Unexpected component name, expecting it to start with "Ion" but found: ', componentName ].

	"Skip ' {'"
	stream skipSeparators.
	(stream peekFor: ${)
		ifFalse: [ self error: 'Unexpected format, assumed curly brace after interface name. Working on interface for: ', componentName ].
	stream skipSeparators.

	componentClass := (componentName includesSubstring: 'Legacy')
		ifFalse: [
			(Smalltalk classNamed: componentName)
				ifNil: [
					self traceCr: 'Creating new component ', componentName.
					(IonElement << componentName
						tag: 'Elements';
						package: 'CodeParadise-WebApplication-Ionic') install ] ]
]

{ #category : #installing }
CpIonInterfaceInstaller >> installGetterAndSetter: selectorString comment: commentString type: typeString [ 

	| type |

	self
		installMethod: (self
			sourceCodeMethod: selectorString
			comment: commentString
			code: '^ self propertyAt: #', selectorString)
		selector: selectorString asSymbol.

	type := self typeFromTypeString: typeString.
	type := (type first isVowel
		ifTrue: [ 'an' ]
		ifFalse: [ 'a' ]), type.

	self
		installMethod: (self
			sourceCodeMethod: selectorString, ': ', type
			comment: commentString
			code: 'self propertyAt: #', selectorString, ' put: ', type)
		selector: (selectorString, ':') asSymbol
]

{ #category : #installing }
CpIonInterfaceInstaller >> installMethod [

	| comment accessorName isOptional type |

	comment := String streamContents: [ :commentStream |

		"Parse comment for method description (if any)"
		stream skipSeparators.
		(stream hasNextAll: '/**', String lf)
			ifTrue: [
				stream skip: 4.
				stream skipSeparators.
				[ stream hasNextAll: '* ' ] whileTrue: [
					stream skip: 2.
					commentStream
						nextPutAll: (stream upTo: Character lf) ;
						nextPut: Character lf.
					stream skipSeparators ].
				(stream hasNextAll: '*/')
					ifFalse: [ self error: 'Unexpected format, no end of comment found' ].
				stream skip: 2.
				stream skipSeparators ] ].

	"Read the selector (property or method) name"
	(stream peekFor: $")
		ifFalse: [ self error: 'Unexpected format, no double quote found starting an accessor' ].
	accessorName := stream upTo: $".

	"Skip optional 'optional' flag"
	isOptional := stream peekFor: $?.

	"Skip separator between selector and type definition"
	(stream hasNextAll: ':')
		ifFalse: [ self error: 'Unexpected format, no separator between selector and type found' ].
	stream skip: 1.
	stream skipSeparators.

	"Read type definition"
	type := (stream upTo: $;) trim.

	"Now create and install methods (getter and setter or single method)"
	self installMethodsForAccessor: accessorName comment: comment type: type optional: isOptional.

	stream skipSeparators
]

{ #category : #installing }
CpIonInterfaceInstaller >> installMethod: selectorString arguments: arguments optionals: optionalCount comment: commentString type: typeString [

	"Install the method with its optional arguments"

	| totalOptionalCount selector code actualArgs sourceCode |

	totalOptionalCount := (arguments select: [ :each | each at: 3 ]) size.		"Count optional arguments"

	actualArgs := OrderedCollection new.
	selector := String streamContents: [ :selectorStream |
		
		"Add the required arguments"
		1 to: arguments size - totalOptionalCount do: [ :argIndex |
			| argumentName |
			argumentName := (arguments at: argIndex) at: 1.
			argIndex = 1
				ifTrue: [ selectorStream nextPutAll: selectorString ]
				ifFalse: [ selectorStream space ; nextPutAll: argumentName ].
			selectorStream
				nextPutAll: ': ' ;
				nextPutAll: argumentName.
			actualArgs add: argumentName ].

		"Add the optional arguments"
		arguments size - totalOptionalCount + 1 to: arguments size - totalOptionalCount + optionalCount do: [ :argIndex |
			| argumentName |
			argumentName := (arguments at: argIndex) at: 1.
			argIndex = 1
				ifTrue: [ selectorStream nextPutAll: selectorString ]
				ifFalse: [ selectorStream space ; nextPutAll: argumentName ].
			selectorStream
				nextPutAll: ': ' ;
				nextPutAll: argumentName.
			actualArgs add: argumentName ] ].

	"In case there are no required arguments"
	selector ifEmpty: [ selector := selectorString ].

	"Build the code"
	code := String streamContents: [ :codeStream |
		codeStream 
			nextPutAll: '^ self apply: #' ;
			nextPutAll: selectorString.
		actualArgs ifNotEmpty: [
			codeStream
				nextPutAll: ' withArguments: { ' ;
				nextPutAll: (' . ' join: actualArgs) ;
				nextPutAll: ' }' ].
		(self resultTypeFromTypeString: typeString) ifNotNil: [ :resultType |
			codeStream
				nextPutAll: ' resultAs: ' ;
				nextPutAll: resultType ] ].

	sourceCode := self sourceCodeMethod: selector comment: commentString code: code.
	self installMethod: sourceCode selector: (self selectorSymbolFrom: selector)
]

{ #category : #installing }
CpIonInterfaceInstaller >> installMethod: selectorString comment: commentString type: typeString [

	"Install the method, including ones for optional arguments"

	| arguments optionalCount |

	arguments := self parseArguments: typeString.
	optionalCount := (arguments select: [ :each | each at: 3 ]) size.		"Count optional arguments"

	0 to: optionalCount do: [ :count |
		self installMethod: selectorString arguments: arguments optionals: count comment: commentString type: typeString ]
]

{ #category : #installing }
CpIonInterfaceInstaller >> installMethod: aString selector: aSymbol [

	| normalizedSourceCode |

	componentClass ifNil: [ ^ self ].

	normalizedSourceCode := aString replaceAll: Character lf with: Character cr.

	"Check for presence of existing method"
	(componentClass includesSelector: aSymbol)
		ifTrue: [
			| sourceCode |
			sourceCode := (componentClass >> aSymbol) sourceCode.

			sourceCode = normalizedSourceCode
				ifFalse: [ self halt ] ].

	componentClass compile: aString classified: 'api'
]

{ #category : #installing }
CpIonInterfaceInstaller >> installMethods [

	[  stream atEnd not and: [ (stream hasNextAll: '}') not ] ] whileTrue: [
		self installMethod ].

	(stream peekFor: $})
		ifFalse: [ self error: 'Unexpected format, missing closing curly brace' ].
	stream skipSeparators
]

{ #category : #installing }
CpIonInterfaceInstaller >> installMethodsForAccessor: selectorString comment: commentString type: typeString optional: aBoolean [

	| functionIndex isFunction finalType finalComment |

	functionIndex := typeString indexOfSubCollection: ' => '.

	"Current (20241019) a single property (IonModel >> #canDismiss:) allows both a boolean and a function, check for specific situation of such combinations"
	isFunction := functionIndex > 0 and: [ (typeString findTokens: '|') noneSatisfy: [ :each | #('boolean' 'string' 'number') includes: each trim ] ].
	finalType := (isFunction and: [ typeString beginsWith: '()' ])
		ifTrue: [ (typeString allButFirst: functionIndex + 3) trim ] "Do not show useless () =>, in other situations do show it"
		ifFalse: [ typeString ].

	finalComment := (String streamContents: [ :commentStream |
		commentString ifNotEmpty: [
			commentStream
				nextPutAll: commentString ;
				nextPut: Character lf ].
		commentStream
			nextPutAll: 'Type: ' ;
			nextPutAll: finalType ;
			nextPut: Character lf ]).

	isFunction
		ifTrue: [ self installMethod: selectorString comment: finalComment type: typeString ]
		ifFalse: [ self installGetterAndSetter: selectorString comment: finalComment type: typeString ]
]

{ #category : #accessing }
CpIonInterfaceInstaller >> parseArguments: aString [

	"Parse the type definition to extract the function arguments"

	| arguments typeStream |

	arguments := OrderedCollection new.
	typeStream := aString readStream.

	"Skip opening brace"
	typeStream upTo: $(.
	typeStream skipSeparators.

	[ typeStream hasNextAll: ')' ] whileFalse: [
		| name type optional |

		"Read argument name"
		name := (typeStream upTo: $:) trim.

		"Read type"
		type := typeStream upToAny: ',)'.
		typeStream back = $,
			ifTrue: [ typeStream skip: 1 ].

		"Decide if argument is optional (not most solid check, but suffices here)"
		optional := name endsWith: '?'.
		optional
			ifTrue: [ name := name allButLast ].

		"Add argument to the collection"
		arguments add: { name . type . optional }.
	
		typeStream skipSeparators ].

	^ arguments
]

{ #category : #accessing }
CpIonInterfaceInstaller >> resultTypeFromTypeString: aString [

	"Answer the most likely result type defined in the specified String.
	Only non-trivial types are answered (i.e. in which case #resultAs: is
	relevant for the #apply:withArguments:resultAs method)."

	| resultType |

	resultType := self typeFromTypeString: aString.

	^ (#('String' 'Number' 'Boolean') includes: resultType)
		ifFalse: [
			resultType = 'Promise'
				ifTrue: [ CpJavaScriptPromise name ]
				ifFalse: [
					(Smalltalk classNamed: resultType) isNotNil
						ifTrue: [ resultType ] ] ]
]

{ #category : #accessing }
CpIonInterfaceInstaller >> selectorSymbolFrom: selectorString [

	"Remove the arguments from the selector String"

	| selector |

	selector := String streamContents: [ :selectorStream |
		| readStream |
		readStream := selectorString readStream.
		[  readStream atEnd ] whileFalse: [
			"Add selector part"
			selectorStream nextPutAll: (readStream upTo: $:).
			readStream atEnd
				ifFalse: [
					selectorStream nextPut: $:.

					"Remove argument (surrounded by spaces)"
					readStream skip: 1.
					readStream upTo: Character space ] ] ].

	^ selector asSymbol
]

{ #category : #accessing }
CpIonInterfaceInstaller >> sourceCodeMethod: selectorString comment: commentString code: codeString [

	^ String streamContents: [ :sourceStream |

		"Selector (optionally with argument already added)"
		sourceStream nextPutAll: selectorString.

		"Add end of line and additional empty line"
		sourceStream lf ;
			lf.

		"Add comment"
		commentString ifNotEmpty: [
			| addLf doIndent |

			sourceStream tab ; nextPut: $".
			doIndent := false.
			addLf := false.
			commentString do: [ :each |
				addLf ifTrue: [
					sourceStream lf ; tab.
					addLf := false ].
				(each = $` or: [ each = $" ])
					ifTrue: [ sourceStream nextPut: $' ]
					ifFalse: [
						each = Character lf
							ifTrue: [ addLf := true ]
							ifFalse: [ sourceStream nextPut: each ] ] ].
			sourceStream
				nextPut: $" ; lf ;
				lf ].

		"Finally add the method code (always single line delegating to JavaScript object)"
		sourceStream tab ; nextPutAll: codeString ]
]

{ #category : #accessing }
CpIonInterfaceInstaller >> typeFromTypeString: aString [

	"Answer the most likely type defined in the specified String.

	Implementation:
	Some assumptions are done here. When a quote is present, it is assumed to be for
	a property (not a function). Similarly, the presence of '=> Promise' assumes this
	is the result of a function."

	| isString |

	"Strings come in different shapes and sizes"
	isString := (aString indexOf: $') > 0 or: [ (aString indexOf: $") > 0 or: [ aString = 'string' or: [ aString = 'Color' ] ] ].
	isString ifFalse: [
		| alternatives |

		"A combination of String types and undefined/null are accepted as String. Also the combination 'string | string[]'"
		alternatives := aString findTokens: '|'.
		(alternatives allSatisfy: [ :each | #('string' 'string[]' 'null' 'undefined' 'Color') includes: each trim ])
			ifTrue: [
				"Additional check for something like: 'string[] | undefined' which should not be considered a String"
				((aString includesSubstring: 'string[]') not or: [ (aString occurrencesOf: 'string') > 1 ])
					ifTrue: [ isString := true ] ] ].

	^ isString
		ifTrue: [ 'String' ]
		ifFalse: [
			aString = 'boolean'
				ifTrue: [ 'Boolean' ]
				ifFalse: [
					aString = 'number'
						ifTrue: [ 'Number' ]
						ifFalse: [
							(aString isAllAlphaNumerics and: [ (Smalltalk classNamed: aString capitalized) isNotNil ])
								ifTrue: [ aString capitalized ]
								ifFalse: [
									(aString includesSubstring: '=> Promise')
										ifTrue: [ 'Promise' ]
										ifFalse: [ 'Object' ] ] ] ] ]
]
