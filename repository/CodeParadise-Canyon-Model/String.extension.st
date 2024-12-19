Extension { #name : #String }

{ #category : #'*CodeParadise-Canyon-Model' }
String >> formatKnown: aCollection [

	<applicationExtension>

	"Format the receiver by interpolating elements from the collection specified.
	In contrast with #format: any unknown elements are left intact (instead of
	being replaced by 'nil')."

	^ self class
		new: self size
		streamContents: [ :result |
			| stream |
			stream := self readStream.
			[ stream atEnd ]
				whileFalse: [ | currentChar |
					(currentChar := stream next) == ${
						ifTrue: [ | expression index |
							expression := stream upTo: $}.
							index := expression asNumberOrNil ifNil: [ expression ].
							(aCollection at: index ifAbsent: [ nil ])
								ifNotNil: [ :replacement | result nextPutAll: replacement asString ]
								ifNil: [ result nextPut: ${ ; nextPutAll: expression ; nextPut: $} ] ]
						ifFalse: [ currentChar == $\
								ifTrue: [ stream atEnd
										ifFalse: [ result nextPut: stream next ] ]
								ifFalse: [ result nextPut: currentChar ] ] ] ]
]
