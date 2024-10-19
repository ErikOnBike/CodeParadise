Class {
	#name : #IonPicker,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonPicker >> exitInputMode [

	"Type: Promise<void>"

	^ self apply: #exitInputMode resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonPicker >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonPicker >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]
