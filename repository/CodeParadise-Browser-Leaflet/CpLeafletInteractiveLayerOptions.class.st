Class {
	#name : #CpLeafletInteractiveLayerOptions,
	#superclass : #CpLeafletLayerOptions,
	#category : #'CodeParadise-Browser-Leaflet-Support'
}

{ #category : #accessing }
CpLeafletInteractiveLayerOptions >> bubblingPointerEvents [

	"When true, a pointer event on this layer will trigger the same event on the map (unless DomEvent.stopPropagation is used).

	Type: Boolean
	Default: true"

	^ self at: #bubblingPointerEvents
]

{ #category : #accessing }
CpLeafletInteractiveLayerOptions >> bubblingPointerEvents: aBoolean [

	"When true, a pointer event on this layer will trigger the same event on the map (unless DomEvent.stopPropagation is used).

	Type: Boolean
	Default: true"

	self at: #bubblingPointerEvents put: aBoolean
]

{ #category : #accessing }
CpLeafletInteractiveLayerOptions >> interactive [

	"If false, the layer will not emit pointer events and will act as a part of the underlying map.

	Type: Boolean
	Default: true"

	^ self at: #interactive
]

{ #category : #accessing }
CpLeafletInteractiveLayerOptions >> interactive: aBoolean [

	"If false, the layer will not emit pointer events and will act as a part of the underlying map.

	Type: Boolean
	Default: true"

	self at: #interactive put: aBoolean
]
