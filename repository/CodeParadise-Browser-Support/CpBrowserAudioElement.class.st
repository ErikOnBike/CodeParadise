Class {
	#name : #CpBrowserAudioElement,
	#superclass : #CpBrowserMediaElement,
	#category : #'CodeParadise-Browser-Support-MediaStreams'
}

{ #category : #accessing }
CpBrowserAudioElement class >> getClassName [

	"Browsers have an explicit class for me"

	^ 'Audio'
]

{ #category : #'instance creation' }
CpBrowserAudioElement class >> url: aString [

	"Answer a new instance with the specified URL"

	^ self newInstanceWithArguments: { aString }
]
