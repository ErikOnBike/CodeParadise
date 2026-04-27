Class {
	#name : #CpLeafletPathOptions,
	#superclass : #CpLeafletInteractiveLayerOptions,
	#category : #'CodeParadise-Browser-Leaflet-Support'
}

{ #category : #accessing}
CpLeafletPathOptions >> stroke [

	"Whether to draw stroke along the path. Set it to false to disable borders on polygons or circles.

	Type: Boolean
	Default: true"

	^ self at: #stroke
]

{ #category : #accessing }
CpLeafletPathOptions >> stroke: aBoolean [

	"Whether to draw stroke along the path. Set it to false to disable borders on polygons or circles.

	Type: Boolean
	Default: true"

	self at: #stroke put: aBoolean
]

{ #category : #accessing}
CpLeafletPathOptions >> color [

	"Stroke color

	Type: String
	Default: '#3388ff'"

	^ self at: #color
]

{ #category : #accessing }
CpLeafletPathOptions >> color: aString [

	"Stroke color

	Type: String
	Default: '#3388ff'"

	self at: #color put: aString
]

{ #category : #accessing}
CpLeafletPathOptions >> weight [

	"Stroke width in pixels

	Type: Number
	Default: 3"

	^ self at: #weight
]

{ #category : #accessing }
CpLeafletPathOptions >> weight: aNumber [

	"Stroke width in pixels

	Type: Number
	Default: 3"

	self at: #weight put: aNumber
]

{ #category : #accessing}
CpLeafletPathOptions >> opacity [

	"Stroke opacity

	Type: Number
	Default: 1.0"

	^ self at: #opacity
]

{ #category : #accessing }
CpLeafletPathOptions >> opacity: aNumber [

	"Stroke opacity

	Type: Number
	Default: 1.0"

	self at: #opacity put: aNumber
]

{ #category : #accessing}
CpLeafletPathOptions >> lineCap [

	"A string that defines shape to be used at the end of the stroke.

	Type: String
	Default: 'round'"

	^ self at: #lineCap
]

{ #category : #accessing }
CpLeafletPathOptions >> lineCap: aString [

	"A string that defines shape to be used at the end of the stroke.

	Type: String
	Default: 'round'"

	self at: #lineCap put: aString
]

{ #category : #accessing}
CpLeafletPathOptions >> lineJoin [

	"A string that defines shape to be used at the corners of the stroke.

	Type: String
	Default: 'round'"

	^ self at: #lineJoin
]

{ #category : #accessing }
CpLeafletPathOptions >> lineJoin: aString [

	"A string that defines shape to be used at the corners of the stroke.

	Type: String
	Default: 'round'"

	self at: #lineJoin put: aString
]

{ #category : #accessing}
CpLeafletPathOptions >> dashArray [

	"A string that defines the stroke dash pattern.

	Type: String
	Default: null"

	^ self at: #dashArray
]

{ #category : #accessing }
CpLeafletPathOptions >> dashArray: aString [

	"A string that defines the stroke dash pattern.

	Type: String
	Default: null"

	self at: #dashArray put: aString
]

{ #category : #accessing}
CpLeafletPathOptions >> dashOffset [

	"A string that defines the distance into the dash pattern to start the dash.

	Type: String
	Default: null"

	^ self at: #dashOffset
]

{ #category : #accessing }
CpLeafletPathOptions >> dashOffset: aString [

	"A string that defines the distance into the dash pattern to start the dash.

	Type: String
	Default: null"

	self at: #dashOffset put: aString
]

{ #category : #accessing}
CpLeafletPathOptions >> fill [

	"Whether to fill the path with color. Set it to false to disable filling on polygons or circles.

	Type: Boolean
	Default: depends"

	^ self at: #fill
]

{ #category : #accessing }
CpLeafletPathOptions >> fill: aBoolean [

	"Whether to fill the path with color. Set it to false to disable filling on polygons or circles.

	Type: Boolean
	Default: depends"

	self at: #fill put: aBoolean
]

{ #category : #accessing}
CpLeafletPathOptions >> fillColor [

	"Fill color. Defaults to the value of the color option

	Type: String
	Default: *"

	^ self at: #fillColor
]

{ #category : #accessing }
CpLeafletPathOptions >> fillColor: aString [

	"Fill color. Defaults to the value of the color option

	Type: String
	Default: *"

	self at: #fillColor put: aString
]

{ #category : #accessing}
CpLeafletPathOptions >> fillOpacity [

	"Fill opacity.

	Type: Number
	Default: 0.2"

	^ self at: #fillOpacity
]

{ #category : #accessing }
CpLeafletPathOptions >> fillOpacity: aNumber [

	"Fill opacity.

	Type: Number
	Default: 0.2"

	self at: #fillOpacity put: aNumber
]

{ #category : #accessing}
CpLeafletPathOptions >> fillRule [

	"A string that defines how the inside of a shape is determined.

	Type: String
	Default: 'evenodd'"

	^ self at: #fillRule
]

{ #category : #accessing }
CpLeafletPathOptions >> fillRule: aString [

	"A string that defines how the inside of a shape is determined.

	Type: String
	Default: 'evenodd'"

	self at: #fillRule put: aString
]

{ #category : #accessing}
CpLeafletPathOptions >> bubblingPointerEvents [

	"When true, a pointer event on this path will trigger the same event on the map (unless DomEvent.stopPropagation is used).

	Type: Boolean
	Default: true"

	^ self at: #bubblingPointerEvents
]

{ #category : #accessing }
CpLeafletPathOptions >> bubblingPointerEvents: aBoolean [

	"When true, a pointer event on this path will trigger the same event on the map (unless DomEvent.stopPropagation is used).

	Type: Boolean
	Default: true"

	self at: #bubblingPointerEvents put: aBoolean
]

{ #category : #accessing}
CpLeafletPathOptions >> renderer [

	"Use this specific instance of Renderer for this path. Takes precedence over the map's default renderer. If set, it will override the pane option of the path.

	Type: Renderer
	Default: "

	^ self at: #renderer
]

{ #category : #accessing }
CpLeafletPathOptions >> renderer: aRenderer [

	"Use this specific instance of Renderer for this path. Takes precedence over the map's default renderer. If set, it will override the pane option of the path.

	Type: Renderer
	Default: "

	self at: #renderer put: aRenderer
]

{ #category : #accessing}
CpLeafletPathOptions >> className [

	"Custom class name set on an element. Only for SVG renderer.

	Type: String
	Default: null"

	^ self at: #className
]

{ #category : #accessing }
CpLeafletPathOptions >> className: aString [

	"Custom class name set on an element. Only for SVG renderer.

	Type: String
	Default: null"

	self at: #className put: aString
]
