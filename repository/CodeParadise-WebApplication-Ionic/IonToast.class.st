Class {
	#name : #IonToast,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonToast >> animated [

	"If 'true', the toast will animate.
	
	Type: boolean"

	^ self propertyAt: #animated
]

{ #category : #api }
IonToast >> animated: aBoolean [

	"If 'true', the toast will animate.
	
	Type: boolean"

	self propertyAt: #animated put: aBoolean
]

{ #category : #api }
IonToast >> buttons [

	"An array of buttons for the toast.
	
	Type: (ToastButton | string)[]"

	^ self propertyAt: #buttons
]

{ #category : #api }
IonToast >> buttons: anObject [

	"An array of buttons for the toast.
	
	Type: (ToastButton | string)[]"

	self propertyAt: #buttons put: anObject
]

{ #category : #api }
IonToast >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonToast >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonToast >> cssClass [

	"Additional classes to apply for custom CSS. If multiple classes are provided they should be separated by spaces.
	
	Type: string | string[]"

	^ self propertyAt: #cssClass
]

{ #category : #api }
IonToast >> cssClass: anObject [

	"Additional classes to apply for custom CSS. If multiple classes are provided they should be separated by spaces.
	
	Type: string | string[]"

	self propertyAt: #cssClass put: anObject
]

{ #category : #api }
IonToast >> delegate [

	"Type: FrameworkDelegate"

	^ self propertyAt: #delegate
]

{ #category : #api }
IonToast >> delegate: anObject [

	"Type: FrameworkDelegate"

	self propertyAt: #delegate put: anObject
]

{ #category : #api }
IonToast >> dismiss [

	"Dismiss the toast overlay after it has been presented.
	@param data Any data to emit in the dismiss events.
	@param role The role of the element that is dismissing the toast. This can be useful in a button handler for determining which button was clicked to dismiss the toast. Some examples include: '''cancel'', ''destructive'', 'selected'', and ''backdrop''.  This is a no-op if the overlay has not been presented yet. If you want to remove an overlay from the DOM that was never presented, use the [remove](https://developer.mozilla.org/en-US/docs/Web/API/Element/remove) method.
	
	Type: (data?: any, role?: string) => Promise<boolean>"

	^ self apply: #dismiss resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonToast >> dismiss: data [

	"Dismiss the toast overlay after it has been presented.
	@param data Any data to emit in the dismiss events.
	@param role The role of the element that is dismissing the toast. This can be useful in a button handler for determining which button was clicked to dismiss the toast. Some examples include: '''cancel'', ''destructive'', 'selected'', and ''backdrop''.  This is a no-op if the overlay has not been presented yet. If you want to remove an overlay from the DOM that was never presented, use the [remove](https://developer.mozilla.org/en-US/docs/Web/API/Element/remove) method.
	
	Type: (data?: any, role?: string) => Promise<boolean>"

	^ self apply: #dismiss withArguments: { data } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonToast >> dismiss: data role: role [

	"Dismiss the toast overlay after it has been presented.
	@param data Any data to emit in the dismiss events.
	@param role The role of the element that is dismissing the toast. This can be useful in a button handler for determining which button was clicked to dismiss the toast. Some examples include: '''cancel'', ''destructive'', 'selected'', and ''backdrop''.  This is a no-op if the overlay has not been presented yet. If you want to remove an overlay from the DOM that was never presented, use the [remove](https://developer.mozilla.org/en-US/docs/Web/API/Element/remove) method.
	
	Type: (data?: any, role?: string) => Promise<boolean>"

	^ self apply: #dismiss withArguments: { data . role } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonToast >> duration [

	"How many milliseconds to wait before hiding the toast. By default, it will show until 'dismiss()' is called.
	
	Type: number"

	^ self propertyAt: #duration
]

{ #category : #api }
IonToast >> duration: aNumber [

	"How many milliseconds to wait before hiding the toast. By default, it will show until 'dismiss()' is called.
	
	Type: number"

	self propertyAt: #duration put: aNumber
]

{ #category : #api }
IonToast >> enterAnimation [

	"Animation to use when the toast is presented.
	
	Type: AnimationBuilder"

	^ self propertyAt: #enterAnimation
]

{ #category : #api }
IonToast >> enterAnimation: anObject [

	"Animation to use when the toast is presented.
	
	Type: AnimationBuilder"

	self propertyAt: #enterAnimation put: anObject
]

{ #category : #api }
IonToast >> hasController [

	"Type: boolean"

	^ self propertyAt: #hasController
]

{ #category : #api }
IonToast >> hasController: aBoolean [

	"Type: boolean"

	self propertyAt: #hasController put: aBoolean
]

{ #category : #api }
IonToast >> header [

	"Header to be shown in the toast.
	
	Type: string"

	^ self propertyAt: #header
]

{ #category : #api }
IonToast >> header: aString [

	"Header to be shown in the toast.
	
	Type: string"

	self propertyAt: #header put: aString
]

{ #category : #api }
IonToast >> htmlAttributes [

	"Additional attributes to pass to the toast.
	
	Type: { [key: string]: any }"

	^ self propertyAt: #htmlAttributes
]

{ #category : #api }
IonToast >> htmlAttributes: anObject [

	"Additional attributes to pass to the toast.
	
	Type: { [key: string]: any }"

	self propertyAt: #htmlAttributes put: anObject
]

{ #category : #api }
IonToast >> icon [

	"The name of the icon to display, or the path to a valid SVG file. See 'ion-icon'. https://ionic.io/ionicons
	
	Type: string"

	^ self propertyAt: #icon
]

{ #category : #api }
IonToast >> icon: aString [

	"The name of the icon to display, or the path to a valid SVG file. See 'ion-icon'. https://ionic.io/ionicons
	
	Type: string"

	self propertyAt: #icon put: aString
]

{ #category : #api }
IonToast >> isOpen [

	"If 'true', the toast will open. If 'false', the toast will close. Use this if you need finer grained control over presentation, otherwise just use the toastController or the 'trigger' property. Note: 'isOpen' will not automatically be set back to 'false' when the toast dismisses. You will need to do that in your code.
	
	Type: boolean"

	^ self propertyAt: #isOpen
]

{ #category : #api }
IonToast >> isOpen: aBoolean [

	"If 'true', the toast will open. If 'false', the toast will close. Use this if you need finer grained control over presentation, otherwise just use the toastController or the 'trigger' property. Note: 'isOpen' will not automatically be set back to 'false' when the toast dismisses. You will need to do that in your code.
	
	Type: boolean"

	self propertyAt: #isOpen put: aBoolean
]

{ #category : #api }
IonToast >> keyboardClose [

	"If 'true', the keyboard will be automatically dismissed when the overlay is presented.
	
	Type: boolean"

	^ self propertyAt: #keyboardClose
]

{ #category : #api }
IonToast >> keyboardClose: aBoolean [

	"If 'true', the keyboard will be automatically dismissed when the overlay is presented.
	
	Type: boolean"

	self propertyAt: #keyboardClose put: aBoolean
]

{ #category : #api }
IonToast >> layout [

	"Defines how the message and buttons are laid out in the toast. 'baseline': The message and the buttons will appear on the same line. Message text may wrap within the message container. 'stacked': The buttons containers and message will stack on top of each other. Use this if you have long text in your buttons.
	
	Type: ToastLayout"

	^ self propertyAt: #layout
]

{ #category : #api }
IonToast >> layout: anObject [

	"Defines how the message and buttons are laid out in the toast. 'baseline': The message and the buttons will appear on the same line. Message text may wrap within the message container. 'stacked': The buttons containers and message will stack on top of each other. Use this if you have long text in your buttons.
	
	Type: ToastLayout"

	self propertyAt: #layout put: anObject
]

{ #category : #api }
IonToast >> leaveAnimation [

	"Animation to use when the toast is dismissed.
	
	Type: AnimationBuilder"

	^ self propertyAt: #leaveAnimation
]

{ #category : #api }
IonToast >> leaveAnimation: anObject [

	"Animation to use when the toast is dismissed.
	
	Type: AnimationBuilder"

	self propertyAt: #leaveAnimation put: anObject
]

{ #category : #api }
IonToast >> message [

	"Message to be shown in the toast. This property accepts custom HTML as a string. Content is parsed as plaintext by default. 'innerHTMLTemplatesEnabled' must be set to 'true' in the Ionic config before custom HTML can be used.
	
	Type: string | IonicSafeString"

	^ self propertyAt: #message
]

{ #category : #api }
IonToast >> message: anObject [

	"Message to be shown in the toast. This property accepts custom HTML as a string. Content is parsed as plaintext by default. 'innerHTMLTemplatesEnabled' must be set to 'true' in the Ionic config before custom HTML can be used.
	
	Type: string | IonicSafeString"

	self propertyAt: #message put: anObject
]

{ #category : #api }
IonToast >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonToast >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonToast >> onDidDismiss [

	"Returns a promise that resolves when the toast did dismiss.
	
	Type: <T = any>() => Promise<OverlayEventDetail<T>>"

	^ self apply: #onDidDismiss resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonToast >> onWillDismiss [

	"Returns a promise that resolves when the toast will dismiss.
	
	Type: <T = any>() => Promise<OverlayEventDetail<T>>"

	^ self apply: #onWillDismiss resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonToast >> overlayIndex [

	"Type: number"

	^ self propertyAt: #overlayIndex
]

{ #category : #api }
IonToast >> overlayIndex: aNumber [

	"Type: number"

	self propertyAt: #overlayIndex put: aNumber
]

{ #category : #api }
IonToast >> position [

	"The starting position of the toast on the screen. Can be tweaked further using the 'positionAnchor' property.
	
	Type: ToastPosition"

	^ self propertyAt: #position
]

{ #category : #api }
IonToast >> position: anObject [

	"The starting position of the toast on the screen. Can be tweaked further using the 'positionAnchor' property.
	
	Type: ToastPosition"

	self propertyAt: #position put: anObject
]

{ #category : #api }
IonToast >> positionAnchor [

	"The element to anchor the toast's position to. Can be set as a direct reference or the ID of the element. With 'position='bottom'', the toast will sit above the chosen element. With 'position='top'', the toast will sit below the chosen element. With 'position='middle'', the value of 'positionAnchor' is ignored.
	
	Type: HTMLElement | string"

	^ self propertyAt: #positionAnchor
]

{ #category : #api }
IonToast >> positionAnchor: anObject [

	"The element to anchor the toast's position to. Can be set as a direct reference or the ID of the element. With 'position='bottom'', the toast will sit above the chosen element. With 'position='top'', the toast will sit below the chosen element. With 'position='middle'', the value of 'positionAnchor' is ignored.
	
	Type: HTMLElement | string"

	self propertyAt: #positionAnchor put: anObject
]

{ #category : #api }
IonToast >> present [

	"Present the toast overlay after it has been created.
	
	Type: Promise<void>"

	^ self apply: #present resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonToast >> swipeGesture [

	"If set to 'vertical', the Toast can be dismissed with a swipe gesture. The swipe direction is determined by the value of the 'position' property: 'top': The Toast can be swiped up to dismiss. 'bottom': The Toast can be swiped down to dismiss. 'middle': The Toast can be swiped up or down to dismiss.
	
	Type: ToastSwipeGestureDirection"

	^ self propertyAt: #swipeGesture
]

{ #category : #api }
IonToast >> swipeGesture: anObject [

	"If set to 'vertical', the Toast can be dismissed with a swipe gesture. The swipe direction is determined by the value of the 'position' property: 'top': The Toast can be swiped up to dismiss. 'bottom': The Toast can be swiped down to dismiss. 'middle': The Toast can be swiped up or down to dismiss.
	
	Type: ToastSwipeGestureDirection"

	self propertyAt: #swipeGesture put: anObject
]

{ #category : #api }
IonToast >> translucent [

	"If 'true', the toast will be translucent. Only applies when the mode is ''ios'' and the device supports ['backdrop-filter'](https://developer.mozilla.org/en-US/docs/Web/CSS/backdrop-filter#Browser_compatibility).
	
	Type: boolean"

	^ self propertyAt: #translucent
]

{ #category : #api }
IonToast >> translucent: aBoolean [

	"If 'true', the toast will be translucent. Only applies when the mode is ''ios'' and the device supports ['backdrop-filter'](https://developer.mozilla.org/en-US/docs/Web/CSS/backdrop-filter#Browser_compatibility).
	
	Type: boolean"

	self propertyAt: #translucent put: aBoolean
]

{ #category : #api }
IonToast >> trigger [

	"An ID corresponding to the trigger element that causes the toast to open when clicked.
	
	Type: string | undefined"

	^ self propertyAt: #trigger
]

{ #category : #api }
IonToast >> trigger: aString [

	"An ID corresponding to the trigger element that causes the toast to open when clicked.
	
	Type: string | undefined"

	self propertyAt: #trigger put: aString
]
