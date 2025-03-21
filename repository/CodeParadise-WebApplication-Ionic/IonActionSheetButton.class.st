Class {
	#name : #IonActionSheetButton,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-WebApplication-Ionic-Support'
}

{ #category : #accessing }
IonActionSheetButton >> cssClass [

	^ options at: #cssClass
]

{ #category : #accessing }
IonActionSheetButton >> cssClass: aStringOrCollectionOfStrings [

	options at: #cssClass put: aStringOrCollectionOfStrings
]

{ #category : #accessing }
IonActionSheetButton >> data [

	^ options at: #data
]

{ #category : #accessing }
IonActionSheetButton >> data: anObject [

	options at: #data put: anObject
]

{ #category : #accessing }
IonActionSheetButton >> handler [

	^ options at: #handler
]

{ #category : #accessing }
IonActionSheetButton >> handler: aBlock [

	options at: #handler put: aBlock
]

{ #category : #accessing }
IonActionSheetButton >> htmlAttributes [

	^ options at: #htmlAttributes 
]

{ #category : #accessing }
IonActionSheetButton >> htmlAttributes: anObject [

	options at: #htmlAttributes put: anObject
]

{ #category : #accessing }
IonActionSheetButton >> icon [

	^ options at: #icon
]

{ #category : #accessing }
IonActionSheetButton >> icon: aString [

	options at: #icon put: aString
]

{ #category : #accessing }
IonActionSheetButton >> id [

	^ options at: #id
]

{ #category : #accessing }
IonActionSheetButton >> id: aString [

	options at: #id put: aString
]

{ #category : #accessing }
IonActionSheetButton >> role [

	^ options at: #role
]

{ #category : #accessing }
IonActionSheetButton >> role: aString [

	"'cancel' | 'destructive' | 'selected' | string"

	options at: #role put: aString
]

{ #category : #accessing }
IonActionSheetButton >> text [

	^ options at: #text
]

{ #category : #accessing }
IonActionSheetButton >> text: aString [

	options at: #text put: aString
]
