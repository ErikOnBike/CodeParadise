Class {
	#name : 'SlRating',
	#superclass : 'SlIcon',
	#category : 'CodeParadise-WebApplication-Shoelace-Elements',
	#package : 'CodeParadise-WebApplication-Shoelace',
	#tag : 'Elements'
}

{ #category : 'accessing' }
SlRating >> disabled [

	^ self propertyAt: #disabled
]

{ #category : 'accessing' }
SlRating >> disabled: aBoolean [

	self propertyAt: #disabled put: aBoolean
]

{ #category : 'accessing' }
SlRating >> label [

	"Answer the label HTML element of the receiver.
	For a simple String value use #labelText instead."

	^ self firstChildAtSlotNamed: #label
]

{ #category : 'accessing' }
SlRating >> label: aStringOrElement [

	"Set the label to the specified Element.
	For a simple String value use #labelText: instead."

	self replaceAllChildrenWith: aStringOrElement asHtmlElement atSlotNamed: #label
]

{ #category : 'accessing' }
SlRating >> labelText [

	"Answer the label text (a String) of the receiver.
	For richer HTML element use #label instead."

	^ self label
		ifNotNil: [ :label | label textContent ]
		ifNil: [ '' ]
]

{ #category : 'accessing' }
SlRating >> labelText: aString [

	"Set the label text to the specified String value.
	For richer HTML element use #label: instead."

	self label: aString asHtmlElement
]

{ #category : 'accessing' }
SlRating >> max [

	^ self propertyAt: #max
]

{ #category : 'accessing' }
SlRating >> max: aNumber [

	self propertyAt: #max put: aNumber
]

{ #category : 'accessing' }
SlRating >> precision [

	^ self propertyAt: #precision
]

{ #category : 'accessing' }
SlRating >> precision: aFloat [

	self propertyAt: #precision put: aFloat
]

{ #category : 'accessing' }
SlRating >> readOnly [

	^ self propertyAt: #readOnly
]

{ #category : 'accessing' }
SlRating >> readOnly: aBoolean [

	self propertyAt: #readOnly put: aBoolean
]

{ #category : 'accessing' }
SlRating >> value [

	^ self propertyAt: #value
]

{ #category : 'accessing' }
SlRating >> value: aNumber [

	self propertyAt: #mvalue put: aNumber
]
