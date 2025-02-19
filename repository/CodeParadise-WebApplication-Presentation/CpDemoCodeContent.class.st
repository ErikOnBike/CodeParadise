Class {
	#name : #CpDemoCodeContent,
	#superclass : #CpSlideContent,
	#instVars : [
		'code'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Examples'
}

{ #category : #accessing }
CpDemoCodeContent class >> code: aString [

	"Answer an instance of the receiver with the specified code"

	^ self new
		code: aString ;
		yourself
]

{ #category : #accessing }
CpDemoCodeContent >> code [

	^ code
]

{ #category : #accessing }
CpDemoCodeContent >> code: aString [

	code := aString.

	self valueChanged
]

{ #category : #queries }
CpDemoCodeContent >> statusString [

	"Answer the status of the receiver or nil if no partical status is applicable"

	^ nil
]
