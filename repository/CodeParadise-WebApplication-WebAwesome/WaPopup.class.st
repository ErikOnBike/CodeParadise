Class {
	#name : #WaPopup,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaPopup >> active [

	"Activates the positioning logic and shows the popup. When this attribute is removed, the positioning logic is torn
	down and the popup will be hidden.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #active
]

{ #category : #accessing }
WaPopup >> active: aBoolean [

	"Activates the positioning logic and shows the popup. When this attribute is removed, the positioning logic is torn
	down and the popup will be hidden.
	
	Type: Boolean
	Default: false"

	self propertyAt: #active put: aBoolean
]

{ #category : #accessing }
WaPopup >> anchor [

	"The element the popup will be anchored to. If the anchor lives outside of the popup, you can provide the anchor
	element `id`, a DOM element reference, or a `VirtualElement`. If the anchor lives inside the popup, use the
	`anchor` slot instead.
	
	Type: HtmlElementOrString (Element | string | VirtualElement)"

	^ self propertyAt: #anchor
]

{ #category : #accessing }
WaPopup >> anchor: anHtmlElementOrString [

	"The element the popup will be anchored to. If the anchor lives outside of the popup, you can provide the anchor
	element `id`, a DOM element reference, or a `VirtualElement`. If the anchor lives inside the popup, use the
	`anchor` slot instead.
	
	Type: HtmlElementOrString (Element | string | VirtualElement)"

	self propertyAt: #anchor put: anHtmlElementOrString
]

{ #category : #accessing }
WaPopup >> arrow [

	"Attaches an arrow to the popup. The arrow's size and color can be customized using the `--arrow-size` and
	`--arrow-color` custom properties. For additional customizations, you can also target the arrow using
	`::part(arrow)` in your stylesheet.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #arrow
]

{ #category : #accessing }
WaPopup >> arrow: aBoolean [

	"Attaches an arrow to the popup. The arrow's size and color can be customized using the `--arrow-size` and
	`--arrow-color` custom properties. For additional customizations, you can also target the arrow using
	`::part(arrow)` in your stylesheet.
	
	Type: Boolean
	Default: false"

	self propertyAt: #arrow put: aBoolean
]

{ #category : #accessing }
WaPopup >> arrowPadding [

	"The amount of padding between the arrow and the edges of the popup. If the popup has a border-radius, for example,
	this will prevent it from overflowing the corners.
	
	Type: Number
	Default: 10"

	^ self propertyAt: #arrowPadding
]

{ #category : #accessing }
WaPopup >> arrowPadding: aNumber [

	"The amount of padding between the arrow and the edges of the popup. If the popup has a border-radius, for example,
	this will prevent it from overflowing the corners.
	
	Type: Number
	Default: 10"

	self propertyAt: #arrowPadding put: aNumber
]

{ #category : #accessing }
WaPopup >> arrowPlacement [

	"The placement of the arrow. The default is `anchor`, which will align the arrow as close to the center of the
	anchor as possible, considering available space and `arrow-padding`. A value of `start`, `end`, or `center` will
	align the arrow to the start, end, or center of the popover instead.
	
	Type: String
	Default: 'anchor'
	Allowed: 'start' | 'end' | 'center' | 'anchor'"

	^ self propertyAt: #arrowPlacement
]

{ #category : #accessing }
WaPopup >> arrowPlacement: aString [

	"The placement of the arrow. The default is `anchor`, which will align the arrow as close to the center of the
	anchor as possible, considering available space and `arrow-padding`. A value of `start`, `end`, or `center` will
	align the arrow to the start, end, or center of the popover instead.
	
	Type: String
	Default: 'anchor'
	Allowed: 'start' | 'end' | 'center' | 'anchor'"

	self propertyAt: #arrowPlacement put: aString
]

{ #category : #accessing }
WaPopup >> autoSize [

	"When set, this will cause the popup to automatically resize itself to prevent it from overflowing.
	
	Type: String
	Allowed: 'horizontal' | 'vertical' | 'both'"

	^ self propertyAt: #autoSize
]

{ #category : #accessing }
WaPopup >> autoSize: aString [

	"When set, this will cause the popup to automatically resize itself to prevent it from overflowing.
	
	Type: String
	Allowed: 'horizontal' | 'vertical' | 'both'"

	self propertyAt: #autoSize put: aString
]

{ #category : #accessing }
WaPopup >> autoSizeBoundary [

	"The auto-size boundary describes clipping element(s) that overflow will be checked relative to when resizing. By
	default, the boundary includes overflow ancestors that will cause the element to be clipped. If needed, you can
	change the boundary by passing a reference to one or more elements to this property.
	
	Type: HtmlElement (Element | Element[])"

	^ self propertyAt: #autoSizeBoundary
]

{ #category : #accessing }
WaPopup >> autoSizeBoundary: anHtmlElement [

	"The auto-size boundary describes clipping element(s) that overflow will be checked relative to when resizing. By
	default, the boundary includes overflow ancestors that will cause the element to be clipped. If needed, you can
	change the boundary by passing a reference to one or more elements to this property.
	
	Type: HtmlElement (Element | Element[])"

	self propertyAt: #autoSizeBoundary put: anHtmlElement
]

{ #category : #accessing }
WaPopup >> autoSizePadding [

	"The amount of padding, in pixels, to exceed before the auto-size behavior will occur.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #autoSizePadding
]

{ #category : #accessing }
WaPopup >> autoSizePadding: aNumber [

	"The amount of padding, in pixels, to exceed before the auto-size behavior will occur.
	
	Type: Number
	Default: 0"

	self propertyAt: #autoSizePadding put: aNumber
]

{ #category : #'accessing - convenience' }
WaPopup >> beActive [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self active: true
]

{ #category : #'accessing - convenience' }
WaPopup >> beArrow [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self arrow: true
]

{ #category : #'accessing - convenience' }
WaPopup >> beFlip [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self flip: true
]

{ #category : #'accessing - convenience' }
WaPopup >> beHoverBridge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self hoverBridge: true
]

{ #category : #'accessing - convenience' }
WaPopup >> beNotActive [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self active: false
]

{ #category : #'accessing - convenience' }
WaPopup >> beNotArrow [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self arrow: false
]

{ #category : #'accessing - convenience' }
WaPopup >> beNotFlip [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self flip: false
]

{ #category : #'accessing - convenience' }
WaPopup >> beNotHoverBridge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self hoverBridge: false
]

{ #category : #'accessing - convenience' }
WaPopup >> beNotShift [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self shift: false
]

{ #category : #'accessing - convenience' }
WaPopup >> beShift [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self shift: true
]

{ #category : #accessing }
WaPopup >> boundary [

	"The bounding box to use for flipping, shifting, and auto-sizing.
	
	Type: String
	Default: 'viewport'
	Allowed: 'viewport' | 'scroll'"

	^ self propertyAt: #boundary
]

{ #category : #accessing }
WaPopup >> boundary: aString [

	"The bounding box to use for flipping, shifting, and auto-sizing.
	
	Type: String
	Default: 'viewport'
	Allowed: 'viewport' | 'scroll'"

	self propertyAt: #boundary put: aString
]

{ #category : #accessing }
WaPopup >> distance [

	"The distance in pixels from which to offset the panel away from its anchor.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #distance
]

{ #category : #accessing }
WaPopup >> distance: aNumber [

	"The distance in pixels from which to offset the panel away from its anchor.
	
	Type: Number
	Default: 0"

	self propertyAt: #distance put: aNumber
]

{ #category : #accessing }
WaPopup >> flip [

	"When set, placement of the popup will flip to the opposite site to keep it in view. You can use
	`flipFallbackPlacements` to further configure how the fallback placement is determined.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #flip
]

{ #category : #accessing }
WaPopup >> flip: aBoolean [

	"When set, placement of the popup will flip to the opposite site to keep it in view. You can use
	`flipFallbackPlacements` to further configure how the fallback placement is determined.
	
	Type: Boolean
	Default: false"

	self propertyAt: #flip put: aBoolean
]

{ #category : #accessing }
WaPopup >> flipBoundary [

	"The flip boundary describes clipping element(s) that overflow will be checked relative to when flipping. By
	default, the boundary includes overflow ancestors that will cause the element to be clipped. If needed, you can
	change the boundary by passing a reference to one or more elements to this property.
	
	Type: HtmlElement (Element | Element[])"

	^ self propertyAt: #flipBoundary
]

{ #category : #accessing }
WaPopup >> flipBoundary: anHtmlElement [

	"The flip boundary describes clipping element(s) that overflow will be checked relative to when flipping. By
	default, the boundary includes overflow ancestors that will cause the element to be clipped. If needed, you can
	change the boundary by passing a reference to one or more elements to this property.
	
	Type: HtmlElement (Element | Element[])"

	self propertyAt: #flipBoundary put: anHtmlElement
]

{ #category : #accessing }
WaPopup >> flipFallbackPlacements [

	"If the preferred placement doesn't fit, popup will be tested in these fallback placements until one fits. Must be a
	string of any number of placements separated by a space, e.g. ""top bottom left"". If no placement fits, the flip
	fallback strategy will be used instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #flipFallbackPlacements
]

{ #category : #accessing }
WaPopup >> flipFallbackPlacements: aString [

	"If the preferred placement doesn't fit, popup will be tested in these fallback placements until one fits. Must be a
	string of any number of placements separated by a space, e.g. ""top bottom left"". If no placement fits, the flip
	fallback strategy will be used instead.
	
	Type: String
	Default: ''"

	self propertyAt: #flipFallbackPlacements put: aString
]

{ #category : #accessing }
WaPopup >> flipFallbackStrategy [

	"When neither the preferred placement nor the fallback placements fit, this value will be used to determine whether
	the popup should be positioned using the best available fit based on available space or as it was initially
	preferred.
	
	Type: String
	Default: 'best-fit'
	Allowed: 'best-fit' | 'initial'"

	^ self propertyAt: #flipFallbackStrategy
]

{ #category : #accessing }
WaPopup >> flipFallbackStrategy: aString [

	"When neither the preferred placement nor the fallback placements fit, this value will be used to determine whether
	the popup should be positioned using the best available fit based on available space or as it was initially
	preferred.
	
	Type: String
	Default: 'best-fit'
	Allowed: 'best-fit' | 'initial'"

	self propertyAt: #flipFallbackStrategy put: aString
]

{ #category : #accessing }
WaPopup >> flipPadding [

	"The amount of padding, in pixels, to exceed before the flip behavior will occur.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #flipPadding
]

{ #category : #accessing }
WaPopup >> flipPadding: aNumber [

	"The amount of padding, in pixels, to exceed before the flip behavior will occur.
	
	Type: Number
	Default: 0"

	self propertyAt: #flipPadding put: aNumber
]

{ #category : #accessing }
WaPopup >> hoverBridge [

	"When a gap exists between the anchor and the popup element, this option will add a ""hover bridge"" that fills the
	gap using an invisible element. This makes listening for events such as `mouseenter` and `mouseleave` more sane
	because the pointer never technically leaves the element. The hover bridge will only be drawn when the popover is
	active.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #hoverBridge
]

{ #category : #accessing }
WaPopup >> hoverBridge: aBoolean [

	"When a gap exists between the anchor and the popup element, this option will add a ""hover bridge"" that fills the
	gap using an invisible element. This makes listening for events such as `mouseenter` and `mouseleave` more sane
	because the pointer never technically leaves the element. The hover bridge will only be drawn when the popover is
	active.
	
	Type: Boolean
	Default: false"

	self propertyAt: #hoverBridge put: aBoolean
]

{ #category : #accessing }
WaPopup >> placement [

	"The preferred placement of the popup. Note that the actual placement will vary as configured to keep the
	panel inside of the viewport.
	
	Type: String
	Default: 'top'
	Allowed: 'top' | 'top-start' | 'top-end' | 'bottom' | 'bottom-start' | 'bottom-end' | 'right' | 'right-start' | 'right-end' | 'left' | 'left-start' | 'left-end'"

	^ self propertyAt: #placement
]

{ #category : #accessing }
WaPopup >> placement: aString [

	"The preferred placement of the popup. Note that the actual placement will vary as configured to keep the
	panel inside of the viewport.
	
	Type: String
	Default: 'top'
	Allowed: 'top' | 'top-start' | 'top-end' | 'bottom' | 'bottom-start' | 'bottom-end' | 'right' | 'right-start' | 'right-end' | 'left' | 'left-start' | 'left-end'"

	self propertyAt: #placement put: aString
]

{ #category : #accessing }
WaPopup >> popup [

	"A reference to the internal popup container. Useful for animating and styling the popup with JavaScript.
	
	Type: HtmlElement"

	^ self propertyAt: #popup
]

{ #category : #accessing }
WaPopup >> popup: anHtmlElement [

	"A reference to the internal popup container. Useful for animating and styling the popup with JavaScript.
	
	Type: HtmlElement"

	self propertyAt: #popup put: anHtmlElement
]

{ #category : #actions }
WaPopup >> reposition [

	"Forces the popup to recalculate and reposition itself."

	^ self apply: #reposition
]

{ #category : #accessing }
WaPopup >> shift [

	"Moves the popup along the axis to keep it in view when clipped.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #shift
]

{ #category : #accessing }
WaPopup >> shift: aBoolean [

	"Moves the popup along the axis to keep it in view when clipped.
	
	Type: Boolean
	Default: false"

	self propertyAt: #shift put: aBoolean
]

{ #category : #accessing }
WaPopup >> shiftBoundary [

	"The shift boundary describes clipping element(s) that overflow will be checked relative to when shifting. By
	default, the boundary includes overflow ancestors that will cause the element to be clipped. If needed, you can
	change the boundary by passing a reference to one or more elements to this property.
	
	Type: HtmlElement (Element | Element[])"

	^ self propertyAt: #shiftBoundary
]

{ #category : #accessing }
WaPopup >> shiftBoundary: anHtmlElement [

	"The shift boundary describes clipping element(s) that overflow will be checked relative to when shifting. By
	default, the boundary includes overflow ancestors that will cause the element to be clipped. If needed, you can
	change the boundary by passing a reference to one or more elements to this property.
	
	Type: HtmlElement (Element | Element[])"

	self propertyAt: #shiftBoundary put: anHtmlElement
]

{ #category : #accessing }
WaPopup >> shiftPadding [

	"The amount of padding, in pixels, to exceed before the shift behavior will occur.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #shiftPadding
]

{ #category : #accessing }
WaPopup >> shiftPadding: aNumber [

	"The amount of padding, in pixels, to exceed before the shift behavior will occur.
	
	Type: Number
	Default: 0"

	self propertyAt: #shiftPadding put: aNumber
]

{ #category : #accessing }
WaPopup >> skidding [

	"The distance in pixels from which to offset the panel along its anchor.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #skidding
]

{ #category : #accessing }
WaPopup >> skidding: aNumber [

	"The distance in pixels from which to offset the panel along its anchor.
	
	Type: Number
	Default: 0"

	self propertyAt: #skidding put: aNumber
]

{ #category : #accessing }
WaPopup >> sync [

	"Syncs the popup's width or height to that of the anchor element.
	
	Type: String
	Allowed: 'width' | 'height' | 'both'"

	^ self propertyAt: #sync
]

{ #category : #accessing }
WaPopup >> sync: aString [

	"Syncs the popup's width or height to that of the anchor element.
	
	Type: String
	Allowed: 'width' | 'height' | 'both'"

	self propertyAt: #sync put: aString
]
