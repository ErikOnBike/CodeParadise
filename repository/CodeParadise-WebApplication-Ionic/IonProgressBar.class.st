Class {
	#name : #IonProgressBar,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonProgressBar >> buffer [

	"If the buffer and value are smaller than 1, the buffer circles will show. The buffer should be between [0, 1].
	
	Type: number"

	^ self propertyAt: #buffer
]

{ #category : #api }
IonProgressBar >> buffer: aNumber [

	"If the buffer and value are smaller than 1, the buffer circles will show. The buffer should be between [0, 1].
	
	Type: number"

	self propertyAt: #buffer put: aNumber
]

{ #category : #api }
IonProgressBar >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonProgressBar >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonProgressBar >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonProgressBar >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonProgressBar >> reversed [

	"If true, reverse the progress bar direction.
	
	Type: boolean"

	^ self propertyAt: #reversed
]

{ #category : #api }
IonProgressBar >> reversed: aBoolean [

	"If true, reverse the progress bar direction.
	
	Type: boolean"

	self propertyAt: #reversed put: aBoolean
]

{ #category : #api }
IonProgressBar >> type [

	"The state of the progress bar, based on if the time the process takes is known or not. Default options are: ''determinate'' (no animation), ''indeterminate'' (animate from left to right).
	
	Type: 'determinate' | 'indeterminate'"

	^ self propertyAt: #type
]

{ #category : #api }
IonProgressBar >> type: aString [

	"The state of the progress bar, based on if the time the process takes is known or not. Default options are: ''determinate'' (no animation), ''indeterminate'' (animate from left to right).
	
	Type: 'determinate' | 'indeterminate'"

	self propertyAt: #type put: aString
]

{ #category : #api }
IonProgressBar >> value [

	"The value determines how much of the active bar should display when the 'type' is ''determinate''. The value should be between [0, 1].
	
	Type: number"

	^ self propertyAt: #value
]

{ #category : #api }
IonProgressBar >> value: aNumber [

	"The value determines how much of the active bar should display when the 'type' is ''determinate''. The value should be between [0, 1].
	
	Type: number"

	self propertyAt: #value put: aNumber
]
