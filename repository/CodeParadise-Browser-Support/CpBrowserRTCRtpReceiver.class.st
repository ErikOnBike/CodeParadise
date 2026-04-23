Class {
	#name : #CpBrowserRTCRtpReceiver,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-WebRTC'
}

{ #category : #operations }
CpBrowserRTCRtpReceiver >> getContributingSources [

	"Returns an array that contains an object for each unique CSRC (contributing source) identifier received by the current RTCRtpReceiver in the last ten seconds."

	^ self apply: #getContributingSources
]

{ #category : #operations }
CpBrowserRTCRtpReceiver >> getParameters [

	"Returns an object that contains information about how the RTC data is to be decoded."

	^ self apply: #getParameters
]

{ #category : #operations }
CpBrowserRTCRtpReceiver >> getStats [

	"Returns a Promise whose fulfillment handler receives a RTCStatsReport which contains statistics about the incoming streams and their dependencies."

	^ self apply: #getStats resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpBrowserRTCRtpReceiver >> getSynchronizationSources [

	"Returns an array that contains an object for each unique SSRC (synchronization source) identifier received by the current RTCRtpReceiver in the last ten seconds."

	^ self apply: #getSynchronizationSources
]

{ #category : #accessing }
CpBrowserRTCRtpReceiver >> jitterBufferTarget [

	"A DOMHighResTimeStamp that indicates an application's preferred hold time for media in the jitter buffer, allowing it influence the tradeoff between playout delay and the risk of running out of audio or video frames due to network jitter."

	^ self propertyAt: #jitterBufferTarget
]

{ #category : #accessing }
CpBrowserRTCRtpReceiver >> track [

	"Returns the MediaStreamTrack associated with the current RTCRtpReceiver instance."

	^ self propertyAt: #track resultAs: CpBrowserMediaStreamTrack
]

{ #category : #accessing }
CpBrowserRTCRtpReceiver >> transform [

	"An RTCRtpScriptTransform is used to insert a transform stream (TransformStream) running in a worker thread into the receiver pipeline, allowing stream transforms to be applied to incoming encoded video and audio frames."

	^ self propertyAt: #transform resultAs: CpBrowserRTCRtpScriptTransform
]

{ #category : #accessing }
CpBrowserRTCRtpReceiver >> transport [

	"Returns the RTCDtlsTransport instance over which the media for the receiver's track is received."

	^ self propertyAt: #transport resultAs: CpBrowserRTCDtlsTransport
]
