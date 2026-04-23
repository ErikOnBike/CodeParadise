Class {
	#name : #CpBrowserRTCDtlsTransport,
	#superclass : #CpBrowserEventTarget,
	#category : #'CodeParadise-Browser-Support-WebRTC'
}

{ #category : #'instance creation' }
CpBrowserRTCDtlsTransport class >> newInstanceWithArguments: anArray resultAs: aClass [

	self error: 'This class should not be instantiated manually'
]

{ #category : #operations }
CpBrowserRTCDtlsTransport >> getRemoteCertificates [

	"Returns an array of ArrayBuffer containing the certificates of the remote peer of the connection."

	^ self apply: #getRemoteCertificates
]

{ #category : #accessing }
CpBrowserRTCDtlsTransport >> iceTransport [

	"Returns a reference to the underlying RTCIceTransport object."

	^ self propertyAt: #iceTransport resultAs: CpBrowserRTCIceTransport
]

{ #category : #accessing }
CpBrowserRTCDtlsTransport >> state [

	"Returns a string which describes the underlying Datagram Transport Layer Security (DTLS) transport state. It can be one of the following values: new, connecting, connected, closed, or failed."

	^ self propertyAt: #state
]
