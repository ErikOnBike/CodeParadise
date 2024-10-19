Class {
	#name : #IonSelectPopover,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonSelectPopover >> header [

	"The header text of the popover
	
	Type: string"

	^ self propertyAt: #header
]

{ #category : #api }
IonSelectPopover >> header: aString [

	"The header text of the popover
	
	Type: string"

	self propertyAt: #header put: aString
]

{ #category : #api }
IonSelectPopover >> message [

	"The text content of the popover body
	
	Type: string"

	^ self propertyAt: #message
]

{ #category : #api }
IonSelectPopover >> message: aString [

	"The text content of the popover body
	
	Type: string"

	self propertyAt: #message put: aString
]

{ #category : #api }
IonSelectPopover >> multiple [

	"If true, the select accepts multiple values
	
	Type: boolean"

	^ self propertyAt: #multiple
]

{ #category : #api }
IonSelectPopover >> multiple: aBoolean [

	"If true, the select accepts multiple values
	
	Type: boolean"

	self propertyAt: #multiple put: aBoolean
]

{ #category : #api }
IonSelectPopover >> options [

	"An array of options for the popover
	
	Type: SelectPopoverOption[]"

	^ self propertyAt: #options
]

{ #category : #api }
IonSelectPopover >> options: anObject [

	"An array of options for the popover
	
	Type: SelectPopoverOption[]"

	self propertyAt: #options put: anObject
]

{ #category : #api }
IonSelectPopover >> subHeader [

	"The subheader text of the popover
	
	Type: string"

	^ self propertyAt: #subHeader
]

{ #category : #api }
IonSelectPopover >> subHeader: aString [

	"The subheader text of the popover
	
	Type: string"

	self propertyAt: #subHeader put: aString
]
