Class {
	#name : #CpBrowserRTCRtpTransceiver,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-WebRTC'
}

{ #category : #accessing }
CpBrowserRTCRtpTransceiver >> currentDirection [

	"A read-only string which indicates the transceiver's current negotiated directionality, or null if the transceiver has never participated in an exchange of offers and answers. To change the transceiver's directionality, set the value of the direction property."

	^ self propertyAt: #currentDirection
]

{ #category : #accessing }
CpBrowserRTCRtpTransceiver >> direction [

	"A string which is used to set the transceiver's desired direction."

	^ self propertyAt: #direction
]

{ #category : #accessing }
CpBrowserRTCRtpTransceiver >> direction: aString [

	"A string which is used to set the transceiver's desired direction."

	self propertyAt: #direction put: aString
]

{ #category : #accessing }
CpBrowserRTCRtpTransceiver >> mid [

	"The media ID of the m-line associated with this transceiver. This association is established, when possible, whenever either a local or remote description is applied. This field is null if neither a local or remote description has been applied, or if its associated m-line is rejected by either a remote offer or any answer."

	^ self propertyAt: #mid
]

{ #category : #accessing }
CpBrowserRTCRtpTransceiver >> receiver [

	"The RTCRtpReceiver object that handles receiving and decoding incoming media."

	^ self propertyAt: #receiver resultAs: CpBrowserRTCRtpReceiver
]

{ #category : #accessing }
CpBrowserRTCRtpTransceiver >> sender [

	"The RTCRtpSender object responsible for encoding and sending data to the remote peer."

	^ self propertyAt: #sender resultAs: CpBrowserRTCRtpSender
]

{ #category : #operations }
CpBrowserRTCRtpTransceiver >> setCodecPreferences: aDictionary [

	"Configures the transceiver's preferred list of codecs, overriding user agent settings."

	self apply: #setCodecPreferences withArguments: { aDictionary }
]

{ #category : #operations }
CpBrowserRTCRtpTransceiver >> stop [

	"Permanently stops the RTCRtpTransceiver. The associated sender stops sending data, and the associated receiver likewise stops receiving and decoding incoming data."

	self apply: #stop
]
