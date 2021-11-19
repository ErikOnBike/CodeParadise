Class {
	#name : #SlIcon,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlIcon class >> name: aString [

	^ self new
		name: aString ;
		yourself
]

{ #category : #accessing }
SlIcon >> library [

	^ self propertyAt: #library
]

{ #category : #accessing }
SlIcon >> library: aString [

	self propertyAt: #library put: aString
]

{ #category : #accessing }
SlIcon >> name [

	^ self propertyAt: #name
]

{ #category : #accessing }
SlIcon >> name: aString [

	self propertyAt: #name put: aString
]

{ #category : #accessing }
SlIcon >> src [

	^ self propertyAt: #src
]

{ #category : #accessing }
SlIcon >> src: aString [

	self propertyAt: #src put: aString
]
