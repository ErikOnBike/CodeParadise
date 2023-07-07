Class {
	#name : #SlSkeleton,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlSkeleton >> effect [

	^ self propertyAt: #effect
]

{ #category : #accessing }
SlSkeleton >> effect: aString [

	self propertyAt: #effect put: aString
]

{ #category : #'accessing effect' }
SlSkeleton >> effectNone [

	self effect: #none
]

{ #category : #'accessing effect' }
SlSkeleton >> effectPulse [

	self effect: #pulse
]

{ #category : #'accessing effect' }
SlSkeleton >> effectSheen [

	self effect: #sheen
]

{ #category : #testing }
SlSkeleton >> hasEffect [

	^ self effect ~= #none
]
