Class {
	#name : #IonActionSheet,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonActionSheet >> animated [

	"If 'true', the action sheet will animate.
	
	Type: boolean"

	^ self propertyAt: #animated
]

{ #category : #api }
IonActionSheet >> animated: aBoolean [

	"If 'true', the action sheet will animate.
	
	Type: boolean"

	self propertyAt: #animated put: aBoolean
]

{ #category : #api }
IonActionSheet >> backdropDismiss [

	"If 'true', the action sheet will be dismissed when the backdrop is clicked.
	
	Type: boolean"

	^ self propertyAt: #backdropDismiss
]

{ #category : #api }
IonActionSheet >> backdropDismiss: aBoolean [

	"If 'true', the action sheet will be dismissed when the backdrop is clicked.
	
	Type: boolean"

	self propertyAt: #backdropDismiss put: aBoolean
]

{ #category : #api }
IonActionSheet >> buttons [

	"An array of buttons for the action sheet.
	
	Type: (ActionSheetButton | string)[]"

	^ self propertyAt: #buttons
]

{ #category : #api }
IonActionSheet >> buttons: anObject [

	"An array of buttons for the action sheet.
	
	Type: (ActionSheetButton | string)[]"

	self propertyAt: #buttons put: anObject
]

{ #category : #api }
IonActionSheet >> cssClass [

	"Additional classes to apply for custom CSS. If multiple classes are provided they should be separated by spaces.
	
	Type: string | string[]"

	^ self propertyAt: #cssClass
]

{ #category : #api }
IonActionSheet >> cssClass: anObject [

	"Additional classes to apply for custom CSS. If multiple classes are provided they should be separated by spaces.
	
	Type: string | string[]"

	self propertyAt: #cssClass put: anObject
]

{ #category : #api }
IonActionSheet >> delegate [

	"Type: FrameworkDelegate"

	^ self propertyAt: #delegate
]

{ #category : #api }
IonActionSheet >> delegate: anObject [

	"Type: FrameworkDelegate"

	self propertyAt: #delegate put: anObject
]

{ #category : #api }
IonActionSheet >> dismiss [

	"Dismiss the action sheet overlay after it has been presented.
	@param data Any data to emit in the dismiss events.
	@param role The role of the element that is dismissing the action sheet. This can be useful in a button handler for determining which button was clicked to dismiss the action sheet. Some examples include: '''cancel'', ''destructive'', 'selected'', and ''backdrop''.  This is a no-op if the overlay has not been presented yet. If you want to remove an overlay from the DOM that was never presented, use the [remove](https://developer.mozilla.org/en-US/docs/Web/API/Element/remove) method.
	
	Type: (data?: any, role?: string) => Promise<boolean>"

	^ self apply: #dismiss resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonActionSheet >> dismiss: data [

	"Dismiss the action sheet overlay after it has been presented.
	@param data Any data to emit in the dismiss events.
	@param role The role of the element that is dismissing the action sheet. This can be useful in a button handler for determining which button was clicked to dismiss the action sheet. Some examples include: '''cancel'', ''destructive'', 'selected'', and ''backdrop''.  This is a no-op if the overlay has not been presented yet. If you want to remove an overlay from the DOM that was never presented, use the [remove](https://developer.mozilla.org/en-US/docs/Web/API/Element/remove) method.
	
	Type: (data?: any, role?: string) => Promise<boolean>"

	^ self apply: #dismiss withArguments: { data } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonActionSheet >> dismiss: data role: role [

	"Dismiss the action sheet overlay after it has been presented.
	@param data Any data to emit in the dismiss events.
	@param role The role of the element that is dismissing the action sheet. This can be useful in a button handler for determining which button was clicked to dismiss the action sheet. Some examples include: '''cancel'', ''destructive'', 'selected'', and ''backdrop''.  This is a no-op if the overlay has not been presented yet. If you want to remove an overlay from the DOM that was never presented, use the [remove](https://developer.mozilla.org/en-US/docs/Web/API/Element/remove) method.
	
	Type: (data?: any, role?: string) => Promise<boolean>"

	^ self apply: #dismiss withArguments: { data . role } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonActionSheet >> enterAnimation [

	"Animation to use when the action sheet is presented.
	
	Type: AnimationBuilder"

	^ self propertyAt: #enterAnimation
]

{ #category : #api }
IonActionSheet >> enterAnimation: anObject [

	"Animation to use when the action sheet is presented.
	
	Type: AnimationBuilder"

	self propertyAt: #enterAnimation put: anObject
]

{ #category : #api }
IonActionSheet >> hasController [

	"Type: boolean"

	^ self propertyAt: #hasController
]

{ #category : #api }
IonActionSheet >> hasController: aBoolean [

	"Type: boolean"

	self propertyAt: #hasController put: aBoolean
]

{ #category : #api }
IonActionSheet >> header [

	"Title for the action sheet.
	
	Type: string"

	^ self propertyAt: #header
]

{ #category : #api }
IonActionSheet >> header: aString [

	"Title for the action sheet.
	
	Type: string"

	self propertyAt: #header put: aString
]

{ #category : #api }
IonActionSheet >> htmlAttributes [

	"Additional attributes to pass to the action sheet.
	
	Type: { [key: string]: any }"

	^ self propertyAt: #htmlAttributes
]

{ #category : #api }
IonActionSheet >> htmlAttributes: anObject [

	"Additional attributes to pass to the action sheet.
	
	Type: { [key: string]: any }"

	self propertyAt: #htmlAttributes put: anObject
]

{ #category : #api }
IonActionSheet >> isOpen [

	"If 'true', the action sheet will open. If 'false', the action sheet will close. Use this if you need finer grained control over presentation, otherwise just use the actionSheetController or the 'trigger' property. Note: 'isOpen' will not automatically be set back to 'false' when the action sheet dismisses. You will need to do that in your code.
	
	Type: boolean"

	^ self propertyAt: #isOpen
]

{ #category : #api }
IonActionSheet >> isOpen: aBoolean [

	"If 'true', the action sheet will open. If 'false', the action sheet will close. Use this if you need finer grained control over presentation, otherwise just use the actionSheetController or the 'trigger' property. Note: 'isOpen' will not automatically be set back to 'false' when the action sheet dismisses. You will need to do that in your code.
	
	Type: boolean"

	self propertyAt: #isOpen put: aBoolean
]

{ #category : #api }
IonActionSheet >> keyboardClose [

	"If 'true', the keyboard will be automatically dismissed when the overlay is presented.
	
	Type: boolean"

	^ self propertyAt: #keyboardClose
]

{ #category : #api }
IonActionSheet >> keyboardClose: aBoolean [

	"If 'true', the keyboard will be automatically dismissed when the overlay is presented.
	
	Type: boolean"

	self propertyAt: #keyboardClose put: aBoolean
]

{ #category : #api }
IonActionSheet >> leaveAnimation [

	"Animation to use when the action sheet is dismissed.
	
	Type: AnimationBuilder"

	^ self propertyAt: #leaveAnimation
]

{ #category : #api }
IonActionSheet >> leaveAnimation: anObject [

	"Animation to use when the action sheet is dismissed.
	
	Type: AnimationBuilder"

	self propertyAt: #leaveAnimation put: anObject
]

{ #category : #api }
IonActionSheet >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonActionSheet >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonActionSheet >> onDidDismiss [

	"Returns a promise that resolves when the action sheet did dismiss.
	
	Type: <T = any>() => Promise<OverlayEventDetail<T>>"

	^ self apply: #onDidDismiss resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonActionSheet >> onWillDismiss [

	"Returns a promise that resolves when the action sheet will dismiss.
	
	Type: <T = any>() => Promise<OverlayEventDetail<T>>"

	^ self apply: #onWillDismiss resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonActionSheet >> overlayIndex [

	"Type: number"

	^ self propertyAt: #overlayIndex
]

{ #category : #api }
IonActionSheet >> overlayIndex: aNumber [

	"Type: number"

	self propertyAt: #overlayIndex put: aNumber
]

{ #category : #api }
IonActionSheet >> present [

	"Present the action sheet overlay after it has been created.
	
	Type: Promise<void>"

	^ self apply: #present resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonActionSheet >> subHeader [

	"Subtitle for the action sheet.
	
	Type: string"

	^ self propertyAt: #subHeader
]

{ #category : #api }
IonActionSheet >> subHeader: aString [

	"Subtitle for the action sheet.
	
	Type: string"

	self propertyAt: #subHeader put: aString
]

{ #category : #api }
IonActionSheet >> translucent [

	"If 'true', the action sheet will be translucent. Only applies when the mode is ''ios'' and the device supports ['backdrop-filter'](https://developer.mozilla.org/en-US/docs/Web/CSS/backdrop-filter#Browser_compatibility).
	
	Type: boolean"

	^ self propertyAt: #translucent
]

{ #category : #api }
IonActionSheet >> translucent: aBoolean [

	"If 'true', the action sheet will be translucent. Only applies when the mode is ''ios'' and the device supports ['backdrop-filter'](https://developer.mozilla.org/en-US/docs/Web/CSS/backdrop-filter#Browser_compatibility).
	
	Type: boolean"

	self propertyAt: #translucent put: aBoolean
]

{ #category : #api }
IonActionSheet >> trigger [

	"An ID corresponding to the trigger element that causes the action sheet to open when clicked.
	
	Type: string | undefined"

	^ self propertyAt: #trigger
]

{ #category : #api }
IonActionSheet >> trigger: aString [

	"An ID corresponding to the trigger element that causes the action sheet to open when clicked.
	
	Type: string | undefined"

	self propertyAt: #trigger put: aString
]
