Class {
	#name : #SlFormControl,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #tags }
SlFormControl class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #'accessing style' }
SlFormControl >> beDisabled [

	self disabled: true
]

{ #category : #'accessing style' }
SlFormControl >> beEnabled [

	"Convenience method to make receiver enabled"

	self disabled: false
]

{ #category : #'accessing style' }
SlFormControl >> beInvalid [

	self invalid: true
]

{ #category : #'accessing style' }
SlFormControl >> beNotDisabled [

	self disabled: false
]

{ #category : #'accessing style' }
SlFormControl >> beNotEnabled [

	"Convenience method to clear the enabled state of the receiver"

	self disabled: true
]

{ #category : #'accessing style' }
SlFormControl >> beNotInvalid [

	self invalid: false
]

{ #category : #'accessing style' }
SlFormControl >> beNotRequired [

	self required: false
]

{ #category : #'accessing style' }
SlFormControl >> beRequired [

	self required: true
]

{ #category : #actions }
SlFormControl >> blur [

	"Removes focus from the input."

	self removeFocus
]

{ #category : #accessing }
SlFormControl >> clone [

	"Deep clone the receiver.

	Implementation:
	Set the (non reflecting properties explicitly)."

	^ super clone
		value: self value ;
		yourself

]

{ #category : #accessing }
SlFormControl >> defaultValue [

	^ self propertyAt: #defaultValue
]

{ #category : #accessing }
SlFormControl >> defaultValue: anObject [

	"Set the receiver's default value.

	The type is depending on the receiver. E.g. SlRange has Number, SlInput has String"

	self propertyAt: #defaultValue put: anObject
]

{ #category : #accessing }
SlFormControl >> disabled: aBoolean [

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
SlFormControl >> enabled: aBoolean [

	"Convenience method to set receiver's enabled state"

	self disabled: aBoolean not
]

{ #category : #testing }
SlFormControl >> hasFocus [

	^ self = CpHtmlElement activeElement
]

{ #category : #accessing }
SlFormControl >> invalid: aBoolean [

	self propertyAt: #invalid put: aBoolean
]

{ #category : #testing }
SlFormControl >> isDisabled [

	^ self propertyAt: #disabled
]

{ #category : #testing }
SlFormControl >> isEnabled [

	"Convenience method to test if receiver is enabled"

	^ self isDisabled not
]

{ #category : #testing }
SlFormControl >> isInvalid [

	^ self propertyAt: #invalid
]

{ #category : #testing }
SlFormControl >> isRequired [

	^ self propertyAt: #required
]

{ #category : #accessing }
SlFormControl >> name [

	^ self propertyAt: #name
]

{ #category : #accessing }
SlFormControl >> name: aString [

	self propertyAt: #name put: aString
]

{ #category : #actions }
SlFormControl >> reportValidity [
 
	"Checks for validity and shows the browser's validation message if the control is invalid."

	self apply: #reportValidity withArguments: #()
]

{ #category : #accessing }
SlFormControl >> required: aBoolean [

	self propertyAt: #required put: aBoolean
]

{ #category : #actions }
SlFormControl >> setCustomValidity: aString [ 

	"Sets a custom validation message. If message is not empty, the field will be considered invalid."

	self apply: #setCustomValidity withArguments: { aString }
]

{ #category : #accessing }
SlFormControl >> value [

	^ self propertyAt: #value
]

{ #category : #accessing }
SlFormControl >> value: aString [

	self propertyAt: #value put: aString
]
