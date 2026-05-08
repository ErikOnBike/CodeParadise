Class {
	#name : #CpLeafletGridLayer,
	#superclass : #CpLeafletLayer,
	#category : #'CodeParadise-Browser-Leaflet-Core'
}

{ #category : #accessing }
CpLeafletGridLayer class >> options: aDictionary [

	^ self newInstanceWithArguments: { aDictionary asDictionary }
]
