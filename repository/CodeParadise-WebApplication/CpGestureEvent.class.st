Class {
	#name : 'CpGestureEvent',
	#superclass : 'CpUserInterfaceEvent',
	#category : 'CodeParadise-WebApplication-Events',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Events'
}

{ #category : 'printing' }
CpGestureEvent >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ', rotation: ' ;
		print: self rotation ;
		nextPutAll: ', scale: ' ;
		print: self scale
]

{ #category : 'accessing' }
CpGestureEvent >> rotation [

	^ self propertyAt: #rotation
]

{ #category : 'accessing' }
CpGestureEvent >> scale [

	^ self propertyAt: #scale
]
