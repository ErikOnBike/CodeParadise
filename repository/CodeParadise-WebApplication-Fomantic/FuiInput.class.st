Class {
	#name : #FuiInput,
	#superclass : #FuiElement,
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #'web resources' }
FuiInput class >> template [

	<webResource: #html>

	^ '<div class="ui input"><input type="text"></div>'
]

{ #category : #accessing }
FuiInput class >> type [

	^ #input
]

{ #category : #protocol }
FuiInput >> disable [

	^ self shadowElement addClass: #disabled
]

{ #category : #protocol }
FuiInput >> enable [

	^ self shadowElement removeClass: #disabled
]

{ #category : #accessing }
FuiInput >> icon [

	^ (self shadowElement firstDescendantMatching: '.icon')
		ifNotNil: [ :iconElement |
			| classValue |
			classValue := iconElement attributeAt: #class.
			(classValue endsWith: ' icon')
				ifTrue: [ classValue allButLast: 5 ]
				ifFalse: [ nil ] ]
]

{ #category : #accessing }
FuiInput >> icon: aSymbol [

	| shadowElement |

	aSymbol
		ifNotNil: [
			shadowElement := self shadowElement.
			(shadowElement firstDescendantMatching: '.icon')
				ifNotNil: [ :iconElement | iconElement attributeAt: #class put: aSymbol, ' icon' ]
				ifNil: [ shadowElement appendChild: aSymbol asFomanticIcon ].
			self setType: #icon ofTypes: #() ]
		ifNil: [ self removeIcon ]
]

{ #category : #accessing }
FuiInput >> placeholder [

	^ (self shadowElement firstDescendantMatching: #input)
		attributeAt: #placeholder
]

{ #category : #accessing }
FuiInput >> placeholder: aString [

	(self shadowElement firstDescendantMatching: #input)
		attributeAt: #placeholder put: aString
]

{ #category : #removing }
FuiInput >> removeIcon [

	(self shadowElement firstDescendantMatching: '.icon')
		ifNotNil: [ :iconElement | iconElement remove ]
]
