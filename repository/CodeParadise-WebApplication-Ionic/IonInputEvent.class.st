Class {
	#name : #IonInputEvent,
	#superclass : #IonEvent,
	#category : #'CodeParadise-WebApplication-Ionic-Events'
}

{ #category : #accessing }
IonInputEvent >> value [

	^ self propertyAt: #value
]
