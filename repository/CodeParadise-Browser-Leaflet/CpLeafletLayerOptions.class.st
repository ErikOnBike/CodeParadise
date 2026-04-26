Class {
	#name : #CpLeafletLayerOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-Browser-Leaflet-Support'
}

{ #category : #accessing}
CpLeafletLayerOptions >> pane [

	"By default the layer will be added to the map's overlay pane. Overriding this option will cause the layer to be placed on another pane by default.

	Type: String
	Default: 'overlayPane'"

	^ self at: #pane
]

{ #category : #accessing }
CpLeafletLayerOptions >> pane: aString [

	"By default the layer will be added to the map's overlay pane. Overriding this option will cause the layer to be placed on another pane by default.

	Type: String
	Default: 'overlayPane'"

	self at: #pane put: aString
]

{ #category : #accessing}
CpLeafletLayerOptions >> attribution [

	"String to be shown in the attribution control, e.g. ""© OpenStreetMap contributors"". It describes the layer data and is often a legal obligation towards copyright holders and tile providers.

	Type: String
	Default: null"

	^ self at: #attribution
]

{ #category : #accessing }
CpLeafletLayerOptions >> attribution: aString [

	"String to be shown in the attribution control, e.g. ""© OpenStreetMap contributors"". It describes the layer data and is often a legal obligation towards copyright holders and tile providers.

	Type: String
	Default: null"

	self at: #attribution put: aString
]
