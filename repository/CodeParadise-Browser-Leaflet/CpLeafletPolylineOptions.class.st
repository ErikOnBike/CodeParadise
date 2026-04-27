Class {
	#name : #CpLeafletPolylineOptions,
	#superclass : #CpLeafletPathOptions,
	#category : #'CodeParadise-Browser-Leaflet-Support'
}

{ #category : #accessing}
CpLeafletPolylineOptions >> smoothFactor [

	"How much to simplify the polyline on each zoom level. More means better performance and smoother look, and less means more accurate representation.

	Type: Number
	Default: 1.0"

	^ self at: #smoothFactor
]

{ #category : #accessing }
CpLeafletPolylineOptions >> smoothFactor: aNumber [

	"How much to simplify the polyline on each zoom level. More means better performance and smoother look, and less means more accurate representation.

	Type: Number
	Default: 1.0"

	self at: #smoothFactor put: aNumber
]

{ #category : #accessing}
CpLeafletPolylineOptions >> noClip [

	"Disable polyline clipping.

	Type: Boolean
	Default: false"

	^ self at: #noClip
]

{ #category : #accessing }
CpLeafletPolylineOptions >> noClip: aBoolean [

	"Disable polyline clipping.

	Type: Boolean
	Default: false"

	self at: #noClip put: aBoolean
]
