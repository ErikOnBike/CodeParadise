Extension { #name : #ReadStream }

{ #category : #'*CodeParadise-WebApplication' }
ReadStream >> lookAheadAt: index [

	"Answer the element at the specified (delta) position or nil if outside the receiver boundaries."

	| lookPosition |

	lookPosition := position + index.
	(lookPosition < 1 or: [ lookPosition > readLimit ])
		ifTrue: [ ^ nil ].

	^ collection at: lookPosition
]
