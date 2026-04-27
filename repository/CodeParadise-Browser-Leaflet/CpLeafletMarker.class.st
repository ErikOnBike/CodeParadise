Class {
	#name : #CpLeafletMarker,
	#superclass : #CpLeafletLayer,
	#category : #'CodeParadise-Browser-Leaflet-Core'
}

{ #category : #'instance creation' }
CpLeafletMarker class >> lat: latFloat lon: lonFloat [

	^ self latLng: { latFloat . lonFloat }
]

{ #category : #'instance creation' }
CpLeafletMarker class >> latLng: anArray [

	^ self newInstanceWithArguments: { anArray }
]

{ #category : #'instance creation' }
CpLeafletMarker class >> latLng: anArray options: aDictionary [

	^ self newInstanceWithArguments: { anArray . aDictionary asDictionary }
]

{ #category : #accessing }
CpLeafletMarker >> getLatLng [

	^ self apply: #getLatLng
]

{ #category : #accessing }
CpLeafletMarker >> setLatLng: anArray [

	self apply: #setLatLng withArguments: { anArray }
]
