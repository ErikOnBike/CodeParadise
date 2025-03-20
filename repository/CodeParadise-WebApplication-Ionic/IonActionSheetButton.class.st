Class {
	#name : #IonActionSheetButton,
	#superclass : #CpJsonObject,
	#instVars : [
		'handler'
	],
	#category : #'CodeParadise-WebApplication-Ionic-Support'
}

{ #category : #converting }
IonActionSheetButton >> asJsonObjectValue [

	"Answer a representation for usage in the ActionSheet"

	^ super asJsonObjectValue
		at: #handler put: (handler ifNotNil: [ handler asJavaScriptFunction ]) ;
		yourself
]

{ #category : #accessing }
IonActionSheetButton >> cssClass [

	^ self at: #cssClass
]

{ #category : #accessing }
IonActionSheetButton >> cssClass: aStringOrCollectionOfStrings [

	self at: #cssClass put: aStringOrCollectionOfStrings
]

{ #category : #accessing }
IonActionSheetButton >> data [

	^ self at: #data
]

{ #category : #accessing }
IonActionSheetButton >> data: anObject [

	self at: #data put: anObject asJsonObjectValue
]

{ #category : #accessing }
IonActionSheetButton >> handler [

	^ handler
]

{ #category : #accessing }
IonActionSheetButton >> handler: aBlock [

	handler := aBlock
]

{ #category : #accessing }
IonActionSheetButton >> htmlAttributes [

	^ self at: #htmlAttributes 
]

{ #category : #accessing }
IonActionSheetButton >> htmlAttributes: anObject [

	self at: #htmlAttributes put: anObject asJsonObjectValue
]

{ #category : #accessing }
IonActionSheetButton >> icon [

	^ self at: #icon
]

{ #category : #accessing }
IonActionSheetButton >> icon: aString [

	self at: #icon put: aString
]

{ #category : #accessing }
IonActionSheetButton >> id [

	^ self at: #id
]

{ #category : #accessing }
IonActionSheetButton >> id: aString [

	self at: #id put: aString
]

{ #category : #accessing }
IonActionSheetButton >> role [

	^ self at: #role
]

{ #category : #accessing }
IonActionSheetButton >> role: aString [

	"'cancel' | 'destructive' | 'selected' | string"

	self at: #role put: aString
]

{ #category : #accessing }
IonActionSheetButton >> text [

	^ self at: #text
]

{ #category : #accessing }
IonActionSheetButton >> text: aString [

	self at: #text put: aString
]
