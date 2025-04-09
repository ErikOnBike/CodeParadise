Class {
	#name : #IonIcon,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #'instance creation' }
IonIcon class >> named: aString [

	^ self new
		name: aString ;
		yourself
]

{ #category : #accessing }
IonIcon >> color [

	^ self attributeAt: #color
]

{ #category : #accessing }
IonIcon >> color: aString [

	self attributeAt: #color put: aString
]

{ #category : #accessing }
IonIcon >> name [

	^ self attributeAt: #name
]

{ #category : #accessing }
IonIcon >> name: aString [

	self attributeAt: #name put: aString
]

{ #category : #accessing }
IonIcon >> size [

	^ self attributeAt: #size
]

{ #category : #accessing }
IonIcon >> size: aString [

	self attributeAt: #size put: aString
]
