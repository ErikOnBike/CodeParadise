Class {
	#name : #CpBrowserRTCDataChannel,
	#superclass : #CpBrowserEventTarget,
	#category : #'CodeParadise-Browser-Support-WebRTC'
}

{ #category : #accessing }
CpBrowserRTCDataChannel >> binaryType [

	"A string specifying the type of object that should be used to represent binary data received on the RTCDataChannel. Values are the same as allowed on the WebSocket.binaryType property: blob if Blob objects are being used, or arraybuffer if ArrayBuffer objects are being used. The default is arraybuffer."

	^ self propertyAt: #binaryType
]

{ #category : #accessing }
CpBrowserRTCDataChannel >> binaryType: aString [

	"A string specifying the type of object that should be used to represent binary data received on the RTCDataChannel. Values are the same as allowed on the WebSocket.binaryType property: blob if Blob objects are being used, or arraybuffer if ArrayBuffer objects are being used. The default is arraybuffer."

	self propertyAt: #binaryType put: aString
]

{ #category : #accessing }
CpBrowserRTCDataChannel >> bufferedAmount [

	"Returns the number of bytes of data currently queued to be sent over the data channel."

	^ self propertyAt: #bufferedAmount
]

{ #category : #accessing }
CpBrowserRTCDataChannel >> bufferedAmountLowThreshold [

	"Specifies the number of bytes of buffered outgoing data that is considered 'low'. The default value is 0."

	^ self propertyAt: #bufferedAmountLowThreshold
]

{ #category : #accessing }
CpBrowserRTCDataChannel >> bufferedAmountLowThreshold: anInteger [

	"Specifies the number of bytes of buffered outgoing data that is considered 'low'. The default value is 0."

	self propertyAt: #bufferedAmountLowThreshold put: anInteger
]

{ #category : #operations }
CpBrowserRTCDataChannel >> close [

	"Closes the RTCDataChannel. Either peer is permitted to call this method to initiate closure of the channel."

	self apply: #close
]

{ #category : #accessing }
CpBrowserRTCDataChannel >> id [

	"Returns an ID number (between 0 and 65,534) which uniquely identifies the RTCDataChannel."

	^ self propertyAt: #id
]

{ #category : #accessing }
CpBrowserRTCDataChannel >> label [

	"Returns a string that contains a name describing the data channel. These labels are not required to be unique."

	^ self propertyAt: #label
]

{ #category : #accessing }
CpBrowserRTCDataChannel >> maxPacketLifeTime [

	"Returns the amount of time, in milliseconds, the browser is allowed to take to attempt to transmit a message, as set when the data channel was created, or null."

	^ self propertyAt: #maxPacketLifeTime
]

{ #category : #accessing }
CpBrowserRTCDataChannel >> maxRetransmits [

	"Returns the maximum number of times the browser should try to retransmit a message before giving up, as set when the data channel was created, or null, which indicates that there is no maximum."

	^ self propertyAt: #maxRetransmits
]

{ #category : #accessing }
CpBrowserRTCDataChannel >> negotiated [

	"Indicates whether the RTCDataChannel's connection was negotiated by the Web app (true) or by the WebRTC layer (false). The default is false."

	^ self propertyAt: #negotiated
]

{ #category : #accessing }
CpBrowserRTCDataChannel >> ordered [

	"Indicates whether or not the data channel guarantees in-order delivery of messages; the default is true, which indicates that the data channel is indeed ordered."

	^ self propertyAt: #ordered
]

{ #category : #accessing }
CpBrowserRTCDataChannel >> protocol [

	"Returns a string containing the name of the subprotocol in use. If no protocol was specified when the data channel was created, then this property's value is the empty string ('')."

	^ self propertyAt: #protocol
]

{ #category : #accessing }
CpBrowserRTCDataChannel >> readyState [

	"Returns a string which indicates the state of the data channel's underlying data connection. It can have one of the following values: connecting, open, closing, or closed."

	^ self propertyAt: #readyState
]

{ #category : #operations }
CpBrowserRTCDataChannel >> send: anObject [

	"Sends data across the data channel to the remote peer.
	This may be a string, a Blob, an ArrayBuffer, a TypedArray or a DataView object."

	self apply: #send withArguments: { anObject }
]
