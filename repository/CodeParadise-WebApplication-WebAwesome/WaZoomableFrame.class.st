Class {
	#name : #WaZoomableFrame,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaZoomableFrame >> allowfullscreen [

	"Allows fullscreen mode.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #allowfullscreen
]

{ #category : #accessing }
WaZoomableFrame >> allowfullscreen: aBoolean [

	"Allows fullscreen mode.
	
	Type: Boolean
	Default: false"

	self propertyAt: #allowfullscreen put: aBoolean
]

{ #category : #'accessing - convenience' }
WaZoomableFrame >> beAllowfullscreen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self allowfullscreen: true
]

{ #category : #'accessing - convenience' }
WaZoomableFrame >> beNotAllowfullscreen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self allowfullscreen: false
]

{ #category : #'accessing - convenience' }
WaZoomableFrame >> beWithControls [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutControls: false
]

{ #category : #'accessing - convenience' }
WaZoomableFrame >> beWithInteraction [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutInteraction: false
]

{ #category : #'accessing - convenience' }
WaZoomableFrame >> beWithThemeSync [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withThemeSync: true
]

{ #category : #'accessing - convenience' }
WaZoomableFrame >> beWithoutControls [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutControls: true
]

{ #category : #'accessing - convenience' }
WaZoomableFrame >> beWithoutInteraction [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutInteraction: true
]

{ #category : #'accessing - convenience' }
WaZoomableFrame >> beWithoutThemeSync [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withThemeSync: false
]

{ #category : #accessing }
WaZoomableFrame >> contentDocument [

	"Returns the internal iframe's `document` object. (Readonly property)
	
	Type: Object (Document | null)
	Read-only: true"

	^ self propertyAt: #contentDocument
]

{ #category : #accessing }
WaZoomableFrame >> contentWindow [

	"Returns the internal iframe's `window` object. (Readonly property)
	
	Type: Object (Window | null)
	Read-only: true"

	^ self propertyAt: #contentWindow
]

{ #category : #accessing }
WaZoomableFrame >> loading [

	"Controls iframe loading behavior.
	
	Type: String
	Default: 'eager'
	Allowed: 'eager' | 'lazy'"

	^ self propertyAt: #loading
]

{ #category : #accessing }
WaZoomableFrame >> loading: aString [

	"Controls iframe loading behavior.
	
	Type: String
	Default: 'eager'
	Allowed: 'eager' | 'lazy'"

	self propertyAt: #loading put: aString
]

{ #category : #accessing }
WaZoomableFrame >> referrerpolicy [

	"Controls referrer information.
	
	Type: String"

	^ self propertyAt: #referrerpolicy
]

{ #category : #accessing }
WaZoomableFrame >> referrerpolicy: aString [

	"Controls referrer information.
	
	Type: String"

	self propertyAt: #referrerpolicy put: aString
]

{ #category : #accessing }
WaZoomableFrame >> sandbox [

	"Security restrictions for the iframe.
	
	Type: String"

	^ self propertyAt: #sandbox
]

{ #category : #accessing }
WaZoomableFrame >> sandbox: aString [

	"Security restrictions for the iframe.
	
	Type: String"

	self propertyAt: #sandbox put: aString
]

{ #category : #accessing }
WaZoomableFrame >> src [

	"The URL of the content to display.
	
	Type: String"

	^ self propertyAt: #src
]

{ #category : #accessing }
WaZoomableFrame >> src: aString [

	"The URL of the content to display.
	
	Type: String"

	self propertyAt: #src put: aString
]

{ #category : #accessing }
WaZoomableFrame >> srcdoc [

	"Inline HTML to display.
	
	Type: String"

	^ self propertyAt: #srcdoc
]

{ #category : #accessing }
WaZoomableFrame >> srcdoc: aString [

	"Inline HTML to display.
	
	Type: String"

	self propertyAt: #srcdoc put: aString
]

{ #category : #accessing }
WaZoomableFrame >> withThemeSync [

	"Enables automatic theme syncing (light/dark mode and theme selector classes) from the host document to the iframe.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withThemeSync
]

{ #category : #accessing }
WaZoomableFrame >> withThemeSync: aBoolean [

	"Enables automatic theme syncing (light/dark mode and theme selector classes) from the host document to the iframe.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withThemeSync put: aBoolean
]

{ #category : #accessing }
WaZoomableFrame >> withoutControls [

	"Removes the zoom controls.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withoutControls
]

{ #category : #accessing }
WaZoomableFrame >> withoutControls: aBoolean [

	"Removes the zoom controls.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withoutControls put: aBoolean
]

{ #category : #accessing }
WaZoomableFrame >> withoutInteraction [

	"Disables interaction when present.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withoutInteraction
]

{ #category : #accessing }
WaZoomableFrame >> withoutInteraction: aBoolean [

	"Disables interaction when present.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withoutInteraction put: aBoolean
]

{ #category : #accessing }
WaZoomableFrame >> zoom [

	"The current zoom of the frame, e.g. 0 = 0% and 1 = 100%.
	
	Type: Number
	Default: 1"

	^ self propertyAt: #zoom
]

{ #category : #accessing }
WaZoomableFrame >> zoom: aNumber [

	"The current zoom of the frame, e.g. 0 = 0% and 1 = 100%.
	
	Type: Number
	Default: 1"

	self propertyAt: #zoom put: aNumber
]

{ #category : #actions }
WaZoomableFrame >> zoomIn [

	"Zooms in to the next available zoom level."

	^ self apply: #zoomIn
]

{ #category : #'accessing - slots' }
WaZoomableFrame >> zoomInIconElement [

	"The slot that contains the zoom in icon."

	^ self firstChildAtSlotNamed: #'zoom-in-icon'
]

{ #category : #'accessing - slots' }
WaZoomableFrame >> zoomInIconElement: anElement [

	"The slot that contains the zoom in icon."

	self replaceAllChildrenWith: anElement atSlotNamed: #'zoom-in-icon'
]

{ #category : #accessing }
WaZoomableFrame >> zoomLevels [

	"The zoom levels to step through when using zoom controls. This does not restrict programmatic changes to the zoom.
	
	Type: String
	Default: '25% 50% 75% 100% 125% 150% 175% 200%'"

	^ self propertyAt: #zoomLevels
]

{ #category : #accessing }
WaZoomableFrame >> zoomLevels: aString [

	"The zoom levels to step through when using zoom controls. This does not restrict programmatic changes to the zoom.
	
	Type: String
	Default: '25% 50% 75% 100% 125% 150% 175% 200%'"

	self propertyAt: #zoomLevels put: aString
]

{ #category : #actions }
WaZoomableFrame >> zoomOut [

	"Zooms out to the previous available zoom level."

	^ self apply: #zoomOut
]

{ #category : #'accessing - slots' }
WaZoomableFrame >> zoomOutIconElement [

	"The slot that contains the zoom out icon."

	^ self firstChildAtSlotNamed: #'zoom-out-icon'
]

{ #category : #'accessing - slots' }
WaZoomableFrame >> zoomOutIconElement: anElement [

	"The slot that contains the zoom out icon."

	self replaceAllChildrenWith: anElement atSlotNamed: #'zoom-out-icon'
]
