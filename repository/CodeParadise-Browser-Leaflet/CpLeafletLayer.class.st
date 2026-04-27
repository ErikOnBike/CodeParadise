Class {
	#name : #CpLeafletLayer,
	#superclass : #CpLeafletObject,
	#category : #'CodeParadise-Browser-Leaflet-Core'
}

{ #category : #operations }
CpLeafletLayer >> addTo: aMap [

	self apply: #addTo withArguments: { aMap }
]

{ #category : #operations }
CpLeafletLayer >> removeFrom: aMap [

	self apply: #removeFrom withArguments: { aMap }
]
