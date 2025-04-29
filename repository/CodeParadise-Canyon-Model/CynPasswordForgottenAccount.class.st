Class {
	#name : #CynPasswordForgottenAccount,
	#superclass : #CynAccount,
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #initialization }
CynPasswordForgottenAccount >> initializeProperties [

	super initializeProperties.

	task := #passwordForgotten
]
