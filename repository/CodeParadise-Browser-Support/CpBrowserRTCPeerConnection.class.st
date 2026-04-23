Class {
	#name : #CpBrowserRTCPeerConnection,
	#superclass : #CpBrowserEventTarget,
	#category : #'CodeParadise-Browser-Support-WebRTC'
}

{ #category : #operations }
CpBrowserRTCPeerConnection class >> generateCertificate [

	"Creates an X.509 certificate and its corresponding private key, returning a Promise that resolves with the new RTCCertificate once it is generated."

	^ self apply: #generateCertificate
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> addIceCandidate: aCandidate [

	"Adds a new remote candidate to the RTCPeerConnection's remote description, which describes the state of the remote end of the connection."

	^ self apply: #addIceCandidate withArguments: { aCandidate }
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> addTrack: aMediaStreamTrack [

	"Adds a new MediaStreamTrack to the set of tracks which will be transmitted to the other peer."

	^ self apply: #addTrack withArguments: { aMediaStreamTrack }
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> addTransceiver: aMediaTrackOrString [

	"Creates a new RTCRtpTransceiver and adds it to the set of transceivers associated with the connection. Each transceiver represents a bidirectional stream, with both an RTCRtpSender and an RTCRtpReceiver associated with it."

	^ self apply: #addTransceiver withArguments: { aMediaTrackOrString } resultAs: CpBrowserRTCRtpTransceiver
]

{ #category : #accessing }
CpBrowserRTCPeerConnection >> canTrickleIceCandidates [

	"Returns a boolean value which indicates whether or not the remote peer can accept trickled ICE candidates."
	
	^ self propertyAt: #canTrickleIceCandidates
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> close [

	"Permanently stops the RTCRtpTransceiver. The associated sender stops sending data, and the associated receiver likewise stops receiving and decoding incoming data."

	self apply: #close
]

{ #category : #accessing }
CpBrowserRTCPeerConnection >> connectionState [

	"Indicates the current state of the peer connection by returning one of the strings: new, connecting, connected, disconnected, failed, or closed."

	^ self propertyAt: #connectionState
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> createAnswer [

	"Initiates the creation of an SDP answer to an offer received from a remote peer during the offer/answer negotiation of a WebRTC connection. The answer contains information about any media already attached to the session, codecs and options supported by the browser, and any ICE candidates already gathered."

	^ self apply: #createAnswer resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> createDataChannel: aString [

	"Initiates the creation a new channel linked with the remote peer, over which any kind of data may be transmitted. This can be useful for back-channel content, such as images, file transfer, text chat, game update packets, and so forth."

	^ self createDataChannel: aString options: nil
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> createDataChannel: aString options: aDictionary [

	"Initiates the creation a new channel linked with the remote peer, over which any kind of data may be transmitted. This can be useful for back-channel content, such as images, file transfer, text chat, game update packets, and so forth."

	^ self apply: #createDataChannel withArguments: { aString . aDictionary } resultAs: CpBrowserRTCDataChannel
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> createOffer [

	"Initiates the creation of an SDP offer for the purpose of starting a new WebRTC connection to a remote peer. The SDP offer includes information about any MediaStreamTrack objects already attached to the WebRTC session, codec, and options supported by the browser, as well as any candidates already gathered by the ICE agent, for the purpose of being sent over the signaling channel to a potential peer to request a connection or to update the configuration of an existing connection."

	^ self createOfferOptions: nil
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> createOfferOptions: aDictionary [

	"Initiates the creation of an SDP offer for the purpose of starting a new WebRTC connection to a remote peer. The SDP offer includes information about any MediaStreamTrack objects already attached to the WebRTC session, codec, and options supported by the browser, as well as any candidates already gathered by the ICE agent, for the purpose of being sent over the signaling channel to a potential peer to request a connection or to update the configuration of an existing connection."

	^ self apply: #createOffer withArguments: { aDictionary } resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpBrowserRTCPeerConnection >> currentLocalDescription [

	"Returns an RTCSessionDescription object describing the local end of the connection as it was most recently successfully negotiated
	since the last time this RTCPeerConnection finished negotiating and connecting to a remote peer. Also included is a list of any ICE
	candidates that may already have been generated by the ICE agent since the offer or answer represented by the description was first
	instantiated."

	^ self propertyAt: #currentLocalDescription resultAs: CpBrowserRTCSessionDescription
]

{ #category : #accessing }
CpBrowserRTCPeerConnection >> currentRemoteDescription [

	"Returns an RTCSessionDescription object describing the remote end of the connection as it was most recently successfully negotiated
	since the last time this RTCPeerConnection finished negotiating and connecting to a remote peer. Also included is a list of any ICE
	candidates that may already have been generated by the ICE agent since the offer or answer represented by the description was first
	instantiated."

	^ self propertyAt: #currentRemoteDescription resultAs: CpBrowserRTCSessionDescription
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> getConfiguration [

	"Returns an object which indicates the current configuration of the connection."

	^ self apply: #getConfiguration
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> getIdentityAssertion [

	"Initiates the gathering of an identity assertion and returns a Promise which resolves to an identity assertion encoded as a string. This has an effect only if signalingState is not closed."

	^ self apply: #getIdentityAssertion resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> getReceivers [

	"Returns an array of RTCRtpReceiver objects, each of which represents one RTP receiver."

	^ self apply: #getReceivers
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> getSenders [

	"Returns an array of RTCRtpSender objects, each of which represents the RTP sender responsible for transmitting one track's data."

	^ self apply: #getSenders
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> getStats [

	"Returns a Promise which resolves with data providing statistics about either the overall connection or about the specified MediaStreamTrack."

	^ self apply: #getStats resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> getTransceivers [

	"Returns an array of all the RTCRtpTransceiver objects being used to send and receive data on the connection."

	^ self apply: #getTransceivers
]

{ #category : #accessing }
CpBrowserRTCPeerConnection >> iceConnectionState [

	"Returns a string which state of the ICE agent associated with this RTCPeerConnection. It can be one of the following values: new, checking, connected, completed, failed, disconnected, or closed."

	^ self propertyAt: #iceConnectionState
]

{ #category : #accessing }
CpBrowserRTCPeerConnection >> iceGatheringState [

	"Returns a string that describes connection's ICE gathering state. This lets you detect, for example, when collection of ICE candidates has finished. Possible values are: new, gathering, or complete."

	^ self propertyAt: #iceGatheringState
]

{ #category : #accessing }
CpBrowserRTCPeerConnection >> localDescription [

	"Returns an RTCSessionDescription describing the session for the local end of the connection. If it has not yet been set, returns null."

	^ self propertyAt: #localDescription resultAs: CpBrowserRTCSessionDescription
]

{ #category : #accessing }
CpBrowserRTCPeerConnection >> pendingLocalDescription [

	"Returns an RTCSessionDescription object describing a pending configuration change for the local end of the connection. This does not describe the connection as it currently stands, but as it may exist in the near future."

	^ self propertyAt: #pendingLocalDescription resultAs: CpBrowserRTCSessionDescription
]

{ #category : #accessing }
CpBrowserRTCPeerConnection >> pendingRemoteDescription [

	"Returns an RTCSessionDescription object describing a pending configuration change for the remote end of the connection. This does not describe the connection as it currently stands, but as it may exist in the near future."

	^ self propertyAt: #pendingRemoteDescription resultAs: CpBrowserRTCSessionDescription
]

{ #category : #accessing }
CpBrowserRTCPeerConnection >> remoteDescription [

	"Returns an RTCSessionDescription object describing the session, including configuration and media information, for the remote end of the connection. If this hasn't been set yet, this returns null."

	^ self propertyAt: #remoteDescription resultAs: CpBrowserRTCSessionDescription
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> removeTrack: aSender [

	"Tells the local end of the connection to stop sending media from the specified track, without actually removing the corresponding RTCRtpSender from the list of senders as reported by getSenders(). If the track is already stopped, or is not in the connection's senders list, this method has no effect."

	self apply: #removeTrack withArguments: { aSender }
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> restartIce [

	"Allows to easily request that ICE candidate gathering be redone on both ends of the connection. This simplifies the process by allowing the same method to be used by either the caller or the receiver to trigger an ICE restart."

	self apply: #restartIce
]

{ #category : #accessing }
CpBrowserRTCPeerConnection >> sctp [

	"Returns an RTCSctpTransport object describing the SCTP transport layer over which SCTP data is being sent and received. If SCTP hasn't been negotiated, this value is null."

	^ self propertyAt: #sctp resultAs: CpBrowserRTCSctpTransport
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> setConfiguration: aDictionary [

	"Sets the current configuration of the connection based on the values included in the specified object. This lets you change the ICE servers used by the connection and which transport policies to use."

	self apply: #setConfiguration withArguments: { aDictionary }
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> setIdentityProvider: aString [

	"Sets the Identity Provider (IdP) to the triplet given in parameter: its name, the protocol used to communicate with it and an username. The protocol and the username are optional."

	self apply: #setIdentityProvider withArguments: { aString }
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> setIdentityProvider: domainString protocol: protocolString [

	"Sets the Identity Provider (IdP) to the triplet given in parameter: its name, the protocol used to communicate with it and an username. The protocol and the username are optional."

	self apply: #setIdentityProvider withArguments: { domainString . protocolString }
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> setIdentityProvider: domainString protocol: protocolString username: usernameString [

	"Sets the Identity Provider (IdP) to the triplet given in parameter: its name, the protocol used to communicate with it and an username. The protocol and the username are optional."

	self apply: #setIdentityProvider withArguments: { domainString . protocolString . usernameString }
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> setLocalDescription [

	"Changes the local description associated with the connection. This description specifies the properties of the local end of the connection, including the media format. It returns a Promise which is fulfilled once the description has been changed, asynchronously."

	^ self setLocalDescription: nil
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> setLocalDescription: aDictionary [

	"Changes the local description associated with the connection. This description specifies the properties of the local end of the connection, including the media format. It returns a Promise which is fulfilled once the description has been changed, asynchronously."

	^ self apply: #setLocalDescription withArguments: { aDictionary } resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpBrowserRTCPeerConnection >> setRemoteDescription: aDictionary [

	"Sets the specified session description as the remote peer's current offer or answer. The description specifies the properties of the remote end of the connection, including the media format. It returns a Promise which is fulfilled once the description has been changed, asynchronously."

	^ self apply: #setRemoteDescription withArguments: { aDictionary } resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpBrowserRTCPeerConnection >> signalingState [

	"Returns a string describing the state of the signaling process on the local end of the connection while connecting or reconnecting to another peer. It is one of the following values: stable, have-local-offer, have-remote-offer, have-local-pranswer, have-remote-pranswer, or closed."

	^ self propertyAt: #signalingState
]
