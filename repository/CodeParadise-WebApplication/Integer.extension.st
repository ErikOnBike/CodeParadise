Extension { #name : #Integer }

{ #category : #'*CodeParadise-WebApplication' }
Integer >> bitCount [

	"Answer the number of bits of the receiver with value 1.

	Implementation: This method will fail on negative numbers."

	<webApplicationExtension>

	| bitCount value |

	self negative
		ifTrue: [ self error: 'It is not possible to ask for the bit count on a negative number' ].

	bitCount := 0.
	value := self.
	[ value > 0 ] whileTrue: [
		(value bitAnd: 1) = 1
			ifTrue: [ bitCount := bitCount + 1 ].
		value := value bitShift: -1 ].

	^ bitCount
]
