Class {
	#name : #CpLeafletMap,
	#superclass : #CpLeafletObject,
	#category : #'CodeParadise-Browser-Leaflet-Core'
}

{ #category : #accessing }
CpLeafletMap class >> element: anElement [

	^ self newInstanceWithArguments: { anElement }
]

{ #category : #accessing }
CpLeafletMap class >> element: anElement options: aDictionary [

	^ self newInstanceWithArguments: { anElement . aDictionary asDictionary }
]

{ #category : #accessing }
CpLeafletMap class >> id: aString [

	^ self newInstanceWithArguments: { aString }
]

{ #category : #accessing }
CpLeafletMap class >> id: aString options: aDictionary [

	^ self newInstanceWithArguments: { aString . aDictionary asDictionary }
]
