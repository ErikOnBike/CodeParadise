Extension { #name : #String }

{ #category : #'*CodeParadise-WebApplication' }
String >> asCssSelector [

	<webApplicationExtension>

	^ self
]

{ #category : #'*CodeParadise-WebApplication' }
String >> asHtmlElement [

	<webApplicationExtension>

	^ self inHtmlTag: #span
]

{ #category : #'*CodeParadise-WebApplication' }
String >> asHtmlTag [ 

	<webApplicationExtension>

	^ CpHtmlElement newWithTag: self
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
		'OSProcess' asKebabCase -> 'os-process'

	Implementation:
	Use two consecutive characters to decide if the 'skewer' should be shown (2 cases).
	IF first is lowercase AND second is uppercase THEN show: <first>-
	IF first is uppercase AND second is lowercase THEN show: -<first>

	Reason for this algorithm is that a 'string' of uppercase characters should be
	regarded as a whole. This avoids results as 'OSProcess' to become 'o-s-process'."

	<webApplicationExtension>

	self ifEmpty: [ ^ '' ].

	^ self class streamContents: [ :stream |

		| charToWrite hasSkewer |

		charToWrite := self first.
		hasSkewer := true.	"This prevents that the result starts with a 'skewer'"
		self allButFirstDo: [ :each |
			each isUppercase
				ifTrue: [
					charToWrite isUppercase
						ifTrue: [
							stream nextPut: charToWrite asLowercase.
							hasSkewer := false ]
						ifFalse: [
							stream
								nextPut: charToWrite ;
								nextPut: $-.
							hasSkewer := true ] ]
				ifFalse: [
					charToWrite isUppercase
						ifTrue: [
							"Do not write two 'skewers' after each other"
							hasSkewer
								ifFalse: [ stream nextPut: $- ].
							stream nextPut: charToWrite asLowercase ]
						ifFalse: [ stream nextPut: charToWrite ].
					hasSkewer := false ].
			charToWrite := each ].

		"Write last character (unknown if it is upper- or lowercase)"
		stream nextPut: charToWrite asLowercase ]
]

{ #category : #'*CodeParadise-WebApplication' }
String >> asRegularFontAwesomeIcon [

	<webApplicationFontAwesomeExtension>
	<ignoreReference: #CpHtmlElement>

	^ (CpHtmlElement newWithTag: #i)
		attributeAt: #class put: 'far fa-', self
]

{ #category : #'*CodeParadise-WebApplication' }
String >> asSolidFontAwesomeIcon [

	<webApplicationFontAwesomeExtension>
	<ignoreReference: #CpHtmlElement>

	^ (CpHtmlElement newWithTag: #i)
		attributeAt: #class put: 'fas fa-', self
]

{ #category : #'*CodeParadise-WebApplication' }
String >> inHtmlTag: tagString [

	<webApplicationExtension>

	^ (CpHtmlElement newWithTag: tagString)
		textContent: self ;
		yourself
]
