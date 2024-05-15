Class {
	#name : 'CpSelectionChanged',
	#superclass : 'Announcement',
	#instVars : [
		'element'
	],
	#category : 'CodeParadise-Beach-Components',
	#package : 'CodeParadise-Beach',
	#tag : 'Components'
}

{ #category : 'accessing' }
CpSelectionChanged class >> element: anElement [

	^ self new
		element: anElement ;
		yourself
]

{ #category : 'accessing' }
CpSelectionChanged >> element [

	^ element
]

{ #category : 'accessing' }
CpSelectionChanged >> element: anElement [

	element := anElement
]
