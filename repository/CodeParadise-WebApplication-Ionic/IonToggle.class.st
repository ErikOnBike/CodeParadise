Class {
	#name : #IonToggle,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #accessing }
IonToggle >> checked [

	"If true, the toggle is selected.
	Attribute:	checked
	Type	boolean
	Default	false"

	^ self propertyAt: #checked
]

{ #category : #accessing }
IonToggle >> checked: aBoolean [

	"If true, the toggle is selected.
	Attribute:	checked
	Type	boolean
	Default	false"

	self propertyAt: #checked put: aBoolean
]
