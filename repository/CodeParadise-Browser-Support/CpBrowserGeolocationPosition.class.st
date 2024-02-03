Class {
	#name : #CpBrowserGeolocationPosition,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-Geolocation'
}

{ #category : #accessing }
CpBrowserGeolocationPosition >> coords [

	"Returns a GeolocationCoordinates object defining the current location."

	^ self apply: #coords resultAs: CpBrowserGeolocationCoordinates
]

{ #category : #accessing }
CpBrowserGeolocationPosition >> timestamp [

	"Returns a timestamp, given as Unix time in milliseconds, representing the time at which the location was retrieved."

	^ self apply: #timestamp
]
