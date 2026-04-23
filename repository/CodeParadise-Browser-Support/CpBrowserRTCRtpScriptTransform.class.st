"
For usage see: https://developer.mozilla.org/en-US/docs/Web/API/WebRTC_API/Using_Encoded_Transforms
"
Class {
	#name : #CpBrowserRTCRtpScriptTransform,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-WebRTC'
}

{ #category : #'instance creation' }
CpBrowserRTCRtpScriptTransform class >> worker: aWorker [

	"Creates a new instance of the RTCRtpScriptTransform object."

	^ self newInstanceWithArguments: { aWorker }
]

{ #category : #'instance creation' }
CpBrowserRTCRtpScriptTransform class >> worker: aWorker options: anObject [

	"Creates a new instance of the RTCRtpScriptTransform object."

	^ self newInstanceWithArguments: { aWorker . anObject }
]
