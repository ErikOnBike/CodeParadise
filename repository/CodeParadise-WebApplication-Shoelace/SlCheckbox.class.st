Class {
	#name : #SlCheckbox,
	#superclass : #SlCheckControl,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlCheckbox class >> label: aString [

	^ self new
		label: aString ;
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

{ #category : #accessing }
SlCheckbox >> label [

	^ self textContent
]

{ #category : #accessing }
SlCheckbox >> label: aString [

	self textContent: aString
]
