Class {
	#name : #CpLeafletMapOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-Browser-Leaflet-Support'
}

{ #category : #accessing }
CpLeafletMapOptions >> preferCanvas: aBoolean [

	"Whether Paths should be rendered on a Canvas renderer. By default, all Paths are rendered in a SVG renderer.

	Type: Boolean
	Default: false"

	self at: #preferCanvas put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> attributionControl: aBoolean [

	"Whether a attribution control is added to the map by default.

	Type: Boolean
	Default: true"

	self at: #attributionControl put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> zoomControl: aBoolean [

	"Whether a zoom control is added to the map by default.

	Type: Boolean
	Default: true"

	self at: #zoomControl put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> closePopupOnClick: aBoolean [

	"Set it to false if you don't want popups to close when user clicks the map.

	Type: Boolean
	Default: true"

	self at: #closePopupOnClick put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> boxZoom: aBoolean [

	"Whether the map can be zoomed to a rectangular area specified by dragging the pointer while pressing the shift key.

	Type: Boolean
	Default: true"

	self at: #boxZoom put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> doubleClickZoom: aBooleanOrString [

	"Whether the map can be zoomed in by double clicking on it and zoomed out by double clicking while holding shift. If passed 'center', double-click zoom will zoom to the center of the view regardless of where the pointer was.

	Type: Boolean|String
	Default: true"

	self at: #doubleClickZoom put: aBooleanOrString
]

{ #category : #accessing }
CpLeafletMapOptions >> dragging: aBoolean [

	"Whether the map is draggable with pointer or not.

	Type: Boolean
	Default: true"

	self at: #dragging put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> zoomSnap: aNumber [

	"Forces the map's zoom level to always be a multiple of this, particularly right after a fitBounds() or a pinch-zoom. By default, the zoom level snaps to the nearest integer; lower values (e.g. 0.5 or 0.1) allow for greater granularity. A value of 0 means the zoom level will not be snapped after fitBounds or a pinch-zoom.

	Type: Number
	Default: 1"

	self at: #zoomSnap put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> zoomDelta: aNumber [

	"Controls how much the map's zoom level will change after a zoomIn(), zoomOut(), pressing + or - on the keyboard, or using the zoom controls. Values smaller than 1 (e.g. 0.5) allow for greater granularity.

	Type: Number
	Default: 1"

	self at: #zoomDelta put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> trackResize: aBoolean [

	"Whether the map automatically handles browser window resize to update itself.

	Type: Boolean
	Default: true"

	self at: #trackResize put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> inertia: aBoolean [

	"If enabled, panning of the map will have an inertia effect where the map builds momentum while dragging and continues moving in the same direction for some time. Feels especially nice on touch devices. Enabled by default.

	Type: Boolean
	Default: *"

	self at: #inertia put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> inertiaDeceleration: aNumber [

	"The rate with which the inertial movement slows down, in pixels/second².

	Type: Number
	Default: 3000"

	self at: #inertiaDeceleration put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> inertiaMaxSpeed: aNumber [

	"Max speed of the inertial movement, in pixels/second.

	Type: Number
	Default: Infinity"

	self at: #inertiaMaxSpeed put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> easeLinearity: aNumber [

	"

	Type: Number
	Default: 0.2"

	self at: #easeLinearity put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> worldCopyJump: aBoolean [

	"With this option enabled, the map tracks when you pan to another ""copy"" of the world and seamlessly jumps to the original one so that all overlays like markers and vector layers are still visible.

	Type: Boolean
	Default: false"

	self at: #worldCopyJump put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> maxBoundsViscosity: aNumber [

	"If maxBounds is set, this option will control how solid the bounds are when dragging the map around. The default value of 0.0 allows the user to drag outside the bounds at normal speed, higher values will slow down map dragging outside bounds, and 1.0 makes the bounds fully solid, preventing the user from dragging outside the bounds.

	Type: Number
	Default: 0.0"

	self at: #maxBoundsViscosity put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> keyboard: aBoolean [

	"Makes the map focusable and allows users to navigate the map with keyboard arrows and +/- keys.

	Type: Boolean
	Default: true"

	self at: #keyboard put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> keyboardPanDelta: aNumber [

	"Amount of pixels to pan when pressing an arrow key.

	Type: Number
	Default: 80"

	self at: #keyboardPanDelta put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> pinchZoom: aBooleanOrString [

	"Whether the map can be zoomed by touch-dragging with two fingers. If passed 'center', it will zoom to the center of the view regardless of where the touch events (fingers) were. Enabled for touch-capable web browsers.

	Type: Boolean|String
	Default: *"

	self at: #pinchZoom put: aBooleanOrString
]

{ #category : #accessing }
CpLeafletMapOptions >> bounceAtZoomLimits: aBoolean [

	"Set it to false if you don't want the map to zoom beyond min/max zoom and then bounce back when pinch-zooming.

	Type: Boolean
	Default: true"

	self at: #bounceAtZoomLimits put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> tapHold: aBoolean [

	"Enables simulation of contextmenu event, default is true for mobile Safari.

	Type: Boolean
	Default: "

	self at: #tapHold put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> tapTolerance: aNumber [

	"The max number of pixels a user can shift his finger during touch for it to be considered a valid tap.

	Type: Number
	Default: 15"

	self at: #tapTolerance put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> scrollWheelZoom: aBooleanOrString [

	"Whether the map can be zoomed by using the mouse wheel. If passed 'center', it will zoom to the center of the view regardless of where the pointer was.

	Type: Boolean|String
	Default: true"

	self at: #scrollWheelZoom put: aBooleanOrString
]

{ #category : #accessing }
CpLeafletMapOptions >> wheelDebounceTime: aNumber [

	"Limits the rate at which a wheel can fire (in milliseconds). By default, the user can't zoom via wheel more often than once per 40 ms.

	Type: Number
	Default: 40"

	self at: #wheelDebounceTime put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> wheelPxPerZoomLevel: aNumber [

	"How many scroll pixels (as reported by DomEvent.getWheelDelta) mean a change of one full zoom level. Smaller values will make wheel-zooming faster (and vice versa).

	Type: Number
	Default: 60"

	self at: #wheelPxPerZoomLevel put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> crs: aCRS [

	"The Coordinate Reference System to use. Don't change this if you're not sure what it means.

	Type: CRS
	Default: CRS.EPSG3857"

	self at: #crs put: aCRS
]

{ #category : #accessing }
CpLeafletMapOptions >> center: aLatLng [

	"Initial geographic center of the map

	Type: LatLng
	Default: undefined"

	self at: #center put: aLatLng
]

{ #category : #accessing }
CpLeafletMapOptions >> zoom: aNumber [

	"Initial map zoom level

	Type: Number
	Default: undefined"

	self at: #zoom put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> minZoom: aNumber [

	"Minimum zoom level of the map. If not specified and at least one GridLayer or TileLayer is in the map, the lowest of their minZoom options will be used instead.

	Type: Number
	Default: *"

	self at: #minZoom put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> maxZoom: aNumber [

	"Maximum zoom level of the map. If not specified and at least one GridLayer or TileLayer is in the map, the highest of their maxZoom options will be used instead.

	Type: Number
	Default: *"

	self at: #maxZoom put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> layers: aLayerCollection [

	"Array of layers that will be added to the map initially

	Type: Layer[]
	Default: []"

	self at: #layers put: aLayerCollection
]

{ #category : #accessing }
CpLeafletMapOptions >> maxBounds: aLatLngBounds [

	"When this option is set, the map restricts the view to the given geographical bounds, bouncing the user back if the user tries to pan outside the view. To set the restriction dynamically, use setMaxBounds method.

	Type: LatLngBounds
	Default: null"

	self at: #maxBounds put: aLatLngBounds
]

{ #category : #accessing }
CpLeafletMapOptions >> renderer: aRenderer [

	"The default method for drawing vector layers on the map. SVG or Canvas by default depending on browser support.

	Type: Renderer
	Default: *"

	self at: #renderer put: aRenderer
]

{ #category : #accessing }
CpLeafletMapOptions >> zoomAnimation: aBoolean [

	"Whether the map zoom animation is enabled. By default it's enabled in all browsers that support CSS Transitions except Android.

	Type: Boolean
	Default: true"

	self at: #zoomAnimation put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> zoomAnimationThreshold: aNumber [

	"Won't animate zoom if the zoom difference exceeds this value.

	Type: Number
	Default: 4"

	self at: #zoomAnimationThreshold put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> fadeAnimation: aBoolean [

	"Whether the tile fade animation is enabled. By default it's enabled in all browsers that support CSS Transitions except Android.

	Type: Boolean
	Default: true"

	self at: #fadeAnimation put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> markerZoomAnimation: aBoolean [

	"Whether markers animate their zoom with the zoom animation, if disabled they will disappear for the length of the animation. By default it's enabled in all browsers that support CSS Transitions except Android.

	Type: Boolean
	Default: true"

	self at: #markerZoomAnimation put: aBoolean
]

{ #category : #accessing }
CpLeafletMapOptions >> transform3DLimit: aNumber [

	"Defines the maximum size of a CSS translation transform. The default value should not be changed unless a web browser positions layers in the wrong place after doing a large panBy.

	Type: Number
	Default: 2^23"

	self at: #transform3DLimit put: aNumber
]

{ #category : #accessing }
CpLeafletMapOptions >> preferCanvas [

	"Whether Paths should be rendered on a Canvas renderer. By default, all Paths are rendered in a SVG renderer.

	Type: Boolean
	Default: false"

	^ self at: #preferCanvas
]

{ #category : #accessing }
CpLeafletMapOptions >> attributionControl [

	"Whether a attribution control is added to the map by default.

	Type: Boolean
	Default: true"

	^ self at: #attributionControl
]

{ #category : #accessing }
CpLeafletMapOptions >> zoomControl [

	"Whether a zoom control is added to the map by default.

	Type: Boolean
	Default: true"

	^ self at: #zoomControl
]

{ #category : #accessing }
CpLeafletMapOptions >> closePopupOnClick [

	"Set it to false if you don't want popups to close when user clicks the map.

	Type: Boolean
	Default: true"

	^ self at: #closePopupOnClick
]

{ #category : #accessing }
CpLeafletMapOptions >> boxZoom [

	"Whether the map can be zoomed to a rectangular area specified by dragging the pointer while pressing the shift key.

	Type: Boolean
	Default: true"

	^ self at: #boxZoom
]

{ #category : #accessing }
CpLeafletMapOptions >> doubleClickZoom [

	"Whether the map can be zoomed in by double clicking on it and zoomed out by double clicking while holding shift. If passed 'center', double-click zoom will zoom to the center of the view regardless of where the pointer was.

	Type: Boolean|String
	Default: true"

	^ self at: #doubleClickZoom
]

{ #category : #accessing }
CpLeafletMapOptions >> dragging [

	"Whether the map is draggable with pointer or not.

	Type: Boolean
	Default: true"

	^ self at: #dragging
]

{ #category : #accessing }
CpLeafletMapOptions >> zoomSnap [

	"Forces the map's zoom level to always be a multiple of this, particularly right after a fitBounds() or a pinch-zoom. By default, the zoom level snaps to the nearest integer; lower values (e.g. 0.5 or 0.1) allow for greater granularity. A value of 0 means the zoom level will not be snapped after fitBounds or a pinch-zoom.

	Type: Number
	Default: 1"

	^ self at: #zoomSnap
]

{ #category : #accessing }
CpLeafletMapOptions >> zoomDelta [

	"Controls how much the map's zoom level will change after a zoomIn(), zoomOut(), pressing + or - on the keyboard, or using the zoom controls. Values smaller than 1 (e.g. 0.5) allow for greater granularity.

	Type: Number
	Default: 1"

	^ self at: #zoomDelta
]

{ #category : #accessing }
CpLeafletMapOptions >> trackResize [

	"Whether the map automatically handles browser window resize to update itself.

	Type: Boolean
	Default: true"

	^ self at: #trackResize
]

{ #category : #accessing }
CpLeafletMapOptions >> inertia [

	"If enabled, panning of the map will have an inertia effect where the map builds momentum while dragging and continues moving in the same direction for some time. Feels especially nice on touch devices. Enabled by default.

	Type: Boolean
	Default: *"

	^ self at: #inertia
]

{ #category : #accessing }
CpLeafletMapOptions >> inertiaDeceleration [

	"The rate with which the inertial movement slows down, in pixels/second².

	Type: Number
	Default: 3000"

	^ self at: #inertiaDeceleration
]

{ #category : #accessing }
CpLeafletMapOptions >> inertiaMaxSpeed [

	"Max speed of the inertial movement, in pixels/second.

	Type: Number
	Default: Infinity"

	^ self at: #inertiaMaxSpeed
]

{ #category : #accessing }
CpLeafletMapOptions >> easeLinearity [

	"

	Type: Number
	Default: 0.2"

	^ self at: #easeLinearity
]

{ #category : #accessing }
CpLeafletMapOptions >> worldCopyJump [

	"With this option enabled, the map tracks when you pan to another ""copy"" of the world and seamlessly jumps to the original one so that all overlays like markers and vector layers are still visible.

	Type: Boolean
	Default: false"

	^ self at: #worldCopyJump
]

{ #category : #accessing }
CpLeafletMapOptions >> maxBoundsViscosity [

	"If maxBounds is set, this option will control how solid the bounds are when dragging the map around. The default value of 0.0 allows the user to drag outside the bounds at normal speed, higher values will slow down map dragging outside bounds, and 1.0 makes the bounds fully solid, preventing the user from dragging outside the bounds.

	Type: Number
	Default: 0.0"

	^ self at: #maxBoundsViscosity
]

{ #category : #accessing }
CpLeafletMapOptions >> keyboard [

	"Makes the map focusable and allows users to navigate the map with keyboard arrows and +/- keys.

	Type: Boolean
	Default: true"

	^ self at: #keyboard
]

{ #category : #accessing }
CpLeafletMapOptions >> keyboardPanDelta [

	"Amount of pixels to pan when pressing an arrow key.

	Type: Number
	Default: 80"

	^ self at: #keyboardPanDelta
]

{ #category : #accessing }
CpLeafletMapOptions >> pinchZoom [

	"Whether the map can be zoomed by touch-dragging with two fingers. If passed 'center', it will zoom to the center of the view regardless of where the touch events (fingers) were. Enabled for touch-capable web browsers.

	Type: Boolean|String
	Default: *"

	^ self at: #pinchZoom
]

{ #category : #accessing }
CpLeafletMapOptions >> bounceAtZoomLimits [

	"Set it to false if you don't want the map to zoom beyond min/max zoom and then bounce back when pinch-zooming.

	Type: Boolean
	Default: true"

	^ self at: #bounceAtZoomLimits
]

{ #category : #accessing }
CpLeafletMapOptions >> tapHold [

	"Enables simulation of contextmenu event, default is true for mobile Safari.

	Type: Boolean
	Default: "

	^ self at: #tapHold
]

{ #category : #accessing }
CpLeafletMapOptions >> tapTolerance [

	"The max number of pixels a user can shift his finger during touch for it to be considered a valid tap.

	Type: Number
	Default: 15"

	^ self at: #tapTolerance
]

{ #category : #accessing }
CpLeafletMapOptions >> scrollWheelZoom [

	"Whether the map can be zoomed by using the mouse wheel. If passed 'center', it will zoom to the center of the view regardless of where the pointer was.

	Type: Boolean|String
	Default: true"

	^ self at: #scrollWheelZoom
]

{ #category : #accessing }
CpLeafletMapOptions >> wheelDebounceTime [

	"Limits the rate at which a wheel can fire (in milliseconds). By default, the user can't zoom via wheel more often than once per 40 ms.

	Type: Number
	Default: 40"

	^ self at: #wheelDebounceTime
]

{ #category : #accessing }
CpLeafletMapOptions >> wheelPxPerZoomLevel [

	"How many scroll pixels (as reported by DomEvent.getWheelDelta) mean a change of one full zoom level. Smaller values will make wheel-zooming faster (and vice versa).

	Type: Number
	Default: 60"

	^ self at: #wheelPxPerZoomLevel
]

{ #category : #accessing }
CpLeafletMapOptions >> crs [

	"The Coordinate Reference System to use. Don't change this if you're not sure what it means.

	Type: CRS
	Default: CRS.EPSG3857"

	^ self at: #crs
]

{ #category : #accessing }
CpLeafletMapOptions >> center [

	"Initial geographic center of the map

	Type: LatLng
	Default: undefined"

	^ self at: #center
]

{ #category : #accessing }
CpLeafletMapOptions >> zoom [

	"Initial map zoom level

	Type: Number
	Default: undefined"

	^ self at: #zoom
]

{ #category : #accessing }
CpLeafletMapOptions >> minZoom [

	"Minimum zoom level of the map. If not specified and at least one GridLayer or TileLayer is in the map, the lowest of their minZoom options will be used instead.

	Type: Number
	Default: *"

	^ self at: #minZoom
]

{ #category : #accessing }
CpLeafletMapOptions >> maxZoom [

	"Maximum zoom level of the map. If not specified and at least one GridLayer or TileLayer is in the map, the highest of their maxZoom options will be used instead.

	Type: Number
	Default: *"

	^ self at: #maxZoom
]

{ #category : #accessing }
CpLeafletMapOptions >> layers [

	"Array of layers that will be added to the map initially

	Type []
	Default []"

	^ self at: #layers
]

{ #category : #accessing }
CpLeafletMapOptions >> maxBounds [

	"When this option is set, the map restricts the view to the given geographical bounds, bouncing the user back if the user tries to pan outside the view. To set the restriction dynamically, use setMaxBounds method.

	Type: LatLngBounds
	Default: null"

	^ self at: #maxBounds
]

{ #category : #accessing }
CpLeafletMapOptions >> renderer [

	"The default method for drawing vector layers on the map. SVG or Canvas by default depending on browser support.

	Type: Renderer
	Default: *"

	^ self at: #renderer
]

{ #category : #accessing }
CpLeafletMapOptions >> zoomAnimation [

	"Whether the map zoom animation is enabled. By default it's enabled in all browsers that support CSS Transitions except Android.

	Type: Boolean
	Default: true"

	^ self at: #zoomAnimation
]

{ #category : #accessing }
CpLeafletMapOptions >> zoomAnimationThreshold [

	"Won't animate zoom if the zoom difference exceeds this value.

	Type: Number
	Default: 4"

	^ self at: #zoomAnimationThreshold
]

{ #category : #accessing }
CpLeafletMapOptions >> fadeAnimation [

	"Whether the tile fade animation is enabled. By default it's enabled in all browsers that support CSS Transitions except Android.

	Type: Boolean
	Default: true"

	^ self at: #fadeAnimation
]

{ #category : #accessing }
CpLeafletMapOptions >> markerZoomAnimation [

	"Whether markers animate their zoom with the zoom animation, if disabled they will disappear for the length of the animation. By default it's enabled in all browsers that support CSS Transitions except Android.

	Type: Boolean
	Default: true"

	^ self at: #markerZoomAnimation
]

{ #category : #accessing }
CpLeafletMapOptions >> transform3DLimit [

	"Defines the maximum size of a CSS translation transform. The default value should not be changed unless a web browser positions layers in the wrong place after doing a large panBy.

	Type: Number
	Default: 2^23"

	^ self at: #transform3DLimit
]
