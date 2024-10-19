Class {
	#name : #IonSegment,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonSegment >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonSegment >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonSegment >> disabled [

	"If 'true', the user cannot interact with the segment.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonSegment >> disabled: aBoolean [

	"If 'true', the user cannot interact with the segment.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonSegment >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonSegment >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonSegment >> scrollable [

	"If 'true', the segment buttons will overflow and the user can swipe to see them. In addition, this will disable the gesture to drag the indicator between the buttons in order to swipe to see hidden buttons.
	
	Type: boolean"

	^ self propertyAt: #scrollable
]

{ #category : #api }
IonSegment >> scrollable: aBoolean [

	"If 'true', the segment buttons will overflow and the user can swipe to see them. In addition, this will disable the gesture to drag the indicator between the buttons in order to swipe to see hidden buttons.
	
	Type: boolean"

	self propertyAt: #scrollable put: aBoolean
]

{ #category : #api }
IonSegment >> selectOnFocus [

	"If 'true', navigating to an 'ion-segment-button' with the keyboard will focus and select the element. If 'false', keyboard navigation will only focus the 'ion-segment-button' element.
	
	Type: boolean"

	^ self propertyAt: #selectOnFocus
]

{ #category : #api }
IonSegment >> selectOnFocus: aBoolean [

	"If 'true', navigating to an 'ion-segment-button' with the keyboard will focus and select the element. If 'false', keyboard navigation will only focus the 'ion-segment-button' element.
	
	Type: boolean"

	self propertyAt: #selectOnFocus put: aBoolean
]

{ #category : #api }
IonSegment >> swipeGesture [

	"If 'true', users will be able to swipe between segment buttons to activate them.
	
	Type: boolean"

	^ self propertyAt: #swipeGesture
]

{ #category : #api }
IonSegment >> swipeGesture: aBoolean [

	"If 'true', users will be able to swipe between segment buttons to activate them.
	
	Type: boolean"

	self propertyAt: #swipeGesture put: aBoolean
]

{ #category : #api }
IonSegment >> value [

	"the value of the segment.
	
	Type: SegmentValue"

	^ self propertyAt: #value
]

{ #category : #api }
IonSegment >> value: anObject [

	"the value of the segment.
	
	Type: SegmentValue"

	self propertyAt: #value put: anObject
]
