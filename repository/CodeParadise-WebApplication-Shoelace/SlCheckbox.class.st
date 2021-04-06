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

{ #category : #'accessing control' }
SlCheckbox >> beChecked [

	self attributeAt: #checked put: ''
]

{ #category : #'accessing style' }
SlCheckbox >> beDisabled [

	self attributeAt: #disabled put: ''
]

{ #category : #'accessing control' }
SlCheckbox >> beIndeterminate [

	self attributeAt: #indeterminate put: ''
]

{ #category : #'accessing control' }
SlCheckbox >> beNotChecked [

	self removeAttributeAt: #checked
]

{ #category : #'accessing style' }
SlCheckbox >> beNotDisabled [

	self removeAttributeAt: #disabled
]

{ #category : #'accessing control' }
SlCheckbox >> beNotIndeterminate [

	self removeAttributeAt: #indeterminate
]

{ #category : #'accessing control' }
SlCheckbox >> isChecked [

	^ (self attributeAt: #checked) notNil
]

{ #category : #'accessing style' }
SlCheckbox >> isDisabled [

	^ (self attributeAt: #disabled) notNil
]

{ #category : #'accessing control' }
SlCheckbox >> isIndeterminate [

	^ (self attributeAt: #indeterminate) notNil
]

{ #category : #accessing }
SlCheckbox >> label: aString [

	self textContent: aString
]
