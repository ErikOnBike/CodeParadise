Extension { #name : #CpJavaScriptClass }

{ #category : #'*CodeParadise-Development' }
CpJavaScriptClass class >> classForTypeName: aSymbol [

	"Answer the Class for the specified JavaScript type name"

	(Smalltalk classNamed: aSymbol)
		ifNotNil: [ :class | ^ class ].

	(Smalltalk classNamed: #CpJavaScript, aSymbol)
		ifNotNil: [ :class | ^ class ].

	(Smalltalk classNamed: #CpBrowser, aSymbol)
		ifNotNil: [ :class | ^ class ].

	(Smalltalk classNamed: #CpNodeJS, aSymbol)
		ifNotNil: [ :class | ^ class ].

	^ nil
]

{ #category : #'*CodeParadise-Development' }
CpJavaScriptClass class >> classForTypeName: aSymbol from: aClass [

	"Answer the Class for the specified JavaScript type name"

	| className classNameParts size |

	className := aClass name.
	classNameParts := className asKebabCase findTokens: '-'.

	size := 0.
	classNameParts do: [ :each |
		size := size + each size.
		(Smalltalk classNamed: (className first: size), aSymbol)
			ifNotNil: [ :class | ^ class ] ].

	self classForTypeName: aSymbol
]
