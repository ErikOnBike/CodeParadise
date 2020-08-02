Class {
	#name : #FuiCheckbox,
	#superclass : #FuiElement,
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #'web resources' }
FuiCheckbox class >> template [

	<webResource: #html>

	^ '<div class="ui checkbox"><input type="checkbox"><label><slot></slot></label></div>'
]

{ #category : #accessing }
FuiCheckbox class >> type [

	^ #checkbox
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
