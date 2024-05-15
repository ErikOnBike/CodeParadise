Class {
	#name : 'CpCompositionEvent',
	#superclass : 'CpUserInterfaceEvent',
	#category : 'CodeParadise-WebApplication-Events',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Events'
}

{ #category : 'accessing' }
CpCompositionEvent >> data [

	^ self propertyAt: #data
]

{ #category : 'printing' }
CpCompositionEvent >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ', data: ' ;
		print: self data
]
