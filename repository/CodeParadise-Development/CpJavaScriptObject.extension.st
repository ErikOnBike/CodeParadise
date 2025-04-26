Extension { #name : #CpJavaScriptObject }

{ #category : #'*CodeParadise-Development' }
CpJavaScriptObject class >> generateApplyFor: aCompiledMethod [

	| selector arguments methodName comments type sourceCode protocolName |

	selector := aCompiledMethod selector.
	arguments := aCompiledMethod argumentNames.

	methodName := selector isKeyword
		ifTrue: [ selector keywords first allButLast ]
		ifFalse: [ selector ].

	comments := aCompiledMethod comments.
	comments do: [ :each |
		| index |
		index := each findString: 'Return:'.
		index > 0
			ifTrue: [
				| parseString tokens |
				parseString := (each allButFirst: index + 6) trim.
				tokens := parseString findTokens: Character separators.
				tokens ifNotEmpty: [
					| typeValue |
					typeValue := tokens first asSymbol.
					(typeValue = #self or: [ typeValue = #void ])
						ifTrue: [ type := #self ]
						ifFalse: [
							(CpJavaScriptClass classForTypeName: typeValue)
								ifNotNil: [ :class | type := class name ] ] ] ] ].

	sourceCode := String streamContents: [ :stream |
		selector isKeyword
			ifTrue: [
				selector keywords withIndexDo: [ :keyword :index |
					index > 1
						ifTrue: [ stream space ].
					stream
						nextPutAll: keyword ;
						space ;
						nextPutAll: (arguments at: index) ] ]
			ifFalse: [ stream nextPutAll: selector ].
		stream cr.
		comments do: [ :each |
			stream
				cr ;
				tab ; nextPutAll: each asComment ; cr ].
		stream
			cr ;
			tab.
		type = #self
			ifTrue: [ type := nil ]
			ifFalse: [ stream nextPutAll: '^ ' ].
		stream nextPutAll: 'self apply: #' ; nextPutAll: methodName.
		arguments ifNotEmpty: [
			stream nextPutAll: ' withArguments: {'.
			arguments withIndexDo: [ :each :index |
				index > 1
					ifTrue: [ stream nextPutAll: ' .' ].				
				stream
					space ;
					nextPutAll: each ].
			stream nextPutAll: ' }' ].
		type ifNotNil: [
			stream nextPutAll: ' resultAs: ' ; nextPutAll: type ] ].

	protocolName := aCompiledMethod protocol isUnclassifiedProtocol
		ifTrue: [ 'operations' ]
		ifFalse: [ aCompiledMethod protocolName ].

	self compile: sourceCode classified: protocolName
]

{ #category : #'*CodeParadise-Development' }
CpJavaScriptObject class >> generatePropertyGetterFor: aCompiledMethod [

	| sourceCode protocolName |

	sourceCode := String streamContents: [ :stream |
		stream
			nextPutAll: aCompiledMethod selector ; cr.
		aCompiledMethod comments do: [ :each |
			stream
				cr ;
				tab ; nextPutAll: each asComment ; cr ].
		stream
			cr ;
			tab ; nextPutAll: '^ self propertyAt: #' ; nextPutAll: aCompiledMethod selector ].

	protocolName := aCompiledMethod protocol isUnclassifiedProtocol
		ifTrue: [ 'accessing' ]
		ifFalse: [ aCompiledMethod protocolName ].

	self compile: sourceCode classified: protocolName
]
