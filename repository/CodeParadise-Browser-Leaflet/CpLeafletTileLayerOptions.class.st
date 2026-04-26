Class {
	#name : #CpLeafletTileLayerOptions,
	#superclass : #CpLeafletGridLayerOptions,
	#category : #'CodeParadise-Browser-Leaflet-Support'
}

{ #category : #accessing}
CpLeafletTileLayerOptions >> minZoom [

	"The minimum zoom level down to which this layer will be displayed (inclusive).

	Type: Number
	Default: 0"

	^ self at: #minZoom
]

{ #category : #accessing }
CpLeafletTileLayerOptions >> minZoom: aNumber [

	"The minimum zoom level down to which this layer will be displayed (inclusive).

	Type: Number
	Default: 0"

	self at: #minZoom put: aNumber
]

{ #category : #accessing}
CpLeafletTileLayerOptions >> maxZoom [

	"The maximum zoom level up to which this layer will be displayed (inclusive).

	Type: Number
	Default: 18"

	^ self at: #maxZoom
]

{ #category : #accessing }
CpLeafletTileLayerOptions >> maxZoom: aNumber [

	"The maximum zoom level up to which this layer will be displayed (inclusive).

	Type: Number
	Default: 18"

	self at: #maxZoom put: aNumber
]

{ #category : #accessing}
CpLeafletTileLayerOptions >> subdomains [

	"Subdomains of the tile service. Can be passed in the form of one string (where each letter is a subdomain name) or an array of strings.

	Type: String|String[]
	Default: 'abc'"

	^ self at: #subdomains
]

{ #category : #accessing }
CpLeafletTileLayerOptions >> subdomains: aStringOrStringCollection [

	"Subdomains of the tile service. Can be passed in the form of one string (where each letter is a subdomain name) or an array of strings.

	Type: String|String[]
	Default: 'abc'"

	self at: #subdomains put: aStringOrStringCollection
]

{ #category : #accessing}
CpLeafletTileLayerOptions >> errorTileUrl [

	"URL to the tile image to show in place of the tile that failed to load.

	Type: String
	Default: ''"

	^ self at: #errorTileUrl
]

{ #category : #accessing }
CpLeafletTileLayerOptions >> errorTileUrl: aString [

	"URL to the tile image to show in place of the tile that failed to load.

	Type: String
	Default: ''"

	self at: #errorTileUrl put: aString
]

{ #category : #accessing}
CpLeafletTileLayerOptions >> zoomOffset [

	"The zoom number used in tile URLs will be offset with this value.

	Type: Number
	Default: 0"

	^ self at: #zoomOffset
]

{ #category : #accessing }
CpLeafletTileLayerOptions >> zoomOffset: aNumber [

	"The zoom number used in tile URLs will be offset with this value.

	Type: Number
	Default: 0"

	self at: #zoomOffset put: aNumber
]

{ #category : #accessing}
CpLeafletTileLayerOptions >> tms [

	"If true, inverses Y axis numbering for tiles (turn this on for TMS services).

	Type: Boolean
	Default: false"

	^ self at: #tms
]

{ #category : #accessing }
CpLeafletTileLayerOptions >> tms: aBoolean [

	"If true, inverses Y axis numbering for tiles (turn this on for TMS services).

	Type: Boolean
	Default: false"

	self at: #tms put: aBoolean
]

{ #category : #accessing}
CpLeafletTileLayerOptions >> zoomReverse [

	"If set to true, the zoom number used in tile URLs will be reversed (maxZoom - zoom instead of zoom)

	Type: Boolean
	Default: false"

	^ self at: #zoomReverse
]

{ #category : #accessing }
CpLeafletTileLayerOptions >> zoomReverse: aBoolean [

	"If set to true, the zoom number used in tile URLs will be reversed (maxZoom - zoom instead of zoom)

	Type: Boolean
	Default: false"

	self at: #zoomReverse put: aBoolean
]

{ #category : #accessing}
CpLeafletTileLayerOptions >> detectRetina [

	"If true and user is on a retina display, it will request four tiles of half the specified size and a bigger zoom level in place of one to utilize the high resolution.

	Type: Boolean
	Default: false"

	^ self at: #detectRetina
]

{ #category : #accessing }
CpLeafletTileLayerOptions >> detectRetina: aBoolean [

	"If true and user is on a retina display, it will request four tiles of half the specified size and a bigger zoom level in place of one to utilize the high resolution.

	Type: Boolean
	Default: false"

	self at: #detectRetina put: aBoolean
]

{ #category : #accessing}
CpLeafletTileLayerOptions >> crossOrigin [

	"Whether the crossOrigin attribute will be added to the tiles. If a String is provided, all tiles will have their crossOrigin attribute set to the String provided. This is needed if you want to access tile pixel data. Refer to CORS Settings for valid String values.

	Type: Boolean|String
	Default: false"

	^ self at: #crossOrigin
]

{ #category : #accessing }
CpLeafletTileLayerOptions >> crossOrigin: aBooleanOrString [

	"Whether the crossOrigin attribute will be added to the tiles. If a String is provided, all tiles will have their crossOrigin attribute set to the String provided. This is needed if you want to access tile pixel data. Refer to CORS Settings for valid String values.

	Type: Boolean|String
	Default: false"

	self at: #crossOrigin put: aBooleanOrString
]

{ #category : #accessing}
CpLeafletTileLayerOptions >> referrerPolicy [

	"Whether the referrerPolicy attribute will be added to the tiles. If a String is provided, all tiles will have their referrerPolicy attribute set to the String provided. This may be needed if your map's rendering context has a strict default but your tile provider expects a valid referrer (e.g. to validate an API token). Refer to HTMLImageElement.referrerPolicy for valid String values.

	Type: Boolean|String
	Default: false"

	^ self at: #referrerPolicy
]

{ #category : #accessing }
CpLeafletTileLayerOptions >> referrerPolicy: aBooleanOrString [

	"Whether the referrerPolicy attribute will be added to the tiles. If a String is provided, all tiles will have their referrerPolicy attribute set to the String provided. This may be needed if your map's rendering context has a strict default but your tile provider expects a valid referrer (e.g. to validate an API token). Refer to HTMLImageElement.referrerPolicy for valid String values.

	Type: Boolean|String
	Default: false"

	self at: #referrerPolicy put: aBooleanOrString
]
