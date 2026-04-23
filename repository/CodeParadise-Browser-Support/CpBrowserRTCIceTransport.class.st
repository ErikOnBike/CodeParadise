Class {
	#name : #CpBrowserRTCIceTransport,
	#superclass : #CpBrowserEventTarget,
	#category : #'CodeParadise-Browser-Support-WebRTC'
}

{ #category : #'instance creation' }
CpBrowserRTCIceTransport class >> newInstanceWithArguments: anArray resultAs: aClass [

	self error: 'This class should not be instantiated manually'
]

{ #category : #accessing }
CpBrowserRTCIceTransport >> component [

	"The ICE component being used by the transport. The value is one of the strings from the RTCIceTransport enumerated type: 'RTP' or 'RTSP'."

	^ self propertyAt: #component
]

{ #category : #accessing }
CpBrowserRTCIceTransport >> gatheringState [

	"A string indicating which current gathering state of the ICE agent: 'new', 'gathering', or 'complete'."

	^ self propertyAt: #gatheringState
]

{ #category : #operations }
CpBrowserRTCIceTransport >> getLocalCandidates [

	"Returns an array of RTCIceCandidate objects, each describing one of the ICE candidates that have been gathered so far for the local device. These are the same candidates which have already been sent to the remote peer by sending an icecandidate event to the RTCPeerConnection for transmission."

	^ self apply: #getLocalCandidates
]

{ #category : #operations }
CpBrowserRTCIceTransport >> getLocalParameters [

	"Returns a RTCIceParameters object describing the ICE parameters established by a call to the RTCPeerConnection.setLocalDescription() method. Returns null if parameters have not yet been received."

	^ self apply: #getLocalParameters
]

{ #category : #operations }
CpBrowserRTCIceTransport >> getRemoteCandidates [

	"Returns an array of RTCIceCandidate objects, one for each of the remote device's ICE candidates that have been received by the local end of the RTCPeerConnection and delivered to ICE by calling addIceCandidate()."

	^ self apply: #getRemoteCandidates
]

{ #category : #operations }
CpBrowserRTCIceTransport >> getRemoteParameters [

	"Returns a RTCIceParameters object containing the ICE parameters for the remote device, as set by a call to RTCPeerConnection.setRemoteDescription(). If setRemoteDescription() hasn't been called yet, the return value is null."

	^ self apply: #getRemoteParameters
]

{ #category : #operations }
CpBrowserRTCIceTransport >> getSelectedCandidatePair [

	"Returns a RTCIceCandidatePair object that identifies the two candidates—one for each end of the connection—that have been selected so far. It's possible that a better pair will be found and selected later; if you need to keep up with this, watch for the selectedcandidatepairchange event. If no candidate pair has been selected yet, the return value is null."

	^ self apply: #getSelectedCandidatePair resultAs: CpBrowserRTCIceCandidatePair
]

{ #category : #accessing }
CpBrowserRTCIceTransport >> role [

	"Returns a string whose value is either 'controlling' or 'controlled'; this indicates whether the ICE agent is the one that makes the final decision as to the candidate pair to use or not."

	^ self propertyAt: #role
]

{ #category : #accessing }
CpBrowserRTCIceTransport >> state [

	"A string indicating what the current state of the ICE agent is. The value of state can be used to determine whether the ICE agent has made an initial connection using a viable candidate pair ('connected'), made its final selection of candidate pairs ('completed'), or in an error state ('failed'), among other states."

	^ self propertyAt: #state
]
