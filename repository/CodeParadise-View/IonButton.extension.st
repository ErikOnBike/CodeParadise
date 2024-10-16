Extension { #name : #IonButton }

{ #category : #'*CodeParadise-View' }
IonButton >> bindUsingSpec: aStream for: aModel [

	"Create binding using the view specification provided in the Stream"

	| token |

	token := aStream next.

	token = #selector
		ifTrue: [
			self when: CpClickEvent send: aStream next to: aModel.
			^ self].

	self error: 'Unknown binding specifier: ', token printString
]
