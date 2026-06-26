Class {
	#name : #WaProgressBar,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #convenience }
WaProgressBar >> beIndeterminate [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self indeterminate: true
]

{ #category : #convenience }
WaProgressBar >> beNotIndeterminate [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self indeterminate: false
]

{ #category : #accessing }
WaProgressBar >> indeterminate [

	"When true, percentage is ignored, the label is hidden, and the progress bar is drawn in an indeterminate state.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #indeterminate
]

{ #category : #accessing }
WaProgressBar >> indeterminate: aBoolean [

	"When true, percentage is ignored, the label is hidden, and the progress bar is drawn in an indeterminate state.
	
	Type: Boolean
	Default: false"

	self propertyAt: #indeterminate put: aBoolean
]

{ #category : #accessing }
WaProgressBar >> label [

	"A custom label for assistive devices.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaProgressBar >> label: aString [

	"A custom label for assistive devices.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #accessing }
WaProgressBar >> value [

	"The current progress as a percentage, 0 to 100.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaProgressBar >> value: aNumber [

	"The current progress as a percentage, 0 to 100.
	
	Type: Number
	Default: 0"

	self propertyAt: #value put: aNumber
]
