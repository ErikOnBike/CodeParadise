Class {
	#name : 'CpBrowserVideoElement',
	#superclass : 'CpBrowserMediaElement',
	#category : 'CodeParadise-Browser-Support-MediaStreams',
	#package : 'CodeParadise-Browser-Support',
	#tag : 'MediaStreams'
}

{ #category : 'accessing' }
CpBrowserVideoElement >> videoHeight [

	"Returns an unsigned integer value indicating the intrinsic height of the resource in CSS pixels, or 0 if no media is available yet."

	^ self propertyAt: #videoHeight
]

{ #category : 'accessing' }
CpBrowserVideoElement >> videoWidth [

	"Returns an unsigned integer value indicating the intrinsic width of the resource in CSS pixels, or 0 if no media is available yet."

	^ self propertyAt: #videoWidth
]
