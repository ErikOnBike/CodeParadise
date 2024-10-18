Extension { #name : #ReadStream }

{ #category : #'*CodeParadise-WebApplication' }
ReadStream >> hasNextAll: aCollection [

	"Answer whether the following elements are exactly equal to the ones given in the Collection"

	| maxPosition |

	maxPosition := position + 1 + aCollection size.	"The #position is 0-based"
	maxPosition  > readLimit
		ifTrue: [ ^ false ].

	aCollection withIndexDo: [ :each :index |
		each = (collection at: (position + index))
			ifFalse: [ ^ false ] ].

	^ true
]

{ #category : #'*CodeParadise-WebApplication' }
ReadStream >> lookAheadAt: index [

	"Answer the element at the specified (delta) position or nil if outside the receiver's boundaries."

	| lookPosition |

	lookPosition := position + 1 + index.	"The #position is 0-based"
	(lookPosition < 1 or: [ lookPosition > readLimit ])
		ifTrue: [ ^ nil ].

	^ collection at: lookPosition
]
