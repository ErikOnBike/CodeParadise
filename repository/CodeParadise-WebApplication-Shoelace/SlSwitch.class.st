Class {
	#name : #SlSwitch,
	#superclass : #SlFormControl,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #'accessing control' }
SlSwitch >> beChecked [

	self attributeAt: #checked put: ''
]

{ #category : #'accessing control' }
SlSwitch >> beDisabled [

	self attributeAt: #disabled put: ''
]

{ #category : #'accessing control' }
SlSwitch >> beNotChecked [

	self removeAttributeAt: #checked
]

{ #category : #'accessing control' }
SlSwitch >> beNotDisabled [

	self removeAttributeAt: #disabled
]

{ #category : #'accessing control' }
SlSwitch >> isChecked [

	^ (self attributeAt: #checked) notNil
]

{ #category : #'accessing control' }
SlSwitch >> isDisabled [

	^ (self attributeAt: #disabled) notNil
]
