Class {
	#name : #CpWaInterfaceEvent,
	#superclass : #Object,
	#instVars : [
		'name',
		'properties'
	],
	#category : #'CodeParadise-WebApplication-WebAwesome-Support'
}

{ #category : #adding }
CpWaInterfaceEvent >> addPropertyName: aString typeDescription: aDictionary [

	properties ifNil: [ properties := OrderedCollection new ].

	properties add: aString -> aDictionary
]

{ #category : #actions }
CpWaInterfaceEvent >> install [

	CpWaInterfaceInstaller installClass: self name asSymbol asSubclassOf: WaEvent inTag: 'Events'
]

{ #category : #accessing }
CpWaInterfaceEvent >> name [

	^ name
]

{ #category : #accessing }
CpWaInterfaceEvent >> name: aString [

	name := aString
]
