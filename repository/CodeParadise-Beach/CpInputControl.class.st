Class {
	#name : #CpInputControl,
	#superclass : #CpControl,
	#category : #'CodeParadise-Beach-Components'
}

{ #category : #testing }
CpInputControl class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #'state handling' }
CpInputControl >> beReadOnly [

	"Make the receiver read only.

	Implementation:
	In contrast with CpControl >> #disable do not update children since
	the receiver does not have input control children."

	(self attributeAt: #readonly)
		ifNil: [ self attributeAdd: #readonly ]
]

{ #category : #private }
CpInputControl >> beReadOnlySecondary [

	"Make the receiver read only because an ancestor is read only.
	
	Implementation:
	In contrast with CpControl >> #enable do not update children since
	the receiver does not have input control children."

	(self attributeAt: #readonly)
		ifNil: [ self attributeAt: #readonly put: #parent ]
]

{ #category : #'state handling' }
CpInputControl >> beWritable [

	"Make the receiver writable.

	Implementation:
	In contrast with CpControl >> #enable do not update children since
	the receiver does not have input control children."

	(self attributeAt: #readonly)
		ifNotNil: [ :readOnly |

			"Only allow making primary read only elements writable (instead of secundary read only elements)"
			readOnly = #parent
				ifFalse: [

					"Update read only state depending on parent state"
					(self parent attributeAt: #readonly)
						ifNotNil: [ self attributeAt: #readonly put: #parent ]
						ifNil: [ self removeAttributeAt: #readonly ] ] ]
]

{ #category : #private }
CpInputControl >> beWritableSecondary [

	"Make the receiver writable because an ancestor is writable.
	
	Implementation:
	In contrast with CpControl >> #enable do not update children since
	the receiver does not have input control children."

	(self attributeAt: #readonly)
		ifNotNil: [ :readOnly |

			"Only allow making secundary read only elements writable"
			readOnly = #parent
				ifTrue: [ self removeAttributeAt: #readonly ] ]
]

{ #category : #'testing - conditionals' }
CpInputControl >> ifReadOnly: aBlock [

	"Evaluate a Block if the receiver is in read only state"

	self ifWritable: [ "intentionally empty" ] ifReadOnly: aBlock
]

{ #category : #'testing - conditionals' }
CpInputControl >> ifWritable: aBlock [

	"Evaluate a Block if the receiver is writable"

	self ifWritable: aBlock ifReadOnly: [ "intentionally empty" ]
]

{ #category : #'testing - conditionals' }
CpInputControl >> ifWritable: writableBlock ifReadOnly: readOnlyBlock [

	"Evaluate a Block depending on the receiver's read only state"

	(self attributeAt: #readonly)
		ifNotNil: [ readOnlyBlock value ]
		ifNil: [ writableBlock value ]
]
