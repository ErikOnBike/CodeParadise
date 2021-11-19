Class {
	#name : #SlCheckbox,
	#superclass : #SlFormControl,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlCheckbox class >> label: aString [

	^ self new
		label: aString ;
		yourself
]

{ #category : #'accessing style' }
SlCheckbox >> beChecked [

	self checked: true
]

{ #category : #'accessing style' }
SlCheckbox >> beIndeterminate [

	self indeterminate: true
]

{ #category : #'accessing style' }
SlCheckbox >> beNotChecked [

	self checked: false
]

{ #category : #'accessing style' }
SlCheckbox >> beNotIndeterminate [

	self indeterminate: false
]

{ #category : #accessing }
SlCheckbox >> checked: aBoolean [

	self propertyAt: #checked put: aBoolean
]

{ #category : #actions }
SlCheckbox >> click [

	"Simulate a click on the checkbox"

	self apply: #click withArguments: #()
]

{ #category : #accessing }
SlCheckbox >> indeterminate: aBoolean [

	self propertyAt: #indeterminate put: aBoolean
]

{ #category : #testing }
SlCheckbox >> isChecked [

	^ self propertyAt: #checked
]

{ #category : #testing }
SlCheckbox >> isIndeterminate [

	^ self propertyAt: #indeterminate
]

{ #category : #accessing }
SlCheckbox >> label [

	^ self textContent
]

{ #category : #accessing }
SlCheckbox >> label: aString [

	self textContent: aString
]
