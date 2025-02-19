Class {
	#name : #CpLinkedContent,
	#superclass : #CpSlideContent,
	#instVars : [
		'linkedSlide',
		'content'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Model'
}

{ #category : #accessing }
CpLinkedContent >> content [

	^ content
]

{ #category : #accessing }
CpLinkedContent >> content: aSlideContent [

	content := aSlideContent
]

{ #category : #accessing }
CpLinkedContent >> linkedSlide [

	^ linkedSlide
]

{ #category : #accessing }
CpLinkedContent >> linkedSlide: aSlide [

	linkedSlide := aSlide
]
