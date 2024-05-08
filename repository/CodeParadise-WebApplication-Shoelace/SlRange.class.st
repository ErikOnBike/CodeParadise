Class {
	#name : 'SlRange',
	#superclass : 'SlFormControl',
	#category : 'CodeParadise-WebApplication-Shoelace-Elements',
	#package : 'CodeParadise-WebApplication-Shoelace',
	#tag : 'Elements'
}

{ #category : 'accessing' }
SlRange >> help [

	"Answer the help HTML element of the receiver.
	For a simple String value use #helpText instead."

	^ self firstChildAtSlotNamed: #'help-text'
]

{ #category : 'accessing' }
SlRange >> help: aStringOrElement [

	"Set the help text to the specified Element.
	For a simple String value use #helpText: instead."

	self replaceAllChildrenWith: aStringOrElement asHtmlElement atSlotNamed: #'help-text'
]

{ #category : 'accessing' }
SlRange >> helpText [

	"Answer the help text (a String) of the receiver.
	For richer HTML element use #help instead."

	^ self help textContent
]

{ #category : 'accessing' }
SlRange >> helpText: aString [

	"Set the help text to the specified String value.
	For richer HTML element use #help: instead."

	self help: aString asHtmlElement
]

{ #category : 'accessing' }
SlRange >> label [

	"Answer the label HTML element of the receiver.
	For a simple String value use #labelText instead."

	^ self firstChildAtSlotNamed: #label
]

{ #category : 'accessing' }
SlRange >> label: aStringOrElement [

	"Set the label to the specified Element.
	For a simple String value use #labelText: instead."

	self replaceAllChildrenWith: aStringOrElement asHtmlElement atSlotNamed: #label
]

{ #category : 'accessing' }
SlRange >> labelText [

	"Answer the label text (a String) of the receiver.
	For richer HTML element use #label instead."

	^ self label
		ifNotNil: [ :label | label textContent ]
		ifNil: [ '' ]
]

{ #category : 'accessing' }
SlRange >> labelText: aString [

	"Set the label text to the specified String value.
	For richer HTML element use #label: instead."

	self label: aString asHtmlElement
]

{ #category : 'accessing' }
SlRange >> max [

	^ self propertyAt: #max
]

{ #category : 'accessing' }
SlRange >> max: aNumber [

	self propertyAt: #max put: aNumber
]

{ #category : 'accessing' }
SlRange >> min [

	^ self propertyAt: #min
]

{ #category : 'accessing' }
SlRange >> min: aNumber [

	self propertyAt: #min put: aNumber
]

{ #category : 'accessing' }
SlRange >> step [

	^ self propertyAt: #step
]

{ #category : 'accessing' }
SlRange >> step: aNumber [

	self propertyAt: #step put: aNumber
]

{ #category : 'as yet unclassified' }
SlRange >> tooltip [

	^ self propertyAt: #tooltip
]

{ #category : 'as yet unclassified' }
SlRange >> tooltip: aString [

	"Set tooltip position to: #top (default) | #bottom | #none"

	self propertyAt: #tooltip put: aString
]
