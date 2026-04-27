Class {
	#name : #CpLeafletMarkerOptions,
	#superclass : #CpLeafletInteractiveLayerOptions,
	#category : #'CodeParadise-Browser-Leaflet-Support'
}

{ #category : #accessing}
CpLeafletMarkerOptions >> icon [

	"Icon instance to use for rendering the marker. See Icon documentation for details on how to customize the marker icon. If not specified, a common instance of Icon.Default is used.

	Type: Icon
	Default: *"

	^ self at: #icon
]

{ #category : #accessing }
CpLeafletMarkerOptions >> icon: aIcon [

	"Icon instance to use for rendering the marker. See Icon documentation for details on how to customize the marker icon. If not specified, a common instance of Icon.Default is used.

	Type: Icon
	Default: *"

	self at: #icon put: aIcon
]

{ #category : #accessing}
CpLeafletMarkerOptions >> keyboard [

	"Whether the marker can be tabbed to with a keyboard and clicked by pressing enter.

	Type: Boolean
	Default: true"

	^ self at: #keyboard
]

{ #category : #accessing }
CpLeafletMarkerOptions >> keyboard: aBoolean [

	"Whether the marker can be tabbed to with a keyboard and clicked by pressing enter.

	Type: Boolean
	Default: true"

	self at: #keyboard put: aBoolean
]

{ #category : #accessing}
CpLeafletMarkerOptions >> title [

	"Text for the browser tooltip that appear on marker hover (no tooltip by default). Useful for accessibility.

	Type: String
	Default: ''"

	^ self at: #title
]

{ #category : #accessing }
CpLeafletMarkerOptions >> title: aString [

	"Text for the browser tooltip that appear on marker hover (no tooltip by default). Useful for accessibility.

	Type: String
	Default: ''"

	self at: #title put: aString
]

{ #category : #accessing}
CpLeafletMarkerOptions >> alt [

	"Text for the alt attribute of the icon image. Useful for accessibility.

	Type: String
	Default: 'Marker'"

	^ self at: #alt
]

{ #category : #accessing }
CpLeafletMarkerOptions >> alt: aString [

	"Text for the alt attribute of the icon image. Useful for accessibility.

	Type: String
	Default: 'Marker'"

	self at: #alt put: aString
]

{ #category : #accessing}
CpLeafletMarkerOptions >> zIndexOffset [

	"By default, marker images zIndex is set automatically based on its latitude. Use this option if you want to put the marker on top of all others (or below), specifying a high value like 1000 (or high negative value, respectively).

	Type: Number
	Default: 0"

	^ self at: #zIndexOffset
]

{ #category : #accessing }
CpLeafletMarkerOptions >> zIndexOffset: aNumber [

	"By default, marker images zIndex is set automatically based on its latitude. Use this option if you want to put the marker on top of all others (or below), specifying a high value like 1000 (or high negative value, respectively).

	Type: Number
	Default: 0"

	self at: #zIndexOffset put: aNumber
]

{ #category : #accessing}
CpLeafletMarkerOptions >> opacity [

	"The opacity of the marker.

	Type: Number
	Default: 1.0"

	^ self at: #opacity
]

{ #category : #accessing }
CpLeafletMarkerOptions >> opacity: aNumber [

	"The opacity of the marker.

	Type: Number
	Default: 1.0"

	self at: #opacity put: aNumber
]

{ #category : #accessing}
CpLeafletMarkerOptions >> riseOnHover [

	"If true, the marker will get on top of others when you hover the pointer over it.

	Type: Boolean
	Default: false"

	^ self at: #riseOnHover
]

{ #category : #accessing }
CpLeafletMarkerOptions >> riseOnHover: aBoolean [

	"If true, the marker will get on top of others when you hover the pointer over it.

	Type: Boolean
	Default: false"

	self at: #riseOnHover put: aBoolean
]

{ #category : #accessing}
CpLeafletMarkerOptions >> riseOffset [

	"The z-index offset used for the riseOnHover feature.

	Type: Number
	Default: 250"

	^ self at: #riseOffset
]

{ #category : #accessing }
CpLeafletMarkerOptions >> riseOffset: aNumber [

	"The z-index offset used for the riseOnHover feature.

	Type: Number
	Default: 250"

	self at: #riseOffset put: aNumber
]

{ #category : #accessing}
CpLeafletMarkerOptions >> pane [

	"Map pane where the markers icon will be added.

	Type: String
	Default: 'markerPane'"

	^ self at: #pane
]

{ #category : #accessing }
CpLeafletMarkerOptions >> pane: aString [

	"Map pane where the markers icon will be added.

	Type: String
	Default: 'markerPane'"

	self at: #pane put: aString
]

{ #category : #accessing}
CpLeafletMarkerOptions >> shadowPane [

	"Map pane where the markers shadow will be added.

	Type: String
	Default: 'shadowPane'"

	^ self at: #shadowPane
]

{ #category : #accessing }
CpLeafletMarkerOptions >> shadowPane: aString [

	"Map pane where the markers shadow will be added.

	Type: String
	Default: 'shadowPane'"

	self at: #shadowPane put: aString
]

{ #category : #accessing}
CpLeafletMarkerOptions >> bubblingPointerEvents [

	"When true, a pointer event on this marker will trigger the same event on the map (unless DomEvent.stopPropagation is used).

	Type: Boolean
	Default: false"

	^ self at: #bubblingPointerEvents
]

{ #category : #accessing }
CpLeafletMarkerOptions >> bubblingPointerEvents: aBoolean [

	"When true, a pointer event on this marker will trigger the same event on the map (unless DomEvent.stopPropagation is used).

	Type: Boolean
	Default: false"

	self at: #bubblingPointerEvents put: aBoolean
]

{ #category : #accessing}
CpLeafletMarkerOptions >> autoPanOnFocus [

	"When true, the map will pan whenever the marker is focused (via e.g. pressing tab on the keyboard) to ensure the marker is visible within the map's bounds

	Type: Boolean
	Default: true"

	^ self at: #autoPanOnFocus
]

{ #category : #accessing }
CpLeafletMarkerOptions >> autoPanOnFocus: aBoolean [

	"When true, the map will pan whenever the marker is focused (via e.g. pressing tab on the keyboard) to ensure the marker is visible within the map's bounds

	Type: Boolean
	Default: true"

	self at: #autoPanOnFocus put: aBoolean
]

{ #category : #accessing}
CpLeafletMarkerOptions >> draggable [

	"Whether the marker is draggable with pointer or not.

	Type: Boolean
	Default: false"

	^ self at: #draggable
]

{ #category : #accessing }
CpLeafletMarkerOptions >> draggable: aBoolean [

	"Whether the marker is draggable with pointer or not.

	Type: Boolean
	Default: false"

	self at: #draggable put: aBoolean
]

{ #category : #accessing}
CpLeafletMarkerOptions >> autoPan [

	"Whether to pan the map when dragging this marker near its edge or not.

	Type: Boolean
	Default: false"

	^ self at: #autoPan
]

{ #category : #accessing }
CpLeafletMarkerOptions >> autoPan: aBoolean [

	"Whether to pan the map when dragging this marker near its edge or not.

	Type: Boolean
	Default: false"

	self at: #autoPan put: aBoolean
]

{ #category : #accessing}
CpLeafletMarkerOptions >> autoPanPadding [

	"Distance (in pixels to the left/right and to the top/bottom) of the map edge to start panning the map.

	Type: Point
	Default: Point(50, 50)"

	^ self at: #autoPanPadding
]

{ #category : #accessing }
CpLeafletMarkerOptions >> autoPanPadding: aPoint [

	"Distance (in pixels to the left/right and to the top/bottom) of the map edge to start panning the map.

	Type: Point
	Default: Point(50, 50)"

	self at: #autoPanPadding put: aPoint
]

{ #category : #accessing}
CpLeafletMarkerOptions >> autoPanSpeed [

	"Number of pixels the map should pan by.

	Type: Number
	Default: 10"

	^ self at: #autoPanSpeed
]

{ #category : #accessing }
CpLeafletMarkerOptions >> autoPanSpeed: aNumber [

	"Number of pixels the map should pan by.

	Type: Number
	Default: 10"

	self at: #autoPanSpeed put: aNumber
]
