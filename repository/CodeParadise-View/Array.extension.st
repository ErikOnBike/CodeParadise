Extension { #name : #Array }

{ #category : #'*CodeParadise-View' }
Array >> asViewValueFor: aModel [

	self size = 2
		ifFalse: [ self error: 'Unknown value specifiction ', self printString ].

	^ self first = #selector
		ifTrue: [ aModel perform: self second ]
		ifFalse: [ self error: 'Unknown value specifier: ', self first printString ]
]

{ #category : #'*CodeParadise-View' }
Array >> renderViewFor: aModel on: anElement [

	"Render the receiver (assumed to be a view specification) on the specified Element"

	| stream className childElement |

	stream := ReadStream on: self.

	className := stream next.
	childElement := (Smalltalk classNamed: className) new.

	[ stream atEnd ] whileFalse: [
		| token |
		token := stream next.
		token = #textContent
			ifTrue: [ childElement textContent: (stream next asViewValueFor: aModel) ]
			ifFalse: [ self error: 'Unknown token ', token printString ] ].

	anElement appendChild: childElement
]
