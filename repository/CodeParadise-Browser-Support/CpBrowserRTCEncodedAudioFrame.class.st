Class {
	#name : #CpBrowserRTCEncodedAudioFrame,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-WebRTC'
}

{ #category : #accessing }
CpBrowserRTCEncodedAudioFrame >> data [

	"Return a buffer containing the encoded frame data."

	^ self propertyAt: #data resultAs: CpJavaScriptArrayBuffer
]

{ #category : #operations }
CpBrowserRTCEncodedAudioFrame >> getMetadata [

	"Returns the metadata associated with the frame."

	^ self apply: #getMetadata
]
