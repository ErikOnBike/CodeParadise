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
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
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

self halt.
	componentClass := (componentName includesSubstring: 'Legacy')
		ifTrue: [ nil ]
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

	self installMethod: (self
		sourceCodeMethod: selectorString
		comment: commentString
		code: '^ self propertyAt: #', selectorString).

	type := ((typeString indexOf: $') > 0 or: [ (typeString indexOf: $") > 0 or: [ typeString = 'string' or: [ typeString = 'Color' ] ] ])
		ifTrue: [ 'aString' ]
		ifFalse: [
			typeString = 'boolean'
				ifTrue: [ 'aBoolean' ]
				ifFalse: [
					typeString = 'number'
						ifTrue: [ 'aNumber' ]
						ifFalse: [ 'anObject' ] ] ].

	self installMethod: (self
		sourceCodeMethod: selectorString, ': ', type
		comment: commentString
		code: 'self propertyAt: #', selectorString, ' put: ', type)
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
	type := stream upTo: $;.

	"Now create and install methods (getter and setter or single method)"
	self installMethodsForAccessor: accessorName comment: comment type: type optional: isOptional.

	stream skipSeparators
]

{ #category : #installing }
CpIonInterfaceInstaller >> installMethod: aString [

	componentClass ifNil: [ ^ self ].

	"componentClass compile: aString classified: 'api'"
	self traceCr: 'Install the following method in ', componentClass name.
	self traceCr: (aString replaceAll: Character lf with: Character cr)
]

{ #category : #installing }
CpIonInterfaceInstaller >> installMethod: selectorString comment: commentString type: typeString [

	| arguments methodCount |

	arguments := self parseArguments: typeString.
	methodCount := (arguments select: [ :each | each at: 3 ]) size.		"Count optional arguments"

	"Create the methods with optional arguments"
	1 to: methodCount do: [ :count |
		| selector code actualArgs sourceCode |

		actualArgs := OrderedCollection new.
		selector := String streamContents: [ :selectorStream |
			
			"Add the required arguments"
			1 to: arguments size - methodCount do: [ :argIndex |
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
			arguments size - methodCount + 1 to: arguments size - methodCount + count do: [ :argIndex |
				| argumentName |
				argumentName := (arguments at: argIndex) at: 1.
				argIndex = 1
					ifTrue: [ selectorStream nextPutAll: selectorString ]
					ifFalse: [ selectorStream space ; nextPutAll: argumentName ].
				selectorStream
					nextPutAll: ': ' ;
					nextPutAll: argumentName.
				actualArgs add: argumentName ] ].

		code := String streamContents: [ :codeStream |
			codeStream 
				nextPutAll: '^ self apply: #' ;
				nextPutAll: selectorString ;
				nextPutAll: ' withArguments: { ' ;
				nextPutAll: (' . ' join: actualArgs) ;
				nextPutAll: ' }' ].

		sourceCode := self sourceCodeMethod: selector comment: commentString code: code.
		self installMethod: sourceCode ]
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

	| finalComment isFunction |

	finalComment := (String streamContents: [ :commentStream |
		commentStream
			nextPutAll: commentString ;
			nextPut: Character lf ;
			nextPutAll: 'Type: ' ;
			nextPutAll: typeString ;
			nextPut: Character lf ]).
	isFunction := typeString includesSubstring: ' => '.

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
		name := name allButLast.

		"Add argument to the collection"
		arguments add: { name . type . optional }.
	
		typeStream skipSeparators ].

	^ arguments
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
