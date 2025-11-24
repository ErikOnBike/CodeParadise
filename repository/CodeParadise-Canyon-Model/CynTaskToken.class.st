Class {
	#name : #CynTaskToken,
	#superclass : #CynPropertyEntity,
	#instVars : [
		'#token => CynPropertySlot'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #'accessing - generated' }
CynTaskToken class >> allPropertyNames [

	"Generated code. DO NOT EDIT"

	^ #(id token)
]

{ #category : #'accessing - generated' }
CynTaskToken class >> readWriteProperties [

	"Generated code. DO NOT EDIT"

	^ #(id token)
]

{ #category : #accessing }
CynTaskToken >> token [

	^ token
]

{ #category : #accessing }
CynTaskToken >> token: aString [

	token := aString
]
