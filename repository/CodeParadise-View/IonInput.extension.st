Extension { #name : #IonInput }

{ #category : #'*CodeParadise-View' }
IonInput >> bindUsingSpec: aStream for: aModel [

	"Create binding using the view specification provided in the Stream"

	| token |

	token := aStream next.

	token = #property
		ifTrue: [
			| property |
			property := CpProperty on: aModel name: aStream next.
			self when: SlInputEvent do: [ property value: self value ] for: self.
			property whenChangedDo: [ self value: property value ] for: self.
			^ self].

	self error: 'Unknown binding specifier: ', token printString
]

{ #category : #'*CodeParadise-View' }
IonInput >> destroy [

	super destroy.

	self traceCr: 'Removed IonInput element'
]