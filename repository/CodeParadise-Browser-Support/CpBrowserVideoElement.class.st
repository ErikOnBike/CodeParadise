Class {
	#name : #CpBrowserVideoElement,
	#superclass : #CpBrowserMediaElement,
	#category : #'CodeParadise-Browser-Support-MediaStreams'
}

{ #category : #accessing }
CpBrowserVideoElement >> height [

	"A string that reflects the height HTML attribute, which specifies the height of the display area, in CSS pixels"

	^ self propertyAt: #height
]

{ #category : #accessing }
CpBrowserVideoElement >> videoHeight [

	"Returns an unsigned integer value indicating the intrinsic height of the resource in CSS pixels, or 0 if no media is available yet."

	^ self propertyAt: #videoHeight
]

{ #category : #accessing }
CpBrowserVideoElement >> videoWidth [

	"Returns an unsigned integer value indicating the intrinsic width of the resource in CSS pixels, or 0 if no media is available yet."

	^ self propertyAt: #videoWidth
]

{ #category : #accessing }
CpBrowserVideoElement >> width [

	"A string that reflects the width HTML attribute, which specifies the width of the display area, in CSS pixels"

	^ self propertyAt: #width
]
