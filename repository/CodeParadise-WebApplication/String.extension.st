Extension { #name : #String }

{ #category : #'*CodeParadise-WebApplication' }
String >> asCssSelector [

	^ self

]

{ #category : #'*CodeParadise-WebApplication' }
String >> asHtmlElement [

	<webApplicationExtension>

	^ self inHtmlTag: #span
]

{ #category : #'*CodeParadise-WebApplication' }
String >> asKebabCase [

	"Answer the receiver using kebab-case.
	Assume the receiver has either camelCase or PascalCase value (ie no spaces present).

	For example:
		'Object' asKebabCase -> 'object'
		'CodeParadise' asKebabCase -> 'code-paradise'
		'ReadWriteStream' asKebabCase -> 'read-write-stream'
		'asString' asKebabCase -> 'as-string'
		'asKebabCase' asKebabCase -> 'as-kebab-case'
	"

	self ifEmpty: [ ^ '' ].

	^ self class streamContents: [ :stream |

		"Simply copy first character"
		stream nextPut: self first asLowercase.

		self allButFirstDo: [ :each |
			each isUppercase
				ifTrue: [ stream nextPut: $- ].
			stream nextPut: each asLowercase ] ]
]

{ #category : #'*CodeParadise-WebApplication' }
String >> asRegularFontAwesomeIcon [

	<webApplicationFontAwesomeExtension>

	^ ((Smalltalk classNamed: #CpHtmlElement) newWithTag: #i)
		attributeAt: #class put: 'far fa-', self
]

{ #category : #'*CodeParadise-WebApplication' }
String >> asSolidFontAwesomeIcon [

	<webApplicationFontAwesomeExtension>

	^ ((Smalltalk classNamed: #CpHtmlElement) newWithTag: #i)
		attributeAt: #class put: 'fas fa-', self
]

{ #category : #'*CodeParadise-WebApplication' }
String >> inHtmlTag: tagString [

	<webApplicationExtension>

	^ ((Smalltalk classNamed: #CpHtmlElement) newWithTag: tagString)
		textContent: self ;
		yourself
]
