Class {
	#name : #SlInput,
	#superclass : #SlFormControl,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #'accessing control' }
SlInput >> autocapitalize [

	self attributeAt: #autocapitalize put: 'on'
]

{ #category : #'accessing control' }
SlInput >> autocapitalizeCharacters [

	self attributeAt: #autocapitalize put: 'characters'
]

{ #category : #'accessing control' }
SlInput >> autocapitalizeSentences [

	self attributeAt: #autocapitalize put: 'sentences'
]

{ #category : #'accessing control' }
SlInput >> autocapitalizeWords [

	self attributeAt: #autocapitalize put: 'words'
]

{ #category : #'accessing control' }
SlInput >> autocomplete [

	self attributeAt: #autocomplete put: ''
]

{ #category : #'accessing control' }
SlInput >> autocorrect [

	self attributeAt: #autocorrect put: ''
]

{ #category : #'accessing control' }
SlInput >> autofocus [

	self attributeAt: #autofocus put: ''
]

{ #category : #'accessing control' }
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

{ #category : #'accessing control' }
SlInput >> beNotClearable [

	self removeAttributeAt: #clearable
]

{ #category : #'accessing style' }
SlInput >> beNotDisabled [

	self removeAttributeAt: #disabled
]

{ #category : #'accessing style' }
SlInput >> beNotReadonly [

	self removeAttributeAt: #readonly
]

{ #category : #'accessing control' }
SlInput >> beNotRequired [

	self removeAttributeAt: #required 
]

{ #category : #'accessing style' }
SlInput >> bePill [

	self attributeAt: #pill put: ''
]

{ #category : #'accessing style' }
SlInput >> beReadonly [

	self attributeAt: #readonly put: 'on'
]

{ #category : #'accessing control' }
SlInput >> beRequired [

	self attributeAt: #required put: 'on'
]

{ #category : #'accessing control' }
SlInput >> customValidityMessage: aString [ 
	"Sets a custom validation message. If message is not empty, the field will be considered invalid."

	self apply: #setCustomValidity: withArguments: { aString }
]

{ #category : #'accessing type' }
SlInput >> date [
	"Causes a popup date selector, however the date type might not be supported on all browsers"
	
	self type: #date
]

{ #category : #'accessing type' }
SlInput >> email [

	self type: #email
]

{ #category : #'accessing control' }
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

{ #category : #'accessing control' }
SlInput >> isClearable [

	^ (self attributeAt: #clearable) notNil
]

{ #category : #'accessing style' }
SlInput >> isDisabled [

	^ (self attributeAt: #disabled) notNil
]

{ #category : #'accessing control' }
SlInput >> isInvalid [

	^ (self attributeAt: #invalid) notNil
]

{ #category : #'accessing style' }
SlInput >> isPill [

	^ (self attributeAt: #pill) notNil
]

{ #category : #'accessing style' }
SlInput >> isReadonly [

	^ (self attributeAt: #readonly) notNil
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

{ #category : #'accessing control' }
SlInput >> max [

	self attributeAt: #max
]

{ #category : #'accessing control' }
SlInput >> max: aNumber [

	self attributeAt: #max put: aNumber printString
]

{ #category : #'accessing control' }
SlInput >> maxlength [

	self attributeAt: #maxlength
]

{ #category : #'accessing control' }
SlInput >> maxlength: aNumber [

	self attributeAt: #maxlength put: aNumber printString

]

{ #category : #'accessing size' }
SlInput >> medium [

	self size: #medium
]

{ #category : #'accessing control' }
SlInput >> min [

	self attributeAt: #min
]

{ #category : #'accessing control' }
SlInput >> min: aNumber [

	self attributeAt: #min put: aNumber printString
]

{ #category : #'accessing control' }
SlInput >> noAutocapitalize [

	self attributeAt: #autocapitalize put: 'off'
]

{ #category : #'accessing control' }
SlInput >> noAutocomplete [

	self attributeAt: #autocomplete put: 'off'
]

{ #category : #'accessing control' }
SlInput >> noAutocorrect [

	self attributeAt: #autocorrect put: 'off'
]

{ #category : #'accessing control' }
SlInput >> noAutofocus [

	self attributeAt: #autofocus put: 'off'
]

{ #category : #'accessing control' }
SlInput >> noSpellcheck [

	self attributeAt: #spellcheck put: 'off'
]

{ #category : #'accessing control' }
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

{ #category : #'accessing control' }
SlInput >> pattern [

	self attributeAt: #pattern
]

{ #category : #'accessing control' }
SlInput >> pattern: aString [
	"A pattern to validate input against."

	self attributeAt: #pattern put: aString
]

{ #category : #'accessing control' }
SlInput >> placeholder [

	^ self attributeAt: #placeholder
]

{ #category : #'accessing control' }
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

{ #category : #'accessing control' }
SlInput >> reportValidity [ 
	"Checks for validity and shows the browser's validation message if the control is invalid."

	self apply: #reportValidity withArguments: #()
]

{ #category : #'accessing type' }
SlInput >> search [

	self type: #search
]

{ #category : #'accessing control' }
SlInput >> select [ 
	"Select all the text in the field"

	self apply: #select withArguments: #()
]

{ #category : #'accessing size' }
SlInput >> size [

	^ self attributeAt: #size
]

{ #category : #'accessing size' }
SlInput >> size: sizeString [
	"Set the field size to either: small, medium, large"
	
	self attributeAt: #size put: sizeString
]

{ #category : #'accessing size' }
SlInput >> small [

	self size: #small
]

{ #category : #'accessing control' }
SlInput >> spellcheck [

	self attributeAt: #spellcheck put: ''
]

{ #category : #'accessing control' }
SlInput >> step: aNumber [
	"The input's step attribute."
	
	self attributeAt: #step put: aNumber printString
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

{ #category : #'accessing control' }
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
