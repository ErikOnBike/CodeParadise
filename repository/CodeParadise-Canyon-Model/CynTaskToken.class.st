Class {
	#name : #CynTaskToken,
	#superclass : #CynPropertyEntity,
	#instVars : [
		'#task => CynPropertySlot',
		'#token => CynPropertySlot'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #accessing }
CynTaskToken >> token [

	^ token
]

{ #category : #accessing }
CynTaskToken >> token: aString [

	token := aString
]
