Class {
	#name : #IonBackdrop,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonBackdrop >> stopPropagation [

	"If 'true', the backdrop will stop propagation on tap.
	
	Type: boolean"

	^ self propertyAt: #stopPropagation
]

{ #category : #api }
IonBackdrop >> stopPropagation: aBoolean [

	"If 'true', the backdrop will stop propagation on tap.
	
	Type: boolean"

	self propertyAt: #stopPropagation put: aBoolean
]

{ #category : #api }
IonBackdrop >> tappable [

	"If 'true', the backdrop will can be clicked and will emit the 'ionBackdropTap' event.
	
	Type: boolean"

	^ self propertyAt: #tappable
]

{ #category : #api }
IonBackdrop >> tappable: aBoolean [

	"If 'true', the backdrop will can be clicked and will emit the 'ionBackdropTap' event.
	
	Type: boolean"

	self propertyAt: #tappable put: aBoolean
]

{ #category : #api }
IonBackdrop >> visible [

	"If 'true', the backdrop will be visible.
	
	Type: boolean"

	^ self propertyAt: #visible
]

{ #category : #api }
IonBackdrop >> visible: aBoolean [

	"If 'true', the backdrop will be visible.
	
	Type: boolean"

	self propertyAt: #visible put: aBoolean
]
