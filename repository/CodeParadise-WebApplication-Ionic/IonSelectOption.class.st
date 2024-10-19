Class {
	#name : #IonSelectOption,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonSelectOption >> disabled [

	"If 'true', the user cannot interact with the select option. This property does not apply when 'interface='action-sheet'' as 'ion-action-sheet' does not allow for disabled buttons.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonSelectOption >> disabled: aBoolean [

	"If 'true', the user cannot interact with the select option. This property does not apply when 'interface='action-sheet'' as 'ion-action-sheet' does not allow for disabled buttons.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonSelectOption >> value [

	"The text value of the option.
	
	Type: any | null"

	^ self propertyAt: #value
]

{ #category : #api }
IonSelectOption >> value: anObject [

	"The text value of the option.
	
	Type: any | null"

	self propertyAt: #value put: anObject
]
