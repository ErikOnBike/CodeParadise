Class {
	#name : #SlCheckbox,
	#superclass : #SlCheckControl,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlCheckbox class >> label: aStringOrElement [

	^ self new
		label: aStringOrElement ;
		yourself
]

{ #category : #'accessing style' }
SlCheckbox >> beIndeterminate [

	self indeterminate: true
]

{ #category : #'accessing style' }
SlCheckbox >> beNotIndeterminate [

	self indeterminate: false
]

{ #category : #accessing }
SlCheckbox >> indeterminate: aBoolean [

	self propertyAt: #indeterminate put: aBoolean
]

{ #category : #testing }
SlCheckbox >> isIndeterminate [

	^ self propertyAt: #indeterminate
]
