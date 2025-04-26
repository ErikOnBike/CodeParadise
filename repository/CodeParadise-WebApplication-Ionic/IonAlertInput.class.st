Class {
	#name : #IonAlertInput,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-WebApplication-Ionic-Support'
}

{ #category : #accessing }
IonAlertInput >> checked [

	^ options at: #checked
]

{ #category : #accessing }
IonAlertInput >> checked: aBoolean [

	options at: #checked put: aBoolean
]

{ #category : #accessing }
IonAlertInput >> data [

	^ options at: #data
]

{ #category : #accessing }
IonAlertInput >> data: anObject [

	options at: #data put: anObject
]

{ #category : #accessing }
IonAlertInput >> disabled [

	^ options at: #disabled
]

{ #category : #accessing }
IonAlertInput >> disabled: aBoolean [

	options at: #disabled put: aBoolean
]

{ #category : #accessing }
IonAlertInput >> handler [

	^ options at: #handler
]

{ #category : #accessing }
IonAlertInput >> handler: aBlock [

	options at: #handler put: aBlock
]

{ #category : #accessing }
IonAlertInput >> htmlAttributes [

	^ options at: #htmlAttributes
]

{ #category : #accessing }
IonAlertInput >> htmlAttributes: anObject [

	options at: #htmlAttributes put: anObject
]

{ #category : #accessing }
IonAlertInput >> id [

	^ options at: #id
]

{ #category : #accessing }
IonAlertInput >> id: aString [

	options at: #id put: aString
]

{ #category : #accessing }
IonAlertInput >> label [

	^ options at: #label
]

{ #category : #accessing }
IonAlertInput >> label: aString [

	options at: #label put: aString
]

{ #category : #accessing }
IonAlertInput >> name [

	^ options at: #name
]

{ #category : #accessing }
IonAlertInput >> name: aString [

	options at: #name put: aString
]

{ #category : #accessing }
IonAlertInput >> placeholder [

	^ options at: #placeholder
]

{ #category : #accessing }
IonAlertInput >> placeholder: aString [

	options at: #placeholder put: aString
]

{ #category : #accessing }
IonAlertInput >> type [

	^ options at: #type
]

{ #category : #accessing }
IonAlertInput >> type: aString [

	options at: #type put: aString
]

{ #category : #accessing }
IonAlertInput >> value [

	^ options at: #value
]

{ #category : #accessing }
IonAlertInput >> value: anObject [

	options at: #value put: anObject
]
