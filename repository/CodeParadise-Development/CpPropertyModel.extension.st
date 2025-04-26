Extension { #name : #CpPropertyModel }

{ #category : #'*CodeParadise-Development' }
CpPropertyModel class >> generatePropertyGetterFor: aCompiledMethod [

	| sourceCode protocolName |

	sourceCode := String streamContents: [ :stream |
		stream
			nextPutAll: aCompiledMethod selector ; cr.
		aCompiledMethod comments
			ifNotEmpty: [ :comments |
				comments do: [ :each |
					stream
						cr ;
						tab ; nextPutAll: each asComment ; cr ] ]
			ifEmpty: [
				stream
					cr ;
					tab ; nextPutAll: '"Answer the value of the property ' ; nextPutAll: aCompiledMethod selector ; nextPut: $" ; cr ].
		stream
			cr ;
			tab ; nextPutAll: '^ self propertyAt: #' ; nextPutAll: aCompiledMethod selector ].

	protocolName := aCompiledMethod protocol isUnclassifiedProtocol
		ifTrue: [ 'accessing' ]
		ifFalse: [ aCompiledMethod protocolName ].

	self compile: sourceCode classified: protocolName
]

{ #category : #'*CodeParadise-Development' }
CpPropertyModel class >> generatePropertySetterFor: aCompiledMethod [

	| comments type argument sourceCode protocolName |

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
			(('AEIOU' includes: type first)
				ifTrue: [ 'an' ]
				ifFalse: [ 'a' ]), type ].

	sourceCode := String streamContents: [ :stream |
		stream
			nextPutAll: aCompiledMethod selector ; nextPut: $: ; space ; nextPutAll: argument ; cr.
		comments
			ifNotEmpty: [
				comments do: [ :each |
					stream
						cr ;
						tab ; nextPutAll: each asComment ; cr ] ]
			ifEmpty: [
				stream
					cr ;
					tab ; nextPutAll: '"Set the value of the property ' ; nextPutAll: aCompiledMethod selector ; nextPutAll: ' to the specified value"' ; cr ].
		stream
			cr ;
			tab ; nextPutAll: 'self propertyAt: #' ; nextPutAll: aCompiledMethod selector ; nextPutAll: ' put: ' ; nextPutAll: argument ].

	protocolName := aCompiledMethod protocol isUnclassifiedProtocol
		ifTrue: [ 'accessing' ]
		ifFalse: [ aCompiledMethod protocolName ].

	self compile: sourceCode classified: protocolName
]
