Class {
	#name : #CpLeafletPolyline,
	#superclass : #CpLeafletPath,
	#category : #'CodeParadise-Browser-Leaflet-Core'
}

{ #category : #'instance creation' }
CpLeafletPolyline class >> latLngs: aCollection [

	^ self newInstanceWithArguments: { aCollection }
]

{ #category : #'instance creation' }
CpLeafletPolyline class >> latLngs: aCollection options: aDictionary [

	^ self newInstanceWithArguments: { aCollection . aDictionary asDictionary }
]

{ #category : #accessing }
CpLeafletPolyline >> getLatLngs [

	^ self apply: #getLatLngs
]

{ #category : #accessing }
CpLeafletPolyline >> setLatLngs: aCollection [

	self apply: #setLatLngs withArguments: { aCollection }
]
