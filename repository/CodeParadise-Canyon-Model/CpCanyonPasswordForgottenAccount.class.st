Class {
	#name : #CpCanyonPasswordForgottenAccount,
	#superclass : #CpCanyonAccount,
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #initialization }
CpCanyonPasswordForgottenAccount >> initializeProperties [

	super initializeProperties.

	task := #passwordForgotten
]
