Extension { #name : #String }

{ #category : #'*CodeParadise-Canyon-Model' }
String >> formatKnown: aCollection [

	<canyonModelExtension>

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
						ifTrue: [ | expression index replacement |
							expression := stream upTo: $}.
							index := expression asNumberOrNil.
							replacement := index
								ifNotNil: [ aCollection at: index ifAbsent: [ nil ] ]
								ifNil: [
									"SequenceableCollection has numeric indices and we have a name here (will result in 'nil' for SequenceableCollection)"
									(aCollection isKindOf: SequenceableCollection)
										ifFalse: [ aCollection at: expression ifAbsent: [ nil ] ] ].
							replacement
								ifNotNil: [ result nextPutAll: replacement asString ]
								ifNil: [ result nextPut: ${ ; nextPutAll: expression ; nextPut: $} ] ]
						ifFalse: [ currentChar == $\
								ifTrue: [ stream atEnd
										ifFalse: [ result nextPut: stream next ] ]
								ifFalse: [ result nextPut: currentChar ] ] ] ]
]
