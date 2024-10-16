Extension { #name : #CpPropertyModel }

{ #category : #'*CodeParadise-View' }
CpPropertyModel >> viewOn: anElement [

	self viewSpec
		renderViewFor: self on: anElement
]

{ #category : #'*CodeParadise-View' }
CpPropertyModel >> viewSpec [

	^ (self viewSpecForState: self viewState)
		ifNil: [ self error: 'No view spec for the current state: ', self viewState asString ]
]

{ #category : #'*CodeParadise-View' }
CpPropertyModel >> viewSpecForState: aSymbol [

	| viewSpecSelector |

	viewSpecSelector := aSymbol
		ifNotNil: [ aSymbol, #ViewSpec ]
		ifNil: [ #viewSpec ].

	^ (self class classSide canUnderstand: viewSpecSelector)
		ifTrue: [ self class perform: viewSpecSelector ]
		ifFalse: [ nil ]
]

{ #category : #'*CodeParadise-View' }
CpPropertyModel >> viewState [

	"Answer a Symbol representing the view state of the receiver
	or nil if the receiver is in the default view state"

	^ nil
]
