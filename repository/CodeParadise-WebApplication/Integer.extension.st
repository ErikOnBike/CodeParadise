Extension { #name : #Integer }

{ #category : #'*CodeParadise-WebApplication' }
Integer >> bitCount [

	"Answer the number of bits of the receiver with value 1.

	Implementation: This method will fail on negative numbers."

	| bitCount value |

	self negative
		ifTrue: [ self error: 'It is not possible to ask for the bit count on a negative number' ].

	bitCount := 0.
	value := self.
	[ value isZero ] whileFalse: [
		(value bitAnd: 1) isZero
			ifFalse: [ bitCount := bitCount + 1 ].
		value := value bitShift: -1 ].

	^ bitCount
]
