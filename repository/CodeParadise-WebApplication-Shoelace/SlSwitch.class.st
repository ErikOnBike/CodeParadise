Class {
	#name : #SlSwitch,
	#superclass : #SlFormControl,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #'accessing style' }
SlSwitch >> beChecked [

	self checked: true
]

{ #category : #'accessing style' }
SlSwitch >> beNotChecked [

	self checked: false
]

{ #category : #accessing }
SlSwitch >> checked: aBoolean [

	self propertyAt: #checked put: aBoolean
]

{ #category : #testing }
SlSwitch >> isChecked [

	^ self propertyAt: #checked
]
