Class {
	#name : #FuiCheckbox,
	#superclass : #FuiElement,
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #accessing }
FuiCheckbox class >> allTypes [

	^ #(#slider #toggle)
]

{ #category : #'web resources' }
FuiCheckbox class >> template [

	<webResource: #html>

	^ '<div class="ui checkbox"><input type="checkbox"><label><slot></slot></label></div>'
]

{ #category : #accessing }
FuiCheckbox class >> type [

	^ #checkbox
]

{ #category : #'as yet unclassified' }
FuiCheckbox >> beRegular [

	^ self setType: nil ofTypes: self class allTypes
]

{ #category : #'as yet unclassified' }
FuiCheckbox >> beSlider [

	^ self setType: #slider ofTypes: self class allTypes
]

{ #category : #'as yet unclassified' }
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

{ #category : #'accessing - state' }
FuiCheckbox >> readOnly [

	^ self shadowElement addClass: #'read-only'
]

{ #category : #'accessing - state' }
FuiCheckbox >> readWrite [

	^ self shadowElement removeClass: #'read-only'
]

{ #category : #'accessing - state' }
FuiCheckbox >> uncheck [

	^ self performOnElement: 'set unchecked'
]
