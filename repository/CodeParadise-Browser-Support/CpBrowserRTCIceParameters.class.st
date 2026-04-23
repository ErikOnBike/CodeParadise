Class {
	#name : #CpBrowserRTCIceParameters,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-WebRTC'
}

{ #category : #'instance creation' }
CpBrowserRTCIceParameters class >> newInstanceWithArguments: anArray resultAs: aClass [

	self error: 'This class should not be instantiated manually'
]

{ #category : #accessing }
CpBrowserRTCIceParameters >> password [

	"A string specifying the session's password string."

	^ self propertyAt: #password
]

{ #category : #accessing }
CpBrowserRTCIceParameters >> usernameFragment [

	"A string specifying the value of the ICE session's username fragment field, ufrag."

	^ self propertyAt: #usernameFragment
]
