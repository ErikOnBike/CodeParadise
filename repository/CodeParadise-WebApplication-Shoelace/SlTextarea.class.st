Class {
	#name : #SlTextarea,
	#superclass : #SlFormControl,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #'accessing size' }
SlTextarea >> autoResize [

	self resize: #auto
]

{ #category : #'accessing style' }
SlTextarea >> beDisabled [

	self attributeAt: #disabled put: ''
]

{ #category : #'accessing style' }
SlTextarea >> beNotDisabled [

	self removeAttributeAt: #disabled
]

{ #category : #'accessing type' }
SlTextarea >> email [

	self type: #email
]

{ #category : #accessing }
SlTextarea >> help [

	self firstChildAtSlotNamed: #'help-text'
]

{ #category : #accessing }
SlTextarea >> help: anElement [

	"Set the help text to the specified Element.
	For a simple String value use #helpText: instead."

	self replaceAllChildrenWith: anElement atSlotNamed: #'help-text'
]

{ #category : #accessing }
SlTextarea >> helpText [

	^ self attributeAt: #'help-text'
]

{ #category : #accessing }
SlTextarea >> helpText: aString [

	"Set the help text to the specified String value.
	For richer HTML help use #help: instead."

	self attributeAt: #'help-text' put: aString
]

{ #category : #'accessing style' }
SlTextarea >> isDisabled [

	^ (self attributeAt: #disabled) notNil
]

{ #category : #accessing }
SlTextarea >> label [

	^ self attributeAt: #label
]

{ #category : #accessing }
SlTextarea >> label: aString [

	self attributeAt: #label put: aString
]

{ #category : #'accessing size' }
SlTextarea >> large [

	self size: #large
]

{ #category : #'accessing size' }
SlTextarea >> medium [

	self size: #medium
]

{ #category : #'accessing size' }
SlTextarea >> noResize [

	self resize: #none
]

{ #category : #'accessing type' }
SlTextarea >> number [

	self type: #number
]

{ #category : #'accessing control' }
SlTextarea >> placeholder [

	^ self attributeAt: #placeholder
]

{ #category : #'accessing control' }
SlTextarea >> placeholder: aString [

	self attributeAt: #placeholder put: aString
]

{ #category : #'accessing size' }
SlTextarea >> resize [

	^ self attributeAt: #resize
]

{ #category : #'accessing size' }
SlTextarea >> resize: aString [

	self attributeAt: #resize put: aString
]

{ #category : #'accessing control' }
SlTextarea >> rows [

	^ (self attributeAt: #rows) ifNotNil: [ :rowString | Number readFrom: rowString ]
]

{ #category : #'accessing control' }
SlTextarea >> rows: anInteger [

	self attributeAt: #rows put: anInteger asString
]

{ #category : #'accessing type' }
SlTextarea >> search [

	self type: #search
]

{ #category : #'accessing size' }
SlTextarea >> size [

	^ self attributeAt: #size
]

{ #category : #'accessing size' }
SlTextarea >> size: aString [

	self attributeAt: #size put: aString
]

{ #category : #'accessing size' }
SlTextarea >> small [

	self size: #small
]

{ #category : #'accessing type' }
SlTextarea >> tel [

	self type: #tel
]

{ #category : #'accessing type' }
SlTextarea >> text [

	self type: #text
]

{ #category : #'accessing type' }
SlTextarea >> type [

	^ self attributeAt: #type
]

{ #category : #'accessing type' }
SlTextarea >> type: aString [

	self attributeAt: #type put: aString
]

{ #category : #'accessing type' }
SlTextarea >> url [

	self type: #url
]
