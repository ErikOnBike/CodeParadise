Extension { #name : #CpDomElement }

{ #category : #'*CodeParadise-View' }
CpDomElement class >> appendElementUsingSpec: aStream for: aModel on: anElement [

	"Append an Element to the specified Element using the ViewSpec on the provided Stream"

	| classOrTagName childElement |

	classOrTagName := aStream next.
	childElement := classOrTagName first isUppercase
		ifTrue: [ (Smalltalk classNamed: classOrTagName) new ]
		ifFalse: [ self newWithTag: classOrTagName ].

	childElement renderUsingSpec: aStream for: aModel.

	anElement appendChild: childElement
]

{ #category : #'*CodeParadise-View' }
CpDomElement >> bindUsingSpec: aStream for: aModel [

	"Create binding using the view specification provided in the Stream.
	Subclasses should override this method."

	self shouldBeImplemented
]

{ #category : #'*CodeParadise-View' }
CpDomElement >> renderAttributesUsingSpec: aStream for: aModel [

	"Render the attributes using the view specifiction provided in the Stream"

	[ aStream atEnd ] whileFalse: [
		self attributeAt: aStream next put: (aStream next asViewValueFor: aModel) ]
]

{ #category : #'*CodeParadise-View' }
CpDomElement >> renderItemUsingSpec: aStream for: aModel [

	| token |

	token := aStream next.

	"Render children"
	token isArray
		ifTrue: [ ^ token renderElementFor: aModel on: self ].

	token = #attrs
		ifTrue: [ ^ self renderAttributesUsingSpec: aStream next readStream for: aModel ].

	token = #props
		ifTrue: [ ^ self renderPropertiesUsingSpec: aStream next readStream for: aModel ].

	token = #textContent
		ifTrue: [ ^ self textContent: (aStream next asViewValueFor: aModel) ].

	token = #bind
		ifTrue: [ ^ self bindUsingSpec: aStream next readStream for: aModel ].

	self error: 'Unknown token ', token printString
]

{ #category : #'*CodeParadise-View' }
CpDomElement >> renderPropertiesUsingSpec: aStream for: aModel [

	"Render the properties using the view specifiction provided in the Stream"

	[ aStream atEnd ] whileFalse: [
		self propertyAt: aStream next put: (aStream next asViewValueFor: aModel) ]
]

{ #category : #'*CodeParadise-View' }
CpDomElement >> renderUsingSpec: aStream for: aModel [

	"Render the element using the view specification provided in the Stream"

	[ aStream atEnd ] whileFalse: [
		self renderItemUsingSpec: aStream for: aModel ]
]
