Class {
	#name : #CpBrowserRTCRtpSender,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-WebRTC'
}

{ #category : #operations }
CpBrowserRTCRtpSender class >> getCapabilities [

	"Returns an object describing the system's capabilities for sending a specified kind of media data."

	^ self apply: #getCapabilities
]

{ #category : #accessing }
CpBrowserRTCRtpSender >> dtmf [

	"An RTCDTMFSender which can be used to send DTMF tones using telephone-event payloads on the RTP session represented by the RTCRtpSender object. If null, the track and/or the connection doesn't support DTMF. Only audio tracks can support DTMF."

	^ self propertyAt: #dtmf resultAs: CpBrowserRTCDTMFSender
]

{ #category : #operations }
CpBrowserRTCRtpSender >> getParameters [

	"Returns an object describing the current configuration for the encoding and transmission of media on the track."

	^ self apply: #getParameters 
]

{ #category : #operations }
CpBrowserRTCRtpSender >> getStats [

	"Returns a Promise which is fulfilled with a RTCStatsReport which provides statistics data for all outbound streams being sent using this RTCRtpSender."

	^ self apply: #getStats resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpBrowserRTCRtpSender >> replaceTrack: aMediaStreamTrack [

	"Attempts to replace the track currently being sent by the RTCRtpSender with another track, without performing renegotiation. This method can be used, for example, to toggle between the front- and rear-facing cameras on a device."

	^ self apply: #replaceTrack withArguments: { aMediaStreamTrack } resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpBrowserRTCRtpSender >> setParameters: aDictionary [

	"Applies changes to parameters which configure how the track is encoded and transmitted to the remote peer."

	^ self apply: #setParameters withArguments: { aDictionary } resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpBrowserRTCRtpSender >> setStreams: aMediaStreamOrCollection [

	"Sets the stream(s) associated with the track being transmitted by this sender."

	self apply: #setStreams withArguments: (aMediaStreamOrCollection isCollection ifTrue: [ aMediaStreamOrCollection ] ifFalse: [ { aMediaStreamOrCollection } ])
]

{ #category : #accessing }
CpBrowserRTCRtpSender >> track [

	"The MediaStreamTrack which is being handled by the RTCRtpSender. If track is null, the RTCRtpSender doesn't transmit anything."

	^ self propertyAt: #track resultAs: CpBrowserMediaStreamTrack
]

{ #category : #accessing }
CpBrowserRTCRtpSender >> transform [

	"An RTCRtpScriptTransform is used to insert a transform stream (TransformStream) running in a worker thread into the sender pipeline, allowing stream transforms to be applied to encoded video and audio frames after they are output by a codec, and before they are sent."

	^ self propertyAt: #transform resultAs: CpBrowserRTCRtpScriptTransform
]

{ #category : #accessing }
CpBrowserRTCRtpSender >> transport [

	"The RTCDtlsTransport over which the sender is exchanging the RTP and RTCP packets used to manage transmission of media and control data. This value is null until the transport is established. When bundling is in use, more than transceiver may be sharing the same transport object."

	^ self propertyAt: #transport resultAs: CpBrowserRTCDtlsTransport
]
