Class {
	#name : #CpBrowserRTCEncodedVideoFrame,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-WebRTC'
}

{ #category : #accessing }
CpBrowserRTCEncodedVideoFrame >> data [

	"Return a buffer containing the encoded frame data."

	^ self propertyAt: #data resultAs: CpJavaScriptArrayBuffer
]

{ #category : #operations }
CpBrowserRTCEncodedVideoFrame >> getMetadata [

	"Returns the metadata associated with the frame."

	^ self apply: #getMetadata 
]

{ #category : #accessing }
CpBrowserRTCEncodedVideoFrame >> type [

	"Returns whether the current frame is a key frame, delta frame, or empty frame."

	^ self propertyAt: #type
]
