Class {
	#name : #CpBrowserRTCSessionDescription,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-WebRTC'
}

{ #category : #'instance creation' }
CpBrowserRTCSessionDescription class >> newInstanceWithArguments: anArray resultAs: aClass [

	self error: 'This class should not be instantiated manually'
]

{ #category : #accessing }
CpBrowserRTCSessionDescription >> sdp [

	"A string containing the SDP describing the session."

	^ self propertyAt: #sdp
]

{ #category : #operations }
CpBrowserRTCSessionDescription >> toJSON [

	"Returns a JSON description of the object. The values of both properties, type and sdp, are contained in the generated JSON."

	^ self apply: #toJSON
]

{ #category : #accessing }
CpBrowserRTCSessionDescription >> type [

	"An enum describing the session description's type."

	^ self propertyAt: #type
]
