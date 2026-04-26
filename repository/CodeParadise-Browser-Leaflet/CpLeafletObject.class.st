Class {
	#name : #CpLeafletObject,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Leaflet-Core'
}

{ #category : #accessing }
CpLeafletObject class >> getClass [

	"Answer the class representing the receiver"

	^ CpLeaflet getClassByName: (self nameWithoutPrefix withoutPrefix: #Leaflet)
]
