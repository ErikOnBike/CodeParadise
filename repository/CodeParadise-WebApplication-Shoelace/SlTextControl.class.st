Class {
	#name : #SlTextControl,
	#superclass : #SlFormControl,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #tags }
SlTextControl class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #accessing }
SlTextControl class >> label: aStringOrElement [

	^ self new
		label: aStringOrElement ;
		yourself

]

{ #category : #accessing }
SlTextControl >> autocapitalize [

	^ self propertyAt: #autocapitalize
]

{ #category : #accessing }
SlTextControl >> autocapitalize: aString [

	self propertyAt: #autocapitalize put: aString
]

{ #category : #'accessing style' }
SlTextControl >> autocapitalizeCharacters [

	self autocapitalize: #characters
]

{ #category : #'accessing style' }
SlTextControl >> autocapitalizeNone [

	self autocapitalize: #none
]

{ #category : #'accessing style' }
SlTextControl >> autocapitalizeOff [

	self autocapitalize: #off
]

{ #category : #'accessing style' }
SlTextControl >> autocapitalizeOn [

	self autocapitalize: #on
]

{ #category : #'accessing style' }
SlTextControl >> autocapitalizeSentences [

	self autocapitalize: #sentences
]

{ #category : #'accessing style' }
SlTextControl >> autocapitalizeWords [

	self autocapitalize: #words
]

{ #category : #accessing }
SlTextControl >> autocomplete [

	^ self propertyAt: #autocomplete
]

{ #category : #accessing }
SlTextControl >> autocomplete: aString [

	self propertyAt: #autocomplete put: aString
]

{ #category : #accessing }
SlTextControl >> autocorrect [

	^ self propertyAt: #autocorrect
]

{ #category : #accessing }
SlTextControl >> autocorrect: aString [

	self propertyAt: #autocorrect put: aString
]

{ #category : #accessing }
SlTextControl >> autofocus: aBoolean [

	self propertyAt: #autofocus put: aBoolean
]

{ #category : #'accessing style' }
SlTextControl >> beAutofocus [

	self autofocus: true
]

{ #category : #'accessing style' }
SlTextControl >> beFilled [

	self filled: true
]

{ #category : #'accessing size' }
SlTextControl >> beLarge [

	self size: #large
]

{ #category : #'accessing size' }
SlTextControl >> beMedium [

	self size: #medium
]

{ #category : #'accessing style' }
SlTextControl >> beNotAutofocus [

	self autofocus: false
]

{ #category : #'accessing style' }
SlTextControl >> beNotFilled [

	self filled: false
]

{ #category : #'accessing style' }
SlTextControl >> beNotReadonly [

	self readonly: false
]

{ #category : #'accessing style' }
SlTextControl >> beNotSpellcheck [

	self spellcheck: false
]

{ #category : #'accessing style' }
SlTextControl >> beReadonly [

	self readonly: true
]

{ #category : #'accessing size' }
SlTextControl >> beSmall [

	self size: #small
]

{ #category : #'accessing style' }
SlTextControl >> beSpellcheck [

	self spellcheck: true
]

{ #category : #accessing }
SlTextControl >> filled: aBoolean [

	self propertyAt: #filled put: aBoolean
]

{ #category : #accessing }
SlTextControl >> help [

	"Answer the help HTML element of the receiver.
	For a simple String value use #helpText instead."

	^ self firstChildAtSlotNamed: #'help-text'
]

{ #category : #accessing }
SlTextControl >> help: aStringOrElement [

	"Set the help text to the specified Element.
	For a simple String value use #helpText: instead."

	self replaceAllChildrenWith: aStringOrElement asHtmlElement atSlotNamed: #'help-text'
]

{ #category : #accessing }
SlTextControl >> helpText [

	"Answer the help text (a String) of the receiver.
	For richer HTML element use #help instead."

	^ self help
		ifNotNil: [ :help | help textContent ]
		ifNil: [ '' ]
]

{ #category : #accessing }
SlTextControl >> helpText: aString [

	"Set the help text to the specified String value.
	For richer HTML element use #help: instead."

	self help: aString asHtmlElement
]

{ #category : #accessing }
SlTextControl >> inputmode [

	^ self propertyAt: #inputmode
]

{ #category : #accessing }
SlTextControl >> inputmode: aString [

	self propertyAt: #inputmode put: aString
]

{ #category : #'accessing style' }
SlTextControl >> inputmodeDecimal [

	self inputmode: #decimal
]

{ #category : #'accessing style' }
SlTextControl >> inputmodeEmail [

	self inputmode: #email
]

{ #category : #'accessing style' }
SlTextControl >> inputmodeNone [

	self inputmode: #none
]

{ #category : #'accessing style' }
SlTextControl >> inputmodeNumeric [

	self inputmode: #numeric
]

{ #category : #'accessing style' }
SlTextControl >> inputmodeSearch [

	self inputmode: #search
]

{ #category : #'accessing style' }
SlTextControl >> inputmodeTel [

	self inputmode: #tel
]

{ #category : #'accessing style' }
SlTextControl >> inputmodeText [

	self inputmode: #text
]

{ #category : #'accessing style' }
SlTextControl >> inputmodeUrl [

	self inputmode: #url
]

{ #category : #testing }
SlTextControl >> isAutofocus [

	^ self propertyAt: #autofocus
]

{ #category : #testing }
SlTextControl >> isFilled [

	^ self propertyAt: #filled
]

{ #category : #testing }
SlTextControl >> isReadonly [

	^ self propertyAt: #readonly
]

{ #category : #testing }
SlTextControl >> isSpellcheck [

	^ self propertyAt: #spellcheck
]

{ #category : #accessing }
SlTextControl >> label [

	"Answer the label HTML element of the receiver.
	For a simple String value use #labelText instead."

	^ self firstChildAtSlotNamed: #label
]

{ #category : #accessing }
SlTextControl >> label: aStringOrElement [

	"Set the label to the specified Element.
	For a simple String value use #labelText: instead."

	self replaceAllChildrenWith: aStringOrElement asHtmlElement atSlotNamed: #label
]

{ #category : #accessing }
SlTextControl >> labelText [

	"Answer the label text (a String) of the receiver.
	For richer HTML element use #label instead."

	^ self label
		ifNotNil: [ :label | label textContent ]
		ifNil: [ '' ]
]

{ #category : #accessing }
SlTextControl >> labelText: aString [

	"Set the label text to the specified String value.
	For richer HTML element use #label: instead."

	self label: aString asHtmlElement
]

{ #category : #accessing }
SlTextControl >> maxlength [

	^ self propertyAt: #maxlength
]

{ #category : #accessing }
SlTextControl >> maxlength: aNumber [

	self propertyAt: #maxlength put: aNumber
]

{ #category : #accessing }
SlTextControl >> minlength [

	^ self propertyAt: #minlength
]

{ #category : #accessing }
SlTextControl >> minlength: aNumber [

	self propertyAt: #minlength put: aNumber
]

{ #category : #accessing }
SlTextControl >> pattern [

	^ self propertyAt: #pattern
]

{ #category : #accessing }
SlTextControl >> pattern: aString [

	self propertyAt: #pattern put: aString
]

{ #category : #accessing }
SlTextControl >> placeholder [

	^ self propertyAt: #placeholder
]

{ #category : #accessing }
SlTextControl >> placeholder: aString [

	self propertyAt: #placeholder put: aString
]

{ #category : #accessing }
SlTextControl >> prefix [

	^ self firstChildAtSlotNamed: #prefix
]

{ #category : #accessing }
SlTextControl >> prefix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #prefix
]

{ #category : #accessing }
SlTextControl >> readonly: aBoolean [

	self propertyAt: #readonly put: aBoolean
]

{ #category : #actions }
SlTextControl >> select [

	"Selects all the text in the input."

	self apply: #select withArguments: #()
]

{ #category : #actions }
SlTextControl >> setRangeTextReplace: replaceString from: startNumber to: endNumber selectMode: modeString [

	"Replaces a range of text with a new string.
	The direction String should be one of: 'select' | 'start' | 'end' | 'preserve'"

	self apply: #setRangeText withArguments: { replaceString . startNumber . endNumber . modeString }
]

{ #category : #actions }
SlTextControl >> setSelectionRangeFrom: startNumber to: endNumber direction: directionString [

	"Sets the start and end positions of the text selection (0-based).
	The direction String should be one of: 'forward' | 'backward' | 'none'"

	self apply: #setSelectionRange withArguments: { startNumber . endNumber . directionString }
]

{ #category : #accessing }
SlTextControl >> size [

	^ self propertyAt: #size
]

{ #category : #accessing }
SlTextControl >> size: aString [

	self propertyAt: #size put: aString
]

{ #category : #accessing }
SlTextControl >> spellcheck: aBoolean [

	self propertyAt: #spellcheck put: aBoolean
]

{ #category : #accessing }
SlTextControl >> suffix [

	^ self firstChildAtSlotNamed: #suffix
]

{ #category : #accessing }
SlTextControl >> suffix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #suffix
]
