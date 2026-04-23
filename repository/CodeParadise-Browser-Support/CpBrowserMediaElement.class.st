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
CpBrowserMediaElement >> autoplay [

	"A boolean value that reflects the autoplay HTML attribute, indicating whether playback should automatically begin as soon as enough media is available to do so without interruption."

	^ self propertyAt: #autoplay
]

{ #category : #accessing }
CpBrowserMediaElement >> autoplay: aBoolean [

	"A boolean value that reflects the autoplay HTML attribute, indicating whether playback should automatically begin as soon as enough media is available to do so without interruption."

	self propertyAt: #autoplay put: aBoolean
]

{ #category : #accessing }
CpBrowserMediaElement >> buffered [

	"Returns a TimeRanges object that indicates the ranges of the media source that the browser has buffered (if any) at the moment the buffered property is accessed."

	^ self propertyAt: #buffered resultAs: CpBrowserTimeRanges
]

{ #category : #accessing }
CpBrowserMediaElement >> controls [

	"A boolean that reflects the controls HTML attribute, indicating whether user interface items for controlling the resource should be displayed."

	^ self propertyAt: #controls
]

{ #category : #accessing }
CpBrowserMediaElement >> controls: aBoolean [

	"A boolean that reflects the controls HTML attribute, indicating whether user interface items for controlling the resource should be displayed."

	self propertyAt: #controls put: aBoolean
]

{ #category : #accessing }
CpBrowserMediaElement >> crossOrigin [

	"A string indicating the CORS setting for this media element."

	^ self propertyAt: #crossOrigin
]

{ #category : #accessing }
CpBrowserMediaElement >> crossOrigin: aString [

	"A string indicating the CORS setting for this media element."

	self propertyAt: #crossOrigin put: aString
]

{ #category : #accessing }
CpBrowserMediaElement >> currentSrc [

	"Returns a string with the absolute URL of the chosen media resource."

	^ self propertyAt: #currentSrc
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
CpBrowserMediaElement >> ended [

	"Returns a boolean that indicates whether the media element has finished playing."

	^ self propertyAt: #ended
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

{ #category : #accessing }
CpBrowserMediaElement >> muted [

	"A boolean that determines whether audio is muted. true if the audio is muted and false otherwise."

	^ self propertyAt: #muted
]

{ #category : #accessing }
CpBrowserMediaElement >> muted: aBoolean [

	"A boolean that determines whether audio is muted. true if the audio is muted and false otherwise."

	self propertyAt: #muted put: aBoolean
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

	^ self apply: #play resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpBrowserMediaElement >> played [

	"Returns a TimeRanges object that contains the ranges of the media source that the browser has played, if any."

	^ self propertyAt: #played resultAs: CpBrowserTimeRanges
]

{ #category : #accessing }
CpBrowserMediaElement >> seekable [

	"Returns a TimeRanges object that contains the time ranges that the user is able to seek to, if any."

	^ self propertyAt: #seekable resultAs: CpBrowserTimeRanges
]

{ #category : #accessing }
CpBrowserMediaElement >> seeking [

	"Returns a boolean that indicates whether the media is in the process of seeking to a new position."

	^ self propertyAt: #seeking
]

{ #category : #accessing }
CpBrowserMediaElement >> src [

	"A string that reflects the src HTML attribute, which contains the URL of a media resource to use."

	^ self propertyAt: #src
]

{ #category : #accessing }
CpBrowserMediaElement >> src: aString [

	"A string that reflects the src HTML attribute, which contains the URL of a media resource to use."

	self propertyAt: #src put: aString
]

{ #category : #accessing }
CpBrowserMediaElement >> srcObject [

	"A MediaStream representing the media to play or that has played in the current HTMLMediaElement, or null if not assigned."

	^ self propertyAt: #srcObject
]

{ #category : #accessing }
CpBrowserMediaElement >> srcObject: aMediaStream [

	"A MediaStream representing the media to play or that has played in the current HTMLMediaElement, or null if not assigned."

	self propertyAt: #srcObject put: aMediaStream
]

{ #category : #accessing }
CpBrowserMediaElement >> volume [

	"A double indicating the audio volume, from 0.0 (silent) to 1.0 (loudest)."

	^ self propertyAt: #volume
]

{ #category : #accessing }
CpBrowserMediaElement >> volume: aFloat [

	"A double indicating the audio volume, from 0.0 (silent) to 1.0 (loudest)."

	self propertyAt: #volume put: aFloat
]
