Class {
	#name : #SlTextarea,
	#superclass : #SlTextControl,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlTextarea >> resize [

	^ self propertyAt: #resize
]

{ #category : #accessing }
SlTextarea >> resize: aString [

	self propertyAt: #resize put: aString
]

{ #category : #'accessing style' }
SlTextarea >> resizeAuto [

	self resize: #auto
]

{ #category : #'accessing style' }
SlTextarea >> resizeNone [

	self resize: #none
]

{ #category : #'accessing style' }
SlTextarea >> resizeVertical [

	self resize: #vertical
]

{ #category : #accessing }
SlTextarea >> rows [

	^ self propertyAt: #rows
]

{ #category : #accessing }
SlTextarea >> rows: anInteger [

	self propertyAt: #rows put: anInteger
]

{ #category : #'accessing style' }
SlTextarea >> scrollPosition [

	"Gets the textarea's scroll position.
	Answer will be a dictionaty with keys 'top' and 'left', both being Numbers."

	^ self syncApply: #scrollPosition withArguments: #()
]

{ #category : #'accessing style' }
SlTextarea >> scrollPositionTop: topNumber left: leftNumber [

	"Sets the textarea's scroll position"

	^ self apply: #scrollPosition withArguments: { topNumber . leftNumber }
]
