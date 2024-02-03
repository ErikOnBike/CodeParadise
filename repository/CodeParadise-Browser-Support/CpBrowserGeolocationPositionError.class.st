Class {
	#name : #CpBrowserGeolocationPositionError,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-Geolocation'
}

{ #category : #accessing }
CpBrowserGeolocationPositionError >> code [

	"Returns an unsigned short representing the error code. The following values are possible:

	Value	Associated constant	Description
	1	PERMISSION_DENIED	The acquisition of the geolocation information failed because the page didn't have the necessary permissions, for example because it is blocked by a Permissions Policy
	2	POSITION_UNAVAILABLE	The acquisition of the geolocation failed because at least one internal source of position returned an internal error.
	3	TIMEOUT	The time allowed to acquire the geolocation was reached before the information was obtained.
	"

	^ self apply: #code
]

{ #category : #accessing }
CpBrowserGeolocationPositionError >> message [

	"Returns a human-readable string describing the details of the error. Specifications note that this is primarily intended for debugging use and not to be shown directly in a user interface."

	^ self apply: #message
]
