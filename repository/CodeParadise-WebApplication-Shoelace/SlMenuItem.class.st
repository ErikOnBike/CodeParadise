Class {
	#name : #SlMenuItem,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #'instance creation' }
SlMenuItem class >> value: aSymbol label: aString [

	^ self new
		value: aSymbol ;
		labelText: aString ;
		yourself
]

{ #category : #accessing }
SlMenuItem >> beChecked [

	self checked: true
]

{ #category : #accessing }
SlMenuItem >> beDisabled [

	self disabled: true
]

{ #category : #accessing }
SlMenuItem >> beEnabled [

	"Convenience method to make receiver enabled"

	self disabled: false
]

{ #category : #accessing }
SlMenuItem >> beNotChecked [

	self checked: false
]

{ #category : #accessing }
SlMenuItem >> beNotDisabled [

	self disabled: false
]

{ #category : #accessing }
SlMenuItem >> beNotEnabled [

	"Convenience method to clear the enabled state of the receiver"

	self disabled: true
]

{ #category : #accessing }
SlMenuItem >> checked: aBoolean [

	self propertyAt: #checked put: aBoolean
]

{ #category : #accessing }
SlMenuItem >> disabled: aBoolean [

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
SlMenuItem >> enabled: aBoolean [

	"Convenience method to set receiver's enabled state"

	self disabled: aBoolean not
]

{ #category : #accessing }
SlMenuItem >> isChecked [

	^ self propertyAt: #checked
]

{ #category : #accessing }
SlMenuItem >> isDisabled [

	^ self propertyAt: #disabled
]

{ #category : #accessing }
SlMenuItem >> isEnabled [

	"Convenience method to test if receiver is enabled"

	^ self isDisabled not
]

{ #category : #accessing }
SlMenuItem >> labelText [

	"Answer the label text (a String) of the receiver"

	^ self textContent
]

{ #category : #accessing }
SlMenuItem >> labelText: aString [

	"Set the label text to the specified String value"

	self textContent: aString
]

{ #category : #accessing }
SlMenuItem >> prefix [

	^ self firstChildAtSlotNamed: #prefix
]

{ #category : #accessing }
SlMenuItem >> prefix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #prefix
]

{ #category : #accessing }
SlMenuItem >> suffix [

	^ self firstChildAtSlotNamed: #suffix
]

{ #category : #accessing }
SlMenuItem >> suffix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #suffix
]

{ #category : #accessing }
SlMenuItem >> value [

	^ self propertyAt: #value
]

{ #category : #accessing }
SlMenuItem >> value: aString [

	self propertyAt: #value put: aString asString
]
