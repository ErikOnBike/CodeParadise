Class {
	#name : #CpLeafletGridLayerOptions,
	#superclass : #CpLeafletLayerOptions,
	#category : #'CodeParadise-Browser-Leaflet-Support'
}

{ #category : #accessing}
CpLeafletGridLayerOptions >> tileSize [

	"Width and height of tiles in the grid. Use a number if width and height are equal, or L.point(width, height) otherwise.

	Type: Number|Point
	Default: 256"

	^ self at: #tileSize
]

{ #category : #accessing }
CpLeafletGridLayerOptions >> tileSize: aNumberOrPoint [

	"Width and height of tiles in the grid. Use a number if width and height are equal, or L.point(width, height) otherwise.

	Type: Number|Point
	Default: 256"

	self at: #tileSize put: aNumberOrPoint
]

{ #category : #accessing}
CpLeafletGridLayerOptions >> opacity [

	"Opacity of the tiles. Can be used in the createTile() function.

	Type: Number
	Default: 1.0"

	^ self at: #opacity
]

{ #category : #accessing }
CpLeafletGridLayerOptions >> opacity: aNumber [

	"Opacity of the tiles. Can be used in the createTile() function.

	Type: Number
	Default: 1.0"

	self at: #opacity put: aNumber
]

{ #category : #accessing}
CpLeafletGridLayerOptions >> updateWhenIdle [

	"Load new tiles only when panning ends. true by default on mobile browsers, in order to avoid too many requests and keep smooth navigation. false otherwise in order to display new tiles during panning, since it is easy to pan outside the keepBuffer option in desktop browsers.

	Type: Boolean
	Default: (depends)"

	^ self at: #updateWhenIdle
]

{ #category : #accessing }
CpLeafletGridLayerOptions >> updateWhenIdle: aBoolean [

	"Load new tiles only when panning ends. true by default on mobile browsers, in order to avoid too many requests and keep smooth navigation. false otherwise in order to display new tiles during panning, since it is easy to pan outside the keepBuffer option in desktop browsers.

	Type: Boolean
	Default: (depends)"

	self at: #updateWhenIdle put: aBoolean
]

{ #category : #accessing}
CpLeafletGridLayerOptions >> updateWhenZooming [

	"By default, a smooth zoom animation (during a touch zoom or a flyTo()) will update grid layers every integer zoom level. Setting this option to false will update the grid layer only when the smooth animation ends.

	Type: Boolean
	Default: true"

	^ self at: #updateWhenZooming
]

{ #category : #accessing }
CpLeafletGridLayerOptions >> updateWhenZooming: aBoolean [

	"By default, a smooth zoom animation (during a touch zoom or a flyTo()) will update grid layers every integer zoom level. Setting this option to false will update the grid layer only when the smooth animation ends.

	Type: Boolean
	Default: true"

	self at: #updateWhenZooming put: aBoolean
]

{ #category : #accessing}
CpLeafletGridLayerOptions >> updateInterval [

	"Tiles will not update more than once every updateInterval milliseconds when panning.

	Type: Number
	Default: 200"

	^ self at: #updateInterval
]

{ #category : #accessing }
CpLeafletGridLayerOptions >> updateInterval: aNumber [

	"Tiles will not update more than once every updateInterval milliseconds when panning.

	Type: Number
	Default: 200"

	self at: #updateInterval put: aNumber
]

{ #category : #accessing}
CpLeafletGridLayerOptions >> zIndex [

	"The explicit zIndex of the tile layer.

	Type: Number
	Default: 1"

	^ self at: #zIndex
]

{ #category : #accessing }
CpLeafletGridLayerOptions >> zIndex: aNumber [

	"The explicit zIndex of the tile layer.

	Type: Number
	Default: 1"

	self at: #zIndex put: aNumber
]

{ #category : #accessing}
CpLeafletGridLayerOptions >> bounds [

	"If set, tiles will only be loaded inside the set LatLngBounds.

	Type: LatLngBounds
	Default: undefined"

	^ self at: #bounds
]

{ #category : #accessing }
CpLeafletGridLayerOptions >> bounds: aLatLngBounds [

	"If set, tiles will only be loaded inside the set LatLngBounds.

	Type: LatLngBounds
	Default: undefined"

	self at: #bounds put: aLatLngBounds
]

{ #category : #accessing}
CpLeafletGridLayerOptions >> minZoom [

	"The minimum zoom level down to which this layer will be displayed (inclusive).

	Type: Number
	Default: 0"

	^ self at: #minZoom
]

{ #category : #accessing }
CpLeafletGridLayerOptions >> minZoom: aNumber [

	"The minimum zoom level down to which this layer will be displayed (inclusive).

	Type: Number
	Default: 0"

	self at: #minZoom put: aNumber
]

{ #category : #accessing}
CpLeafletGridLayerOptions >> maxZoom [

	"The maximum zoom level up to which this layer will be displayed (inclusive).

	Type: Number
	Default: undefined"

	^ self at: #maxZoom
]

{ #category : #accessing }
CpLeafletGridLayerOptions >> maxZoom: aNumber [

	"The maximum zoom level up to which this layer will be displayed (inclusive).

	Type: Number
	Default: undefined"

	self at: #maxZoom put: aNumber
]

{ #category : #accessing}
CpLeafletGridLayerOptions >> maxNativeZoom [

	"Maximum zoom number the tile source has available. If it is specified, the tiles on all zoom levels higher than maxNativeZoom will be loaded from maxNativeZoom level and auto-scaled.

	Type: Number
	Default: undefined"

	^ self at: #maxNativeZoom
]

{ #category : #accessing }
CpLeafletGridLayerOptions >> maxNativeZoom: aNumber [

	"Maximum zoom number the tile source has available. If it is specified, the tiles on all zoom levels higher than maxNativeZoom will be loaded from maxNativeZoom level and auto-scaled.

	Type: Number
	Default: undefined"

	self at: #maxNativeZoom put: aNumber
]

{ #category : #accessing}
CpLeafletGridLayerOptions >> minNativeZoom [

	"Minimum zoom number the tile source has available. If it is specified, the tiles on all zoom levels lower than minNativeZoom will be loaded from minNativeZoom level and auto-scaled.

	Type: Number
	Default: undefined"

	^ self at: #minNativeZoom
]

{ #category : #accessing }
CpLeafletGridLayerOptions >> minNativeZoom: aNumber [

	"Minimum zoom number the tile source has available. If it is specified, the tiles on all zoom levels lower than minNativeZoom will be loaded from minNativeZoom level and auto-scaled.

	Type: Number
	Default: undefined"

	self at: #minNativeZoom put: aNumber
]

{ #category : #accessing}
CpLeafletGridLayerOptions >> noWrap [

	"Whether the layer is wrapped around the antimeridian. If true, the GridLayer will only be displayed once at low zoom levels. Has no effect when the map CRS doesn't wrap around. Can be used in combination with bounds to prevent requesting tiles outside the CRS limits.

	Type: Boolean
	Default: false"

	^ self at: #noWrap
]

{ #category : #accessing }
CpLeafletGridLayerOptions >> noWrap: aBoolean [

	"Whether the layer is wrapped around the antimeridian. If true, the GridLayer will only be displayed once at low zoom levels. Has no effect when the map CRS doesn't wrap around. Can be used in combination with bounds to prevent requesting tiles outside the CRS limits.

	Type: Boolean
	Default: false"

	self at: #noWrap put: aBoolean
]

{ #category : #accessing}
CpLeafletGridLayerOptions >> pane [

	"Map pane where the grid layer will be added.

	Type: String
	Default: 'tilePane'"

	^ self at: #pane
]

{ #category : #accessing }
CpLeafletGridLayerOptions >> pane: aString [

	"Map pane where the grid layer will be added.

	Type: String
	Default: 'tilePane'"

	self at: #pane put: aString
]

{ #category : #accessing}
CpLeafletGridLayerOptions >> className [

	"A custom class name to assign to the tile layer. Empty by default.

	Type: String
	Default: ''"

	^ self at: #className
]

{ #category : #accessing }
CpLeafletGridLayerOptions >> className: aString [

	"A custom class name to assign to the tile layer. Empty by default.

	Type: String
	Default: ''"

	self at: #className put: aString
]

{ #category : #accessing}
CpLeafletGridLayerOptions >> keepBuffer [

	"When panning the map, keep this many rows and columns of tiles before unloading them.

	Type: Number
	Default: 2"

	^ self at: #keepBuffer
]

{ #category : #accessing }
CpLeafletGridLayerOptions >> keepBuffer: aNumber [

	"When panning the map, keep this many rows and columns of tiles before unloading them.

	Type: Number
	Default: 2"

	self at: #keepBuffer put: aNumber
]
