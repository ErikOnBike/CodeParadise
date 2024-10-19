Class {
	#name : #IonContent,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonContent >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonContent >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonContent >> fixedSlotPlacement [

	"Controls where the fixed content is placed relative to the main content in the DOM. This can be used to control the order in which fixed elements receive keyboard focus. For example, if a FAB in the fixed slot should receive keyboard focus before the main page content, set this property to ''before''.
	
	Type: 'after' | 'before'"

	^ self propertyAt: #fixedSlotPlacement
]

{ #category : #api }
IonContent >> fixedSlotPlacement: aString [

	"Controls where the fixed content is placed relative to the main content in the DOM. This can be used to control the order in which fixed elements receive keyboard focus. For example, if a FAB in the fixed slot should receive keyboard focus before the main page content, set this property to ''before''.
	
	Type: 'after' | 'before'"

	self propertyAt: #fixedSlotPlacement put: aString
]

{ #category : #api }
IonContent >> forceOverscroll [

	"If 'true' and the content does not cause an overflow scroll, the scroll interaction will cause a bounce. If the content exceeds the bounds of ionContent, nothing will change. Note, this does not disable the system bounce on iOS. That is an OS level setting.
	
	Type: boolean"

	^ self propertyAt: #forceOverscroll
]

{ #category : #api }
IonContent >> forceOverscroll: aBoolean [

	"If 'true' and the content does not cause an overflow scroll, the scroll interaction will cause a bounce. If the content exceeds the bounds of ionContent, nothing will change. Note, this does not disable the system bounce on iOS. That is an OS level setting.
	
	Type: boolean"

	self propertyAt: #forceOverscroll put: aBoolean
]

{ #category : #api }
IonContent >> fullscreen [

	"If 'true', the content will scroll behind the headers and footers. This effect can easily be seen by setting the toolbar to transparent.
	
	Type: boolean"

	^ self propertyAt: #fullscreen
]

{ #category : #api }
IonContent >> fullscreen: aBoolean [

	"If 'true', the content will scroll behind the headers and footers. This effect can easily be seen by setting the toolbar to transparent.
	
	Type: boolean"

	self propertyAt: #fullscreen put: aBoolean
]

{ #category : #api }
IonContent >> getBackgroundElement [

	"Returns the background content element.
	
	Type: Promise<HTMLElement>"

	^ self apply: #getBackgroundElement resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonContent >> getScrollElement [

	"Get the element where the actual scrolling takes place. This element can be used to subscribe to 'scroll' events or manually modify 'scrollTop'. However, it's recommended to use the API provided by 'ion-content':  i.e. Using 'ionScroll', 'ionScrollStart', 'ionScrollEnd' for scrolling events and 'scrollToPoint()' to scroll the content into a certain point.
	
	Type: Promise<HTMLElement>"

	^ self apply: #getScrollElement resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonContent >> scrollByPoint: x y: y duration: duration [

	"Scroll by a specified X/Y distance in the component.
	@param x The amount to scroll by on the horizontal axis.
	@param y The amount to scroll by on the vertical axis.
	@param duration The amount of time to take scrolling by that amount.
	
	Type: (x: number, y: number, duration: number) => Promise<void>"

	^ self apply: #scrollByPoint withArguments: { x . y . duration } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonContent >> scrollEvents [

	"Because of performance reasons, ionScroll events are disabled by default, in order to enable them and start listening from (ionScroll), set this property to 'true'.
	
	Type: boolean"

	^ self propertyAt: #scrollEvents
]

{ #category : #api }
IonContent >> scrollEvents: aBoolean [

	"Because of performance reasons, ionScroll events are disabled by default, in order to enable them and start listening from (ionScroll), set this property to 'true'.
	
	Type: boolean"

	self propertyAt: #scrollEvents put: aBoolean
]

{ #category : #api }
IonContent >> scrollToBottom [

	"Scroll to the bottom of the component.
	@param duration The amount of time to take scrolling to the bottom. Defaults to '0'.
	
	Type: (duration?: number) => Promise<void>"

	^ self apply: #scrollToBottom resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonContent >> scrollToBottom: duration [

	"Scroll to the bottom of the component.
	@param duration The amount of time to take scrolling to the bottom. Defaults to '0'.
	
	Type: (duration?: number) => Promise<void>"

	^ self apply: #scrollToBottom withArguments: { duration } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonContent >> scrollToPoint: x y: y [

	"Scroll to a specified X/Y location in the component.
	@param x The point to scroll to on the horizontal axis.
	@param y The point to scroll to on the vertical axis.
	@param duration The amount of time to take scrolling to that point. Defaults to '0'.
	
	Type: (x: number | undefined | null, y: number | undefined | null, duration?: number) => Promise<void>"

	^ self apply: #scrollToPoint withArguments: { x . y } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonContent >> scrollToPoint: x y: y duration: duration [

	"Scroll to a specified X/Y location in the component.
	@param x The point to scroll to on the horizontal axis.
	@param y The point to scroll to on the vertical axis.
	@param duration The amount of time to take scrolling to that point. Defaults to '0'.
	
	Type: (x: number | undefined | null, y: number | undefined | null, duration?: number) => Promise<void>"

	^ self apply: #scrollToPoint withArguments: { x . y . duration } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonContent >> scrollToTop [

	"Scroll to the top of the component.
	@param duration The amount of time to take scrolling to the top. Defaults to '0'.
	
	Type: (duration?: number) => Promise<void>"

	^ self apply: #scrollToTop resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonContent >> scrollToTop: duration [

	"Scroll to the top of the component.
	@param duration The amount of time to take scrolling to the top. Defaults to '0'.
	
	Type: (duration?: number) => Promise<void>"

	^ self apply: #scrollToTop withArguments: { duration } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonContent >> scrollX [

	"If you want to enable the content scrolling in the X axis, set this property to 'true'.
	
	Type: boolean"

	^ self propertyAt: #scrollX
]

{ #category : #api }
IonContent >> scrollX: aBoolean [

	"If you want to enable the content scrolling in the X axis, set this property to 'true'.
	
	Type: boolean"

	self propertyAt: #scrollX put: aBoolean
]

{ #category : #api }
IonContent >> scrollY [

	"If you want to disable the content scrolling in the Y axis, set this property to 'false'.
	
	Type: boolean"

	^ self propertyAt: #scrollY
]

{ #category : #api }
IonContent >> scrollY: aBoolean [

	"If you want to disable the content scrolling in the Y axis, set this property to 'false'.
	
	Type: boolean"

	self propertyAt: #scrollY put: aBoolean
]
