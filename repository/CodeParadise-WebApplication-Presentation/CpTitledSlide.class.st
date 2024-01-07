Class {
	#name : 'CpTitledSlide',
	#superclass : 'CpSlide',
	#instVars : [
		'title'
	],
	#category : 'CodeParadise-WebApplication-Presentation-Model',
	#package : 'CodeParadise-WebApplication-Presentation',
	#tag : 'Model'
}

{ #category : 'accessing' }
CpTitledSlide >> title [

	^ title
]

{ #category : 'accessing' }
CpTitledSlide >> title: aString [

	title := aString.

	self valueChanged
]
