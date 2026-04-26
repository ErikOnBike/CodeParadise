Class {
	#name : #CpLeafletTileLayer,
	#superclass : #CpLeafletObject,
	#category : #'CodeParadise-Browser-Leaflet-Core'
}

{ #category : #'instance creation' }
CpLeafletTileLayer class >> urlTemplate: aString [

	^ self newInstanceWithArguments: { aString }
]

{ #category : #'instance creation' }
CpLeafletTileLayer class >> urlTemplate: aString options: aDictionary [

	^ self newInstanceWithArguments: { aString . aDictionary asDictionary }
]
