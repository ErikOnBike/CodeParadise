"
I am the representation of a JavaScript HTMLMediaElement.
I can be used to access the MediaElement behavior more easily than
through the regular DOMElement interface which only supports DOM
manipulation behavior.

"
Class {
	#name : #CpBrowserMediaElement,
	#superclass : #CpBrowserEventTarget,
	#category : #'CodeParadise-Browser-Support-MediaStreams'
}

{ #category : #'instance creation' }
CpBrowserMediaElement class >> domElement: aDomElement [

	^ self wrap: aDomElement
]

{ #category : #accessing }
CpBrowserMediaElement >> currentTime [

	"A double-precision floating-point value indicating the current playback time in seconds; if the media has not started to play and has not been seeked, this value is the media's initial playback time. Setting this value seeks the media to the new time. The time is specified relative to the media's timeline."

	^ self propertyAt: #currentTime
]

{ #category : #accessing }
CpBrowserMediaElement >> currentTime: aFloat [

	"A double-precision floating-point value indicating the current playback time in seconds; if the media has not started to play and has not been seeked, this value is the media's initial playback time. Setting this value seeks the media to the new time. The time is specified relative to the media's timeline."

	self propertyAt: #currentTime put: aFloat
]

{ #category : #accessing }
CpBrowserMediaElement >> duration [

	"A read-only double-precision floating-point value indicating the total duration of the media in seconds. If no media data is available, the returned value is NaN. If the media is of indefinite length (such as streamed live media, a WebRTC call's media, or similar), the value is +Infinity."

	^ self propertyAt: #duration
]

{ #category : #accessing }
CpBrowserMediaElement >> loop [

	"A boolean that reflects the loop HTML attribute, which indicates whether the media element should start over when it reaches the end."

	^ self propertyAt: #loop
]

{ #category : #accessing }
CpBrowserMediaElement >> loop: aBoolean [

	"A boolean that reflects the loop HTML attribute, which indicates whether the media element should start over when it reaches the end."

	self propertyAt: #loop put: aBoolean
]

{ #category : #'event handling' }
CpBrowserMediaElement >> onPlayDo: aBlock [

	"Fired when the paused property is changed from true to false, as a result of the HTMLMediaElement.play() method, or the autoplay attribute."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addEventListener: #play handler: aBlock
]

{ #category : #operations }
CpBrowserMediaElement >> pause [

	"Pauses the media playback."

	self apply: #pause
]

{ #category : #accessing }
CpBrowserMediaElement >> paused [

	"Returns a boolean that indicates whether the media element is paused."

	^ self propertyAt: #paused
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
