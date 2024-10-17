Extension { #name : #CpPropertyModel }

{ #category : #'*CodeParadise-View' }
CpPropertyModel class >> exampleViewSpec [

	^ #(
		(IonItem
			textContent (selector taskDescription)
		)
		(IonList
			(IonItem
				(IonInput
					attrs (label 'Email' type 'email' autocomplete 'email' placeholder 'naam@domein.nl')
					props (debounce 1000)
					bind (property email)
				)
			)
			(IonItem
				(IonInput
					attrs (label 'Wachtwoord' type 'password' autocomplete 'current-password' placeholder 'EenLangWachtwoordIsBeter')
					bind (property password)
				)	
			)
			(IonItem
				(IonButton
					textContent 'Inloggen'
					attrs (color 'primary' expand 'block')
					bind (selector login)
				)
			)
		)
	)
]

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

{ #category : #'*CodeParadise-View' }
CpPropertyModel >> viewValueUsingSpec: aStream [

	| token |
	
	aStream size = 2
		ifFalse: [ self error: 'Unknown value specification ', aStream contents printString ].

	token := aStream next.

	token = #selector
		ifTrue: [ ^ self perform: aStream next ].

	token = #property
		ifTrue: [ ^ self propertyAt: aStream next ].

	self error: 'Unknown value specifier: ', token printString
]
