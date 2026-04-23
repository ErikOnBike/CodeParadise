Class {
	#name : #CpBrowserRTCSctpTransport,
	#superclass : #CpBrowserEventTarget,
	#category : #'CodeParadise-Browser-Support-WebRTC'
}

{ #category : #'instance creation' }
CpBrowserRTCSctpTransport class >> newInstanceWithArguments: anArray resultAs: aClass [

	self error: 'This class should not be instantiated manually'
]

{ #category : #accessing }
CpBrowserRTCSctpTransport >> maxChannels [

	"An integer value indicating the maximum number of RTCDataChannel objects that can be opened simultaneously."

	^ self propertyAt: #maxChannels
]

{ #category : #accessing }
CpBrowserRTCSctpTransport >> maxMessageSize [

	"An integer value indicating the maximum size, in bytes, of a message which can be sent using the RTCDataChannel.send() method."

	^ self propertyAt: #maxMessageSize
]

{ #category : #accessing }
CpBrowserRTCSctpTransport >> state [

	"A string enumerated value indicating the state of the SCTP transport."

	^ self propertyAt: #state
]

{ #category : #accessing }
CpBrowserRTCSctpTransport >> transport [

	"An RTCDtlsTransport object representing the DTLS transport used for the transmission and receipt of data packets."

	^ self propertyAt: #transport resultAs: CpBrowserRTCDtlsTransport
]
