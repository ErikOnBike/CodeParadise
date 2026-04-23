Class {
	#name : #CpBrowserRTCIceCandidatePair,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-WebRTC'
}

{ #category : #'instance creation' }
CpBrowserRTCIceCandidatePair class >> newInstanceWithArguments: anArray resultAs: aClass [

	self error: 'This class should not be instantiated manually'
]

{ #category : #accessing }
CpBrowserRTCIceCandidatePair >> local [

	"An RTCIceCandidate describing the configuration of the local end of the connection."

	^ self propertyAt: #local resultAs: CpBrowserRTCIceCandidate
]

{ #category : #accessing }
CpBrowserRTCIceCandidatePair >> remote [

	"The RTCIceCandidate describing the configuration of the remote end of the connection."

	^ self propertyAt: #remote resultAs: CpBrowserRTCIceCandidate
]
