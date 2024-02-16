Class {
	#name : #CpBrowserMediaDeviceInfo,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-MediaStreams'
}

{ #category : #accessing }
CpBrowserMediaDeviceInfo >> deviceId [

	"Returns a string that is an identifier for the represented device that is persisted across sessions. It is un-guessable by other applications and unique to the origin of the calling application. It is reset when the user clears cookies (for Private Browsing, a different identifier is used that is not persisted across sessions)."

	^ self propertyAt: #deviceId
]

{ #category : #accessing }
CpBrowserMediaDeviceInfo >> groupId [

	"Returns a string that is a group identifier. Two devices have the same group identifier if they belong to the same physical device — for example a monitor with both a built-in camera and a microphone."

	^ self propertyAt: #groupId
]

{ #category : #accessing }
CpBrowserMediaDeviceInfo >> kind [

	"Returns an enumerated value that is either 'videoinput', 'audioinput' or 'audiooutput'."

	^ self propertyAt: #kind
]

{ #category : #accessing }
CpBrowserMediaDeviceInfo >> label [

	"Returns a string describing this device (for example 'External USB Webcam')."

	^ self propertyAt: #label
]
