Extension { #name : #IonToolbar }

{ #category : #'*CodeParadise-Canyon-App' }
IonToolbar >> ensureButtonsAt: aString [

	"Ensure an IonButtons element is present for the specified 'side'"

	^ (self allDescendantsMatching: IonButtons asCssSelector)
		detect: [ :each | each slot = aString ]
		ifNone: [ self appendChild: IonButtons new atSlotNamed: aString ]
]

{ #category : #'*CodeParadise-Canyon-App' }
IonToolbar >> updateButtonsStart: startCollection end: endCollection [

	"Update the receiver to show IonButton elements on the start and end side"

	| buttons |

	"Buttons at start (left)"
	buttons := self ensureButtonsAt: #start.
	buttons children do: [ :each | each destroy ].
	startCollection do: [ :each | buttons appendChild: each ].

	"Buttons at end (right)"
	buttons := self ensureButtonsAt: #end.
	buttons children do: [ :each | each destroy ].
	endCollection do: [ :each | buttons appendChild: each ]
]
