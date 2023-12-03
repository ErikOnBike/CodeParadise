Class {
	#name : #CpMultiContent,
	#superclass : #CpSlideContent,
	#instVars : [
		'contentCollection'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Model'
}

{ #category : #adding }
CpMultiContent >> addContent: aContent [

	contentCollection add: aContent.

	self valueChanged.

	^ aContent
]

{ #category : #accessing }
CpMultiContent >> contentCollection [

	^ contentCollection
]

{ #category : #initialization }
CpMultiContent >> initialize [

	super initialize.

	contentCollection := OrderedCollection new
]
