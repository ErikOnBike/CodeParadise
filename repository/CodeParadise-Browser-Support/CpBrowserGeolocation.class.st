Class {
	#name : #CpBrowserGeolocation,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-Geolocation'
}

{ #category : #'class initialization' }
CpBrowserGeolocation class >> beLoaded [

	CpBrowserGeolocationPosition beLoaded.
	CpBrowserGeolocationPositionError beLoaded.
	CpBrowserGeolocationCoordinates beLoaded
]

{ #category : #accessing }
CpBrowserGeolocation class >> current [

	"Answer an instance of the receiver"

	^ CpBrowserNavigator current
		apply: #geolocation resultAs: self
]

{ #category : #'instance creation' }
CpBrowserGeolocation class >> newInstanceWithArguments: anArray resultAs: aProxyClass [

	self error: 'An instance should be retrieved using the selector ', #current
]

{ #category : #accessing }
CpBrowserGeolocation >> getCurrentPosition: successBlock onError: errorBlock [

	^ self getCurrentPosition: successBlock  onError: errorBlock withOptions: nil
]

{ #category : #accessing }
CpBrowserGeolocation >> getCurrentPosition: successBlock onError: errorBlock withOptions: aDictionary [

	"Determines the device's current location and gives back a GeolocationPosition object with the data."

	^ self apply: #getCurrentPosition withArguments: {
		[ :position | successBlock value: position ].
		[ :error | errorBlock value: error ].
		aDictionary }
]
