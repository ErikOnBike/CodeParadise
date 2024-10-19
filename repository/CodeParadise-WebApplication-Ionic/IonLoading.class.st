Class {
	#name : #IonLoading,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonLoading >> animated [

	"If 'true', the loading indicator will animate.
	
	Type: boolean"

	^ self propertyAt: #animated
]

{ #category : #api }
IonLoading >> animated: aBoolean [

	"If 'true', the loading indicator will animate.
	
	Type: boolean"

	self propertyAt: #animated put: aBoolean
]

{ #category : #api }
IonLoading >> backdropDismiss [

	"If 'true', the loading indicator will be dismissed when the backdrop is clicked.
	
	Type: boolean"

	^ self propertyAt: #backdropDismiss
]

{ #category : #api }
IonLoading >> backdropDismiss: aBoolean [

	"If 'true', the loading indicator will be dismissed when the backdrop is clicked.
	
	Type: boolean"

	self propertyAt: #backdropDismiss put: aBoolean
]

{ #category : #api }
IonLoading >> cssClass [

	"Additional classes to apply for custom CSS. If multiple classes are provided they should be separated by spaces.
	
	Type: string | string[]"

	^ self propertyAt: #cssClass
]

{ #category : #api }
IonLoading >> cssClass: anObject [

	"Additional classes to apply for custom CSS. If multiple classes are provided they should be separated by spaces.
	
	Type: string | string[]"

	self propertyAt: #cssClass put: anObject
]

{ #category : #api }
IonLoading >> delegate [

	"Type: FrameworkDelegate"

	^ self propertyAt: #delegate
]

{ #category : #api }
IonLoading >> delegate: anObject [

	"Type: FrameworkDelegate"

	self propertyAt: #delegate put: anObject
]

{ #category : #api }
IonLoading >> dismiss [

	"Dismiss the loading overlay after it has been presented.
	@param data Any data to emit in the dismiss events.
	@param role The role of the element that is dismissing the loading. This can be useful in a button handler for determining which button was clicked to dismiss the loading. Some examples include: '''cancel'', ''destructive'', 'selected'', and ''backdrop''.  This is a no-op if the overlay has not been presented yet. If you want to remove an overlay from the DOM that was never presented, use the [remove](https://developer.mozilla.org/en-US/docs/Web/API/Element/remove) method.
	
	Type: (data?: any, role?: string) => Promise<boolean>"

	^ self apply: #dismiss resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonLoading >> dismiss: data [

	"Dismiss the loading overlay after it has been presented.
	@param data Any data to emit in the dismiss events.
	@param role The role of the element that is dismissing the loading. This can be useful in a button handler for determining which button was clicked to dismiss the loading. Some examples include: '''cancel'', ''destructive'', 'selected'', and ''backdrop''.  This is a no-op if the overlay has not been presented yet. If you want to remove an overlay from the DOM that was never presented, use the [remove](https://developer.mozilla.org/en-US/docs/Web/API/Element/remove) method.
	
	Type: (data?: any, role?: string) => Promise<boolean>"

	^ self apply: #dismiss withArguments: { data } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonLoading >> dismiss: data role: role [

	"Dismiss the loading overlay after it has been presented.
	@param data Any data to emit in the dismiss events.
	@param role The role of the element that is dismissing the loading. This can be useful in a button handler for determining which button was clicked to dismiss the loading. Some examples include: '''cancel'', ''destructive'', 'selected'', and ''backdrop''.  This is a no-op if the overlay has not been presented yet. If you want to remove an overlay from the DOM that was never presented, use the [remove](https://developer.mozilla.org/en-US/docs/Web/API/Element/remove) method.
	
	Type: (data?: any, role?: string) => Promise<boolean>"

	^ self apply: #dismiss withArguments: { data . role } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonLoading >> duration [

	"Number of milliseconds to wait before dismissing the loading indicator.
	
	Type: number"

	^ self propertyAt: #duration
]

{ #category : #api }
IonLoading >> duration: aNumber [

	"Number of milliseconds to wait before dismissing the loading indicator.
	
	Type: number"

	self propertyAt: #duration put: aNumber
]

{ #category : #api }
IonLoading >> enterAnimation [

	"Animation to use when the loading indicator is presented.
	
	Type: AnimationBuilder"

	^ self propertyAt: #enterAnimation
]

{ #category : #api }
IonLoading >> enterAnimation: anObject [

	"Animation to use when the loading indicator is presented.
	
	Type: AnimationBuilder"

	self propertyAt: #enterAnimation put: anObject
]

{ #category : #api }
IonLoading >> hasController [

	"Type: boolean"

	^ self propertyAt: #hasController
]

{ #category : #api }
IonLoading >> hasController: aBoolean [

	"Type: boolean"

	self propertyAt: #hasController put: aBoolean
]

{ #category : #api }
IonLoading >> htmlAttributes [

	"Additional attributes to pass to the loader.
	
	Type: { [key: string]: any }"

	^ self propertyAt: #htmlAttributes
]

{ #category : #api }
IonLoading >> htmlAttributes: anObject [

	"Additional attributes to pass to the loader.
	
	Type: { [key: string]: any }"

	self propertyAt: #htmlAttributes put: anObject
]

{ #category : #api }
IonLoading >> isOpen [

	"If 'true', the loading indicator will open. If 'false', the loading indicator will close. Use this if you need finer grained control over presentation, otherwise just use the loadingController or the 'trigger' property. Note: 'isOpen' will not automatically be set back to 'false' when the loading indicator dismisses. You will need to do that in your code.
	
	Type: boolean"

	^ self propertyAt: #isOpen
]

{ #category : #api }
IonLoading >> isOpen: aBoolean [

	"If 'true', the loading indicator will open. If 'false', the loading indicator will close. Use this if you need finer grained control over presentation, otherwise just use the loadingController or the 'trigger' property. Note: 'isOpen' will not automatically be set back to 'false' when the loading indicator dismisses. You will need to do that in your code.
	
	Type: boolean"

	self propertyAt: #isOpen put: aBoolean
]

{ #category : #api }
IonLoading >> keyboardClose [

	"If 'true', the keyboard will be automatically dismissed when the overlay is presented.
	
	Type: boolean"

	^ self propertyAt: #keyboardClose
]

{ #category : #api }
IonLoading >> keyboardClose: aBoolean [

	"If 'true', the keyboard will be automatically dismissed when the overlay is presented.
	
	Type: boolean"

	self propertyAt: #keyboardClose put: aBoolean
]

{ #category : #api }
IonLoading >> leaveAnimation [

	"Animation to use when the loading indicator is dismissed.
	
	Type: AnimationBuilder"

	^ self propertyAt: #leaveAnimation
]

{ #category : #api }
IonLoading >> leaveAnimation: anObject [

	"Animation to use when the loading indicator is dismissed.
	
	Type: AnimationBuilder"

	self propertyAt: #leaveAnimation put: anObject
]

{ #category : #api }
IonLoading >> message [

	"Optional text content to display in the loading indicator.  This property accepts custom HTML as a string. Content is parsed as plaintext by default. 'innerHTMLTemplatesEnabled' must be set to 'true' in the Ionic config before custom HTML can be used.
	
	Type: string | IonicSafeString"

	^ self propertyAt: #message
]

{ #category : #api }
IonLoading >> message: anObject [

	"Optional text content to display in the loading indicator.  This property accepts custom HTML as a string. Content is parsed as plaintext by default. 'innerHTMLTemplatesEnabled' must be set to 'true' in the Ionic config before custom HTML can be used.
	
	Type: string | IonicSafeString"

	self propertyAt: #message put: anObject
]

{ #category : #api }
IonLoading >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonLoading >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonLoading >> onDidDismiss [

	"Returns a promise that resolves when the loading did dismiss.
	
	Type: <T = any>() => Promise<OverlayEventDetail<T>>"

	^ self apply: #onDidDismiss resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonLoading >> onWillDismiss [

	"Returns a promise that resolves when the loading will dismiss.
	
	Type: <T = any>() => Promise<OverlayEventDetail<T>>"

	^ self apply: #onWillDismiss resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonLoading >> overlayIndex [

	"Type: number"

	^ self propertyAt: #overlayIndex
]

{ #category : #api }
IonLoading >> overlayIndex: aNumber [

	"Type: number"

	self propertyAt: #overlayIndex put: aNumber
]

{ #category : #api }
IonLoading >> present [

	"Present the loading overlay after it has been created.
	
	Type: Promise<void>"

	^ self apply: #present resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonLoading >> showBackdrop [

	"If 'true', a backdrop will be displayed behind the loading indicator.
	
	Type: boolean"

	^ self propertyAt: #showBackdrop
]

{ #category : #api }
IonLoading >> showBackdrop: aBoolean [

	"If 'true', a backdrop will be displayed behind the loading indicator.
	
	Type: boolean"

	self propertyAt: #showBackdrop put: aBoolean
]

{ #category : #api }
IonLoading >> spinner [

	"The name of the spinner to display.
	
	Type: SpinnerTypes | null"

	^ self propertyAt: #spinner
]

{ #category : #api }
IonLoading >> spinner: anObject [

	"The name of the spinner to display.
	
	Type: SpinnerTypes | null"

	self propertyAt: #spinner put: anObject
]

{ #category : #api }
IonLoading >> translucent [

	"If 'true', the loading indicator will be translucent. Only applies when the mode is ''ios'' and the device supports ['backdrop-filter'](https://developer.mozilla.org/en-US/docs/Web/CSS/backdrop-filter#Browser_compatibility).
	
	Type: boolean"

	^ self propertyAt: #translucent
]

{ #category : #api }
IonLoading >> translucent: aBoolean [

	"If 'true', the loading indicator will be translucent. Only applies when the mode is ''ios'' and the device supports ['backdrop-filter'](https://developer.mozilla.org/en-US/docs/Web/CSS/backdrop-filter#Browser_compatibility).
	
	Type: boolean"

	self propertyAt: #translucent put: aBoolean
]

{ #category : #api }
IonLoading >> trigger [

	"An ID corresponding to the trigger element that causes the loading indicator to open when clicked.
	
	Type: string | undefined"

	^ self propertyAt: #trigger
]

{ #category : #api }
IonLoading >> trigger: aString [

	"An ID corresponding to the trigger element that causes the loading indicator to open when clicked.
	
	Type: string | undefined"

	self propertyAt: #trigger put: aString
]
