Class {
	#name : #CpCurrentApplicationContext,
	#superclass : #DynamicVariable,
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #accessing }
CpCurrentApplicationContext class >> application [

	^ self value

]
