Class {
	#name : #IonToastButton,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-WebApplication-Ionic-Support'
}

{ #category : #accessing }
IonToastButton >> handler [

	"aBlock should answer Boolean"

	^ options at: #handler:
]

{ #category : #accessing }
IonToastButton >> handler: aBlock [

	"aBlock should answer Boolean"

	options at: #handler put: aBlock
]

{ #category : #accessing }
IonToastButton >> htmlAttributes [

	^ options at: #htmlAttributes:
]

{ #category : #accessing }
IonToastButton >> htmlAttributes: aDictionary [

	options at: #htmlAttributes put: aDictionary
]

{ #category : #accessing }
IonToastButton >> icon [

	^ options at: #icon:
]

{ #category : #accessing }
IonToastButton >> icon: aString [

	options at: #icon put: aString
]

{ #category : #accessing }
IonToastButton >> role [

	"cancel | string"

	^ options at: #role:
]

{ #category : #accessing }
IonToastButton >> role: aSymbol [

	"cancel | string"

	options at: #role put: aSymbol
]

{ #category : #accessing }
IonToastButton >> side [

	"#start or #end"

	^ options at: #side:
]

{ #category : #accessing }
IonToastButton >> side: aSymbol [

	"#start or #end"

	options at: #side put: aSymbol
]

{ #category : #accessing }
IonToastButton >> text [

	^ options at: #text
]

{ #category : #accessing }
IonToastButton >> text: aString [

	options at: #text put: aString
]
