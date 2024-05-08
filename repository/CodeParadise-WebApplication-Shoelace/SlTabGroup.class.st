Class {
	#name : 'SlTabGroup',
	#superclass : 'SlElement',
	#category : 'CodeParadise-WebApplication-Shoelace-Elements',
	#package : 'CodeParadise-WebApplication-Shoelace',
	#tag : 'Elements'
}

{ #category : 'accessing placement' }
SlTabGroup >> beBottom [

	self placement: #bottom
]

{ #category : 'accessing placement' }
SlTabGroup >> beEnd [

	self placement: #end
]

{ #category : 'accessing placement' }
SlTabGroup >> beStart [

	self placement: #start
]

{ #category : 'accessing placement' }
SlTabGroup >> beTop [

	self placement: #top
]

{ #category : 'accessing placement' }
SlTabGroup >> placement [

	"Answer the placement of the tabs"

	^ self propertyAt: #placement

]

{ #category : 'accessing placement' }
SlTabGroup >> placement: aString [

	"The placement of the tabs. 'top' | 'bottom' | 'start' | 'end'"

	self propertyAt: #placement put: aString
]
