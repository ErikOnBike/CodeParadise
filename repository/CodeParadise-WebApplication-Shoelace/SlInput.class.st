Class {
	#name : #SlInput,
	#superclass : #SlFormControl,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #'accessing style' }
SlInput >> beClearable [

	self attributeAt: #clearable put: ''
]

{ #category : #'accessing style' }
SlInput >> beDisabled [

	self attributeAt: #disabled put: ''
]

{ #category : #'accessing style' }
SlInput >> beNoPill [

	self removeAttributeAt: #pill
]

{ #category : #'accessing style' }
SlInput >> beNotClearable [

	self removeAttributeAt: #clearable
]

{ #category : #'accessing style' }
SlInput >> beNotDisabled [

	self removeAttributeAt: #disabled
]

{ #category : #'accessing style' }
SlInput >> bePill [

	self attributeAt: #pill put: ''
]

{ #category : #'accessing type' }
SlInput >> email [

	self type: #email
]

{ #category : #'accessing style' }
SlInput >> hasTogglePassword [

	^ (self attributeAt: #'toggle-password') notNil
]

{ #category : #accessing }
SlInput >> help [

	self firstChildAtSlotNamed: #'help-text'
]

{ #category : #accessing }
SlInput >> help: anElement [

	"Set the help text to the specified Element.
	For a simple String value use #helpText: instead."

	self replaceAllChildrenWith: anElement atSlotNamed: #'help-text'
]

{ #category : #accessing }
SlInput >> helpText [

	^ self attributeAt: #'help-text'
]

{ #category : #accessing }
SlInput >> helpText: aString [

	"Set the help text to the specified String value.
	For richer HTML help use #help: instead."

	self attributeAt: #'help-text' put: aString
]

{ #category : #'accessing style' }
SlInput >> isClearable [

	^ (self attributeAt: #clearable) notNil
]

{ #category : #'accessing style' }
SlInput >> isDisabled [

	^ (self attributeAt: #disabled) notNil
]

{ #category : #'accessing style' }
SlInput >> isPill [

	^ (self attributeAt: #pill) notNil
]

{ #category : #accessing }
SlInput >> label [

	^ self attributeAt: #label
]

{ #category : #accessing }
SlInput >> label: aString [

	self attributeAt: #label put: aString
]

{ #category : #'accessing size' }
SlInput >> large [

	self size: #large
]

{ #category : #'accessing size' }
SlInput >> medium [

	self size: #medium
]

{ #category : #'accessing control' }
SlInput >> name [

	^ self propertyAt: #name
]

{ #category : #'accessing control' }
SlInput >> name: aString [

	self propertyAt: #name put: aString
]

{ #category : #'accessing style' }
SlInput >> noTogglePassword [

	self removeAttributeAt: #'toggle-password'
]

{ #category : #'accessing type' }
SlInput >> number [

	self type: #number
]

{ #category : #'accessing type' }
SlInput >> password [

	self type: #password
]

{ #category : #'accessing style' }
SlInput >> placeholder [

	^ self attributeAt: #placeholder
]

{ #category : #'accessing style' }
SlInput >> placeholder: aString [

	self attributeAt: #placeholder put: aString
]

{ #category : #accessing }
SlInput >> prefix [

	self firstChildAtSlotNamed: #prefix
]

{ #category : #accessing }
SlInput >> prefix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #prefix
]

{ #category : #'accessing type' }
SlInput >> search [

	self type: #search
]

{ #category : #'accessing size' }
SlInput >> size [

	^ self attributeAt: #size
]

{ #category : #'accessing size' }
SlInput >> size: aString [

	self attributeAt: #size put: aString
]

{ #category : #'accessing size' }
SlInput >> small [

	self size: #small
]

{ #category : #accessing }
SlInput >> suffix [

	self firstChildAtSlotNamed: #suffix
]

{ #category : #accessing }
SlInput >> suffix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #suffix
]

{ #category : #'accessing type' }
SlInput >> tel [

	self type: #tel
]

{ #category : #'accessing type' }
SlInput >> text [

	self type: #text
]

{ #category : #'accessing style' }
SlInput >> togglePassword [

	self attributeAt: #'toggle-password' put: ''
]

{ #category : #'accessing type' }
SlInput >> type [

	^ self attributeAt: #type
]

{ #category : #'accessing type' }
SlInput >> type: aString [

	self attributeAt: #type put: aString
]

{ #category : #'accessing type' }
SlInput >> url [

	self type: #url
]

{ #category : #'accessing control' }
SlInput >> value [

	^ self propertyAt: #value
]

{ #category : #'accessing control' }
SlInput >> value: aString [

	self propertyAt: #value put: aString
]
