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
SlIcon >> name: aString [

	self attributeAt: #name put: aString
]
