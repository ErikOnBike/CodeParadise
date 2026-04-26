Class {
	#name : #CpLeafletMarker,
	#superclass : #CpLeafletObject,
	#category : #'CodeParadise-Browser-Leaflet-Core'
}

{ #category : #'instance creation' }
CpLeafletMarker class >> lat: latFloat lon: lonFloat [

	^ self newInstanceWithArguments: { { latFloat . lonFloat } }
]
