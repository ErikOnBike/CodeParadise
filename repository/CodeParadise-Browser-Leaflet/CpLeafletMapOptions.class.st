Class {
	#name : #CpLeafletMapOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-Browser-Leaflet-Support'
}

{ #category : #accessing }
CpLeafletMapOptions >> attributionControl: aBoolean [

	"Whether a attribution control is added to the map by default.

	Type: Boolean
	Default: true"

	self propertyAt: #attributionControl put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> bounceAtZoomLimits: aBoolean [

	"Set it to false if you don't want the map to zoom beyond min/max zoom and then bounce back when pinch-zooming.

	Type: Boolean
	Default: true"

	self propertyAt: #bounceAtZoomLimits put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> boxZoom: aBoolean [

	"Whether the map can be zoomed to a rectangular area specified by dragging the pointer while pressing the shift key.

	Type: Boolean
	Default: true"

	self propertyAt: #boxZoom put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> center: aLatLng [

	"Initial geographic center of the map

	Type: LatLng
	Default: undefined"

	self propertyAt: #center put: aLatLng
]

{ #category : #accessing }
CpLeafletMapOptions >> closePopupOnClick: aBoolean [

	"Set it to false if you don't want popups to close when user clicks the map.

	Type: Boolean
	Default: true"

	self propertyAt: #closePopupOnClick put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> crs: aCRS [

	"The Coordinate Reference System to use. Don't change this if you're not sure what it means.

	Type: CRS
	Default: CRS.EPSG3857"

	self propertyAt: #crs put: aCRS
]

{ #category : #accessing }
CpLeafletMapOptions >> doubleClickZoom: aBooleanOrString [

	"Whether the map can be zoomed in by double clicking on it and zoomed out by double clicking while holding shift. If passed 'center', double-click zoom will zoom to the center of the view regardless of where the pointer was.

	Type: Boolean|String
	Default: true"

	self propertyAt: #doubleClickZoom put: aBooleanOrString
]

{ #category : #accessing }
CpLeafletMapOptions >> dragging: aBoolean [

	"Whether the map is draggable with pointer or not.

	Type: Boolean
	Default: true"

	self propertyAt: #dragging put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> easeLinearity: aNumber [

	"

	Type: Number
	Default: 0.2"

	self propertyAt: #easeLinearity put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> fadeAnimation: aBoolean [

	"Whether the tile fade animation is enabled. By default it's enabled in all browsers that support CSS Transitions except Android.

	Type: Boolean
	Default: true"

	self propertyAt: #fadeAnimation put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> inertia: aBoolean [

	"If enabled, panning of the map will have an inertia effect where the map builds momentum while dragging and continues moving in the same direction for some time. Feels especially nice on touch devices. Enabled by default.

	Type: Boolean
	Default: *"

	self propertyAt: #inertia put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> inertiaDeceleration: aNumber [

	"The rate with which the inertial movement slows down, in pixels/second².

	Type: Number
	Default: 3000"

	self propertyAt: #inertiaDeceleration put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> inertiaMaxSpeed: aNumber [

	"Max speed of the inertial movement, in pixels/second.

	Type: Number
	Default: Infinity"

	self propertyAt: #inertiaMaxSpeed put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> keyboard: aBoolean [

	"Makes the map focusable and allows users to navigate the map with keyboard arrows and +/- keys.

	Type: Boolean
	Default: true"

	self propertyAt: #keyboard put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> keyboardPanDelta: aNumber [

	"Amount of pixels to pan when pressing an arrow key.

	Type: Number
	Default: 80"

	self propertyAt: #keyboardPanDelta put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> layers: aLayerCollection [

	"Array of layers that will be added to the map initially

	Type: Layer[]
	Default: []"

	self propertyAt: #layers put: aLayerCollection
]

{ #category : #accessing }
CpLeafletMapOptions >> markerZoomAnimation: aBoolean [

	"Whether markers animate their zoom with the zoom animation, if disabled they will disappear for the length of the animation. By default it's enabled in all browsers that support CSS Transitions except Android.

	Type: Boolean
	Default: true"

	self propertyAt: #markerZoomAnimation put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> maxBounds: aLatLngBounds [

	"When this option is set, the map restricts the view to the given geographical bounds, bouncing the user back if the user tries to pan outside the view. To set the restriction dynamically, use setMaxBounds method.

	Type: LatLngBounds
	Default: null"

	self propertyAt: #maxBounds put: aLatLngBounds
]

{ #category : #accessing }
CpLeafletMapOptions >> maxBoundsViscosity: aNumber [

	"If maxBounds is set, this option will control how solid the bounds are when dragging the map around. The default value of 0.0 allows the user to drag outside the bounds at normal speed, higher values will slow down map dragging outside bounds, and 1.0 makes the bounds fully solid, preventing the user from dragging outside the bounds.

	Type: Number
	Default: 0.0"

	self propertyAt: #maxBoundsViscosity put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> maxZoom: aNumber [

	"Maximum zoom level of the map. If not specified and at least one GridLayer or TileLayer is in the map, the highest of their maxZoom options will be used instead.

	Type: Number
	Default: *"

	self propertyAt: #maxZoom put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> minZoom: aNumber [

	"Minimum zoom level of the map. If not specified and at least one GridLayer or TileLayer is in the map, the lowest of their minZoom options will be used instead.

	Type: Number
	Default: *"

	self propertyAt: #minZoom put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> pinchZoom: aBooleanOrString [

	"Whether the map can be zoomed by touch-dragging with two fingers. If passed 'center', it will zoom to the center of the view regardless of where the touch events (fingers) were. Enabled for touch-capable web browsers.

	Type: Boolean|String
	Default: *"

	self propertyAt: #pinchZoom put: aBooleanOrString
]

{ #category : #accessing }
CpLeafletMapOptions >> preferCanvas: aBoolean [

	"Whether Paths should be rendered on a Canvas renderer. By default, all Paths are rendered in a SVG renderer.

	Type: Boolean
	Default: false"

	self propertyAt: #preferCanvas put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> renderer: aRenderer [

	"The default method for drawing vector layers on the map. SVG or Canvas by default depending on browser support.

	Type: Renderer
	Default: *"

	self propertyAt: #renderer put: aRenderer
]

{ #category : #accessing }
CpLeafletMapOptions >> scrollWheelZoom: aBooleanOrString [

	"Whether the map can be zoomed by using the mouse wheel. If passed 'center', it will zoom to the center of the view regardless of where the pointer was.

	Type: Boolean|String
	Default: true"

	self propertyAt: #scrollWheelZoom put: aBooleanOrString
]

{ #category : #accessing }
CpLeafletMapOptions >> tapHold: aBoolean [

	"Enables simulation of contextmenu event, default is true for mobile Safari.

	Type: Boolean
	Default: "

	self propertyAt: #tapHold put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> tapTolerance: aNumber [

	"The max number of pixels a user can shift his finger during touch for it to be considered a valid tap.

	Type: Number
	Default: 15"

	self propertyAt: #tapTolerance put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> trackResize: aBoolean [

	"Whether the map automatically handles browser window resize to update itself.

	Type: Boolean
	Default: true"

	self propertyAt: #trackResize put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> transform3DLimit: aNumber [

	"Defines the maximum size of a CSS translation transform. The default value should not be changed unless a web browser positions layers in the wrong place after doing a large panBy.

	Type: Number
	Default: 2^23"

	self propertyAt: #transform3DLimit put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> wheelDebounceTime: aNumber [

	"Limits the rate at which a wheel can fire (in milliseconds). By default, the user can't zoom via wheel more often than once per 40 ms.

	Type: Number
	Default: 40"

	self propertyAt: #wheelDebounceTime put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> wheelPxPerZoomLevel: aNumber [

	"How many scroll pixels (as reported by DomEvent.getWheelDelta) mean a change of one full zoom level. Smaller values will make wheel-zooming faster (and vice versa).

	Type: Number
	Default: 60"

	self propertyAt: #wheelPxPerZoomLevel put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> worldCopyJump: aBoolean [

	"With this option enabled, the map tracks when you pan to another ""copy"" of the world and seamlessly jumps to the original one so that all overlays like markers and vector layers are still visible.

	Type: Boolean
	Default: false"

	self propertyAt: #worldCopyJump put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> zoom: aNumber [

	"Initial map zoom level

	Type: Number
	Default: undefined"

	self propertyAt: #zoom put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> zoomAnimation: aBoolean [

	"Whether the map zoom animation is enabled. By default it's enabled in all browsers that support CSS Transitions except Android.

	Type: Boolean
	Default: true"

	self propertyAt: #zoomAnimation put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> zoomAnimationThreshold: aNumber [

	"Won't animate zoom if the zoom difference exceeds this value.

	Type: Number
	Default: 4"

	self propertyAt: #zoomAnimationThreshold put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> zoomControl: aBoolean [

	"Whether a zoom control is added to the map by default.

	Type: Boolean
	Default: true"

	self propertyAt: #zoomControl put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> zoomDelta: aNumber [

	"Controls how much the map's zoom level will change after a zoomIn(), zoomOut(), pressing + or - on the keyboard, or using the zoom controls. Values smaller than 1 (e.g. 0.5) allow for greater granularity.

	Type: Number
	Default: 1"

	self propertyAt: #zoomDelta put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> zoomSnap: aNumber [

	"Forces the map's zoom level to always be a multiple of this, particularly right after a fitBounds() or a pinch-zoom. By default, the zoom level snaps to the nearest integer; lower values (e.g. 0.5 or 0.1) allow for greater granularity. A value of 0 means the zoom level will not be snapped after fitBounds or a pinch-zoom.

	Type: Number
	Default: 1"

	self propertyAt: #zoomSnap put: aNumber
]
