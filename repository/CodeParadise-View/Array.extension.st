Extension { #name : #Array }

{ #category : #'*CodeParadise-View' }
Array >> asViewValueFor: aModel [

	<webApplicationExtension>

	^ aModel viewValueUsingSpec: self readStream
]

{ #category : #'*CodeParadise-View' }
Array >> renderElementFor: aModel on: anElement [

	<webApplicationExtension>

	"Render the receiver (assumed to be a element specification) on the specified Element"

	CpDomElement appendElementUsingSpec: self readStream for: aModel on: anElement
]

{ #category : #'*CodeParadise-View' }
Array >> renderViewFor: aModel on: anElement [

	<webApplicationExtension>

	"Render the receiver (assumed to be a view specification) on the specified Element"

	self do: [ :each |
		each renderElementFor: aModel on: anElement ]
]
