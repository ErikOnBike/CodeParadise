Extension { #name : #CpAbstractOptions }

{ #category : #'*CodeParadise-Development' }
CpAbstractOptions class >> generatePropertyGetterFor: aCompiledMethod [

	| sourceCode protocolName |

	aCompiledMethod numArgs = 0
		ifFalse: [ ^ self ].

	sourceCode := String streamContents: [ :stream |
		stream
			nextPutAll: aCompiledMethod selector ; cr.
		aCompiledMethod comments do: [ :each |
			stream
				cr ;
				tab ; nextPutAll: each asComment ; cr ].
		stream
			cr ;
			tab ; nextPutAll: '^ options at: #' ; nextPutAll: aCompiledMethod selector ].

	protocolName := aCompiledMethod protocol isUnclassifiedProtocol
		ifTrue: [ 'accessing' ]
		ifFalse: [ aCompiledMethod protocolName ].

	self compile: sourceCode classified: protocolName
]

{ #category : #'*CodeParadise-Development' }
CpAbstractOptions class >> generatePropertySetterFor: aCompiledMethod [

	| comments type argument propertyName sourceCode protocolName |

	argument := aCompiledMethod numArgs = 1
		ifTrue: [ aCompiledMethod argumentNames first ]
		ifFalse: [
			comments := aCompiledMethod comments.
			comments do: [ :each |
				| index |
				index := each findString: 'Type:'.
				index > 0
					ifTrue: [
						| parseString tokens |
						parseString := (each allButFirst: index + 4) trim.
						tokens := parseString findTokens: Character separators.
						tokens ifNotEmpty: [
							| typeValue |
							typeValue := tokens first asSymbol.
							(CpJavaScriptClass classForTypeName: typeValue from: self)
								ifNotNil: [ type := typeValue ] ] ] ].

			type ifNil: [ ^ self ].

			"Prepend a or an"
			argument := (('AEIOU' includes: type first)
				ifTrue: [ 'an' ]
				ifFalse: [ 'a' ]), type ].

	propertyName := aCompiledMethod selector withoutSuffix: ':'.
	sourceCode := String streamContents: [ :stream |
		stream
			nextPutAll: propertyName ; nextPut: $: ; space ; nextPutAll: argument ; cr.
		aCompiledMethod comments do: [ :each |
			stream
				cr ;
				tab ; nextPutAll: each asComment ; cr ].
		stream
			cr ;
			tab ; nextPutAll: 'options at: #' ; nextPutAll: propertyName ; nextPutAll: ' put: ' ; nextPutAll: argument ].

	protocolName := aCompiledMethod protocol isUnclassifiedProtocol
		ifTrue: [ 'accessing' ]
		ifFalse: [ aCompiledMethod protocolName ].

	self compile: sourceCode classified: protocolName
]
