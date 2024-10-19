Class {
	#name : #IonFabList,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonFabList >> activated [

	"If 'true', the fab list will show all fab buttons in the list.
	
	Type: boolean"

	^ self propertyAt: #activated
]

{ #category : #api }
IonFabList >> activated: aBoolean [

	"If 'true', the fab list will show all fab buttons in the list.
	
	Type: boolean"

	self propertyAt: #activated put: aBoolean
]

{ #category : #api }
IonFabList >> side [

	"The side the fab list will show on relative to the main fab button.
	
	Type: 'start' | 'end' | 'top' | 'bottom'"

	^ self propertyAt: #side
]

{ #category : #api }
IonFabList >> side: aString [

	"The side the fab list will show on relative to the main fab button.
	
	Type: 'start' | 'end' | 'top' | 'bottom'"

	self propertyAt: #side put: aString
]
