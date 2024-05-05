"
I am the representation of a JavaScript HTMLMediaElement.
I can be used to access the MediaElement behavior more easily than
through the regular DOMElement interface which only supports DOM
manipulation behavior.

"
Class {
	#name : #CpBrowserMediaElement,
	#superclass : #CpJavaScriptEventTarget,
	#category : #'CodeParadise-Browser-Support-MediaStreams'
}

{ #category : #'instance creation' }
CpBrowserMediaElement class >> domElement: aDomElement [

	^ self wrap: aDomElement
]

{ #category : #operations }
CpBrowserMediaElement >> plause [

	"Pauses the media playback."

	self apply: #pause
]

{ #category : #operations }
CpBrowserMediaElement >> play [

	"Begins playback of the media."

	self apply: #play
]

{ #category : #operations }
CpBrowserMediaElement >> srcObject [

	"A MediaStream representing the media to play or that has played in the current HTMLMediaElement, or null if not assigned."

	^ self propertyAt: #srcObject
]

{ #category : #operations }
CpBrowserMediaElement >> srcObject: aMediaStream [

	"A MediaStream representing the media to play or that has played in the current HTMLMediaElement, or null if not assigned."

	self propertyAt: #srcObject put: aMediaStream
]
