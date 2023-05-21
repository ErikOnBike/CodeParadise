Class {
	#name : #SlTab,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlTab class >> panel: panelString labelText: labelString [

	^ self new
		panel: panelString ;
		labelText: labelString ;
		yourself
]

{ #category : #accessing }
SlTab >> active: aBoolean [

	self propertyAt: #active put: aBoolean
]

{ #category : #accessing }
SlTab >> beActive [

	self active: true
]

{ #category : #accessing }
SlTab >> beClosable [

	self closable: true
]

{ #category : #accessing }
SlTab >> beDisabled [

	self disabled: true
]

{ #category : #accessing }
SlTab >> beEnabled [

	"Convenience method to make receiver enabled"

	self disabled: false
]

{ #category : #accessing }
SlTab >> beNotActive [

	self active: false
]

{ #category : #accessing }
SlTab >> beNotClosable [

	self closable: false
]

{ #category : #accessing }
SlTab >> beNotDisabled [

	self disabled: false
]

{ #category : #accessing }
SlTab >> beNotEnabled [

	"Convenience method to clear the enabled state of the receiver"

	self disabled: true
]

{ #category : #accessing }
SlTab >> closable: aBoolean [

	self propertyAt: #closable put: aBoolean
]

{ #category : #accessing }
SlTab >> disabled: aBoolean [

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
SlTab >> enabled: aBoolean [

	"Convenience method to set receiver's enabled state"

	self disabled: aBoolean not
]

{ #category : #accessing }
SlTab >> isActive [

	^ self propertyAt: #active
]

{ #category : #accessing }
SlTab >> isClosable [

	^ self propertyAt: #closable
]

{ #category : #accessing }
SlTab >> isDisabled [

	^ self propertyAt: #disabled
]

{ #category : #accessing }
SlTab >> isEnabled [

	"Convenience method to test if receiver is enabled"

	^ self isDisabled not
]

{ #category : #accessing }
SlTab >> label [

	"Answer the label HTML element of the receiver.
	For a simple String value use #labelText instead."

	^ self firstChildAtSlotNamed: nil
]

{ #category : #accessing }
SlTab >> label: aStringOrElement [

	"Set the label to the specified Element.
	For a simple String value use #labelText: instead."

	self replaceAllChildrenWith: aStringOrElement asHtmlElement atSlotNamed: nil
]

{ #category : #accessing }
SlTab >> labelText [

	"Answer the label text (a String) of the receiver.
	For richer HTML element use #label instead."

	^ self textContent
]

{ #category : #accessing }
SlTab >> labelText: aString [

	"Set the label text to the specified String value.
	For richer HTML element use #label: instead."

	self textContent: aString
]

{ #category : #accessing }
SlTab >> panel [

	^ self propertyAt: #panel
]

{ #category : #accessing }
SlTab >> panel: aString [

	self propertyAt: #panel put: aString
]
