Class {
	#name : #CpBrowserRTCRtpScriptTransformer,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-WebRTC'
}

{ #category : #operations }
CpBrowserRTCRtpScriptTransformer >> generateKeyFrame [

	"Requests a video encoder generate a key frame. May be called by a transformer in the sender pipeline when processing outgoing frames."

	^ self apply: #generateKeyFrame resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpBrowserRTCRtpScriptTransformer >> generateKeyFrame: aString [

	"Requests a video encoder generate a key frame. May be called by a transformer in the sender pipeline when processing outgoing frames."

	^ self apply: #generateKeyFrame withArguments: { aString } resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpBrowserRTCRtpScriptTransformer >> options [

	"Options passed from the RTCRtpScriptTransform constructor, which are used to configure transform code based on whether incoming or outgoing frames are being processed."

	^ self propertyAt: #options
]

{ #category : #accessing }
CpBrowserRTCRtpScriptTransformer >> readable [

	"A ReadableStream on which encoded frames from the WebRTC sender or receiver pipelines may be enqueued."

	^ self propertyAt: #readable resultAs: CpBrowserReadableStream
]

{ #category : #operations }
CpBrowserRTCRtpScriptTransformer >> sendKeyFrameRequest [

	"Requests the sender send a key frame. May be called by a transformer in the receiver pipeline when processing incoming encoded video frames."

	^ self apply: #sendKeyFrameRequest resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpBrowserRTCRtpScriptTransformer >> writable [

	"A WritableStream that encoded frames should be piped to."

	^ self propertyAt: #writable resultAs: CpBrowserWritableStream
]
