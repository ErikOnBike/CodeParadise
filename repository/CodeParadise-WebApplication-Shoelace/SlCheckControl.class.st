Class {
	#name : #SlCheckControl,
	#superclass : #SlFormControl,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #testing }
SlCheckControl class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #'accessing style' }
SlCheckControl >> beChecked [

	self checked: true
]

{ #category : #'accessing style' }
SlCheckControl >> beNotChecked [

	self checked: false
]

{ #category : #accessing }
SlCheckControl >> checked: aBoolean [

	self propertyAt: #checked put: aBoolean
]

{ #category : #actions }
SlCheckControl >> click [

	"Simulate a click on the checkbox"

	self apply: #click withArguments: #()
]

{ #category : #testing }
SlCheckControl >> isChecked [

	^ self propertyAt: #checked
]
