Class {
	#name : #CpLeafletMap,
	#superclass : #CpLeafletObject,
	#category : #'CodeParadise-Browser-Leaflet-Core'
}

{ #category : #'instance creation' }
CpLeafletMap class >> element: anElement [

	^ self newInstanceWithArguments: { anElement }
]

{ #category : #'instance creation' }
CpLeafletMap class >> element: anElement options: aDictionary [

	^ self newInstanceWithArguments: { anElement . aDictionary asDictionary }
]

{ #category : #'instance creation' }
CpLeafletMap class >> id: aString [

	^ self newInstanceWithArguments: { aString }
]

{ #category : #'instance creation' }
CpLeafletMap class >> id: aString options: aDictionary [

	^ self newInstanceWithArguments: { aString . aDictionary asDictionary }
]
