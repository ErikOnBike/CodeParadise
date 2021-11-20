Class {
	#name : #SlCheckControl,
	#superclass : #SlFormControl,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

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
