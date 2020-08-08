Class {
	#name : #FuiCheckbox,
	#superclass : #FuiElement,
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #accessing }
FuiCheckbox class >> allTypes [

	^ #(#slider #toggle #radio)
]

{ #category : #'web resources' }
FuiCheckbox class >> template [

	<webResource: #html>

	^ '<div class="ui checkbox"><input type="checkbox"><label></label></div>'
]

{ #category : #accessing }
FuiCheckbox class >> type [

	^ #checkbox
]

{ #category : #'accessing - types' }
FuiCheckbox >> beRadio [

	^ self setType: #radio ofTypes: self class allTypes
]

{ #category : #'accessing - types' }
FuiCheckbox >> beRegular [

	^ self setType: nil ofTypes: self class allTypes
]

{ #category : #'accessing - types' }
FuiCheckbox >> beSlider [

	^ self setType: #slider ofTypes: self class allTypes
]

{ #category : #'accessing - types' }
FuiCheckbox >> beToggle [

	^ self setType: #toggle ofTypes: self class allTypes
]

{ #category : #'accessing - state' }
FuiCheckbox >> check [

	^ self performOnElement: 'set checked'
]

{ #category : #'accessing - state' }
FuiCheckbox >> disable [

	^ self performOnElement: 'set disabled'
]

{ #category : #'accessing - state' }
FuiCheckbox >> enable [

	^ self performOnElement: 'set enabled'
]

{ #category : #testing }
FuiCheckbox >> isChecked [

	^ self performOnElement: 'is checked'
]

{ #category : #accessing }
FuiCheckbox >> label: label [

	"Add the specified label (either String or an Element) to the receiver"

	label
		ifNotNil: [
			(self shadowElement firstDescendantMatching: 'label')
				ifNotNil: [ :labelElement |
					label isString
						ifTrue: [ labelElement textContent: label ]
						ifFalse: [
							labelElement
								removeChildren ;
								appendChild: label ] ] ]
		ifNil: [ self removeLabel ]
]

{ #category : #'accessing - state' }
FuiCheckbox >> readOnly [

	^ self addState: #'read-only'
]

{ #category : #'accessing - state' }
FuiCheckbox >> readWrite [

	^ self removeState: #'read-only'
]

{ #category : #accessing }
FuiCheckbox >> removeLabel [

	"Remove the label (content) from the receiver"

	(self shadowElement firstDescendantMatching: 'label')
			ifNotNil: [ :labelElement | labelElement removeChildren ]
]

{ #category : #'accessing - state' }
FuiCheckbox >> uncheck [

	^ self performOnElement: 'set unchecked'
]
