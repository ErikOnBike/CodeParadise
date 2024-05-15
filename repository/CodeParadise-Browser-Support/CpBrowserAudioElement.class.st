Class {
	#name : 'CpBrowserAudioElement',
	#superclass : 'CpBrowserMediaElement',
	#category : 'CodeParadise-Browser-Support-MediaStreams',
	#package : 'CodeParadise-Browser-Support',
	#tag : 'MediaStreams'
}

{ #category : 'accessing' }
CpBrowserAudioElement class >> getClassName [

	"Browsers have an explicit class for me"

	^ 'Audio'
]

{ #category : 'instance creation' }
CpBrowserAudioElement class >> url: aString [

	"Answer a new instance with the specified URL"

	^ self newInstanceWithArguments: { aString }
]
