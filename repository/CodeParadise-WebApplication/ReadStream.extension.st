Extension { #name : #ReadStream }

{ #category : #'*CodeParadise-WebApplication' }
ReadStream >> lookAheadAt: index [

	"Answer the element at the specified (delta) position or nil if outside the receiver's boundaries."

	| lookPosition |

	lookPosition := position + 1 + index.	"The #position is 0-based"
	(lookPosition < 1 or: [ lookPosition > readLimit ])
		ifTrue: [ ^ nil ].

	^ collection at: lookPosition
]
