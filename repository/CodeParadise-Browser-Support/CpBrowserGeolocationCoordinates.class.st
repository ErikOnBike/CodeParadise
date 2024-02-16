Class {
	#name : #CpBrowserGeolocationCoordinates,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-Geolocation'
}

{ #category : #accessing }
CpBrowserGeolocationCoordinates >> accuracy [

	"Returns a double representing the accuracy of the latitude and longitude properties, expressed in meters."

	^ self propertyAt: #accuracy
]

{ #category : #accessing }
CpBrowserGeolocationCoordinates >> altitude [

	"Returns a double representing the position's altitude in meters, relative to sea level. This value can be null if the implementation cannot provide the data."
	
	^ self propertyAt: #altitude
]

{ #category : #accessing }
CpBrowserGeolocationCoordinates >> altitudeAccuracy [

	"Returns a double representing the accuracy of the altitude expressed in meters. This value can be null."
	
	^ self propertyAt: #altitudeAccuracy
]

{ #category : #accessing }
CpBrowserGeolocationCoordinates >> heading [

	"Returns a double representing the direction towards which the device is facing. This value,
	specified in degrees, indicates how far off from heading true north the device is.
	0 degrees represents true north, and the direction is determined clockwise (which means that
	east is 90 degrees and west is 270 degrees).
	If speed is 0, heading is NaN.
	If the device is unable to provide heading information, this value is null."

	^ self propertyAt: #heading
]

{ #category : #accessing }
CpBrowserGeolocationCoordinates >> latitude [

	"Returns a double representing the position's latitude in decimal degrees."

	^ self propertyAt: #latitude
]

{ #category : #accessing }
CpBrowserGeolocationCoordinates >> longitude [

	"Returns a double representing the position's longitude in decimal degrees."

	^ self propertyAt: #longitude
]

{ #category : #accessing }
CpBrowserGeolocationCoordinates >> speed [

	"Returns a double representing the velocity of the device in meters per second. This value can be null."

	^ self propertyAt: #speed
]
