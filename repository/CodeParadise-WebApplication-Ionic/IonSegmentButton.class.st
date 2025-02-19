Class {
	#name : #IonSegmentButton,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonSegmentButton >> contentId [

	"The 'id' of the segment content.
	
	Type: string"

	^ self propertyAt: #contentId
]

{ #category : #api }
IonSegmentButton >> contentId: aString [

	"The 'id' of the segment content.
	
	Type: string"

	self propertyAt: #contentId put: aString
]

{ #category : #api }
IonSegmentButton >> disabled [

	"If 'true', the user cannot interact with the segment button.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonSegmentButton >> disabled: aBoolean [

	"If 'true', the user cannot interact with the segment button.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonSegmentButton >> layout [

	"Set the layout of the text and icon in the segment.
	
	Type: SegmentButtonLayout"

	^ self propertyAt: #layout
]

{ #category : #api }
IonSegmentButton >> layout: anObject [

	"Set the layout of the text and icon in the segment.
	
	Type: SegmentButtonLayout"

	self propertyAt: #layout put: anObject
]

{ #category : #api }
IonSegmentButton >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonSegmentButton >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonSegmentButton >> setFocus [

	"Type: Promise<void>"

	^ self apply: #setFocus resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonSegmentButton >> type [

	"The type of the button.
	
	Type: 'submit' | 'reset' | 'button'"

	^ self propertyAt: #type
]

{ #category : #api }
IonSegmentButton >> type: aString [

	"The type of the button.
	
	Type: 'submit' | 'reset' | 'button'"

	self propertyAt: #type put: aString
]

{ #category : #api }
IonSegmentButton >> value [

	"The value of the segment button.
	
	Type: SegmentValue"

	^ self propertyAt: #value
]

{ #category : #api }
IonSegmentButton >> value: anObject [

	"The value of the segment button.
	
	Type: SegmentValue"

	self propertyAt: #value put: anObject
]
