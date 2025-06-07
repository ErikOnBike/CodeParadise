Class {
	#name : #CynPasswordForgottenAccount,
	#superclass : #CynAccount,
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #'accessing - generated' }
CynPasswordForgottenAccount class >> allPropertyNames [

	"Generated code. DO NOT EDIT"

	^ #(id task email)
]

{ #category : #'accessing - generated' }
CynPasswordForgottenAccount class >> readWriteProperties [

	"Generated code. DO NOT EDIT"

	^ #(id task email)
]

{ #category : #initialization }
CynPasswordForgottenAccount >> initializeProperties [

	super initializeProperties.

	task := #passwordForgotten
]
