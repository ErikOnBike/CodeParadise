Class {
	#name : #IonAlert,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonAlert >> animated [

	"If 'true', the alert will animate.
	
	Type: boolean"

	^ self propertyAt: #animated
]

{ #category : #api }
IonAlert >> animated: aBoolean [

	"If 'true', the alert will animate.
	
	Type: boolean"

	self propertyAt: #animated put: aBoolean
]

{ #category : #api }
IonAlert >> backdropDismiss [

	"If 'true', the alert will be dismissed when the backdrop is clicked.
	
	Type: boolean"

	^ self propertyAt: #backdropDismiss
]

{ #category : #api }
IonAlert >> backdropDismiss: aBoolean [

	"If 'true', the alert will be dismissed when the backdrop is clicked.
	
	Type: boolean"

	self propertyAt: #backdropDismiss put: aBoolean
]

{ #category : #api }
IonAlert >> buttons [

	"Array of buttons to be added to the alert.
	
	Type: (AlertButton | string)[]"

	^ self propertyAt: #buttons
]

{ #category : #api }
IonAlert >> buttons: anObject [

	"Array of buttons to be added to the alert.
	
	Type: (AlertButton | string)[]"

	self propertyAt: #buttons put: anObject
]

{ #category : #api }
IonAlert >> cssClass [

	"Additional classes to apply for custom CSS. If multiple classes are provided they should be separated by spaces.
	
	Type: string | string[]"

	^ self propertyAt: #cssClass
]

{ #category : #api }
IonAlert >> cssClass: anObject [

	"Additional classes to apply for custom CSS. If multiple classes are provided they should be separated by spaces.
	
	Type: string | string[]"

	self propertyAt: #cssClass put: anObject
]

{ #category : #api }
IonAlert >> delegate [

	"Type: FrameworkDelegate"

	^ self propertyAt: #delegate
]

{ #category : #api }
IonAlert >> delegate: anObject [

	"Type: FrameworkDelegate"

	self propertyAt: #delegate put: anObject
]

{ #category : #api }
IonAlert >> dismiss [

	"Dismiss the alert overlay after it has been presented.
	@param data Any data to emit in the dismiss events.
	@param role The role of the element that is dismissing the alert. This can be useful in a button handler for determining which button was clicked to dismiss the alert. Some examples include: '''cancel'', ''destructive'', 'selected'', and ''backdrop''.  This is a no-op if the overlay has not been presented yet. If you want to remove an overlay from the DOM that was never presented, use the [remove](https://developer.mozilla.org/en-US/docs/Web/API/Element/remove) method.
	
	Type: (data?: any, role?: string) => Promise<boolean>"

	^ self apply: #dismiss resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonAlert >> dismiss: data [

	"Dismiss the alert overlay after it has been presented.
	@param data Any data to emit in the dismiss events.
	@param role The role of the element that is dismissing the alert. This can be useful in a button handler for determining which button was clicked to dismiss the alert. Some examples include: '''cancel'', ''destructive'', 'selected'', and ''backdrop''.  This is a no-op if the overlay has not been presented yet. If you want to remove an overlay from the DOM that was never presented, use the [remove](https://developer.mozilla.org/en-US/docs/Web/API/Element/remove) method.
	
	Type: (data?: any, role?: string) => Promise<boolean>"

	^ self apply: #dismiss withArguments: { data } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonAlert >> dismiss: data role: role [

	"Dismiss the alert overlay after it has been presented.
	@param data Any data to emit in the dismiss events.
	@param role The role of the element that is dismissing the alert. This can be useful in a button handler for determining which button was clicked to dismiss the alert. Some examples include: '''cancel'', ''destructive'', 'selected'', and ''backdrop''.  This is a no-op if the overlay has not been presented yet. If you want to remove an overlay from the DOM that was never presented, use the [remove](https://developer.mozilla.org/en-US/docs/Web/API/Element/remove) method.
	
	Type: (data?: any, role?: string) => Promise<boolean>"

	^ self apply: #dismiss withArguments: { data . role } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonAlert >> enterAnimation [

	"Animation to use when the alert is presented.
	
	Type: AnimationBuilder"

	^ self propertyAt: #enterAnimation
]

{ #category : #api }
IonAlert >> enterAnimation: anObject [

	"Animation to use when the alert is presented.
	
	Type: AnimationBuilder"

	self propertyAt: #enterAnimation put: anObject
]

{ #category : #api }
IonAlert >> hasController [

	"Type: boolean"

	^ self propertyAt: #hasController
]

{ #category : #api }
IonAlert >> hasController: aBoolean [

	"Type: boolean"

	self propertyAt: #hasController put: aBoolean
]

{ #category : #api }
IonAlert >> header [

	"The main title in the heading of the alert.
	
	Type: string"

	^ self propertyAt: #header
]

{ #category : #api }
IonAlert >> header: aString [

	"The main title in the heading of the alert.
	
	Type: string"

	self propertyAt: #header put: aString
]

{ #category : #api }
IonAlert >> htmlAttributes [

	"Additional attributes to pass to the alert.
	
	Type: { [key: string]: any }"

	^ self propertyAt: #htmlAttributes
]

{ #category : #api }
IonAlert >> htmlAttributes: anObject [

	"Additional attributes to pass to the alert.
	
	Type: { [key: string]: any }"

	self propertyAt: #htmlAttributes put: anObject
]

{ #category : #api }
IonAlert >> inputs [

	"Array of input to show in the alert.
	
	Type: AlertInput[]"

	^ self propertyAt: #inputs
]

{ #category : #api }
IonAlert >> inputs: anObject [

	"Array of input to show in the alert.
	
	Type: AlertInput[]"

	self propertyAt: #inputs put: anObject
]

{ #category : #api }
IonAlert >> isOpen [

	"If 'true', the alert will open. If 'false', the alert will close. Use this if you need finer grained control over presentation, otherwise just use the alertController or the 'trigger' property. Note: 'isOpen' will not automatically be set back to 'false' when the alert dismisses. You will need to do that in your code.
	
	Type: boolean"

	^ self propertyAt: #isOpen
]

{ #category : #api }
IonAlert >> isOpen: aBoolean [

	"If 'true', the alert will open. If 'false', the alert will close. Use this if you need finer grained control over presentation, otherwise just use the alertController or the 'trigger' property. Note: 'isOpen' will not automatically be set back to 'false' when the alert dismisses. You will need to do that in your code.
	
	Type: boolean"

	self propertyAt: #isOpen put: aBoolean
]

{ #category : #api }
IonAlert >> keyboardClose [

	"If 'true', the keyboard will be automatically dismissed when the overlay is presented.
	
	Type: boolean"

	^ self propertyAt: #keyboardClose
]

{ #category : #api }
IonAlert >> keyboardClose: aBoolean [

	"If 'true', the keyboard will be automatically dismissed when the overlay is presented.
	
	Type: boolean"

	self propertyAt: #keyboardClose put: aBoolean
]

{ #category : #api }
IonAlert >> leaveAnimation [

	"Animation to use when the alert is dismissed.
	
	Type: AnimationBuilder"

	^ self propertyAt: #leaveAnimation
]

{ #category : #api }
IonAlert >> leaveAnimation: anObject [

	"Animation to use when the alert is dismissed.
	
	Type: AnimationBuilder"

	self propertyAt: #leaveAnimation put: anObject
]

{ #category : #api }
IonAlert >> message [

	"The main message to be displayed in the alert. 'message' can accept either plaintext or HTML as a string. To display characters normally reserved for HTML, they must be escaped. For example '<Ionic>' would become '&lt;Ionic&gt;'  For more information: [Security Documentation](https://ionicframework.com/docs/faq/security)  This property accepts custom HTML as a string. Content is parsed as plaintext by default. 'innerHTMLTemplatesEnabled' must be set to 'true' in the Ionic config before custom HTML can be used.
	
	Type: string | IonicSafeString"

	^ self propertyAt: #message
]

{ #category : #api }
IonAlert >> message: anObject [

	"The main message to be displayed in the alert. 'message' can accept either plaintext or HTML as a string. To display characters normally reserved for HTML, they must be escaped. For example '<Ionic>' would become '&lt;Ionic&gt;'  For more information: [Security Documentation](https://ionicframework.com/docs/faq/security)  This property accepts custom HTML as a string. Content is parsed as plaintext by default. 'innerHTMLTemplatesEnabled' must be set to 'true' in the Ionic config before custom HTML can be used.
	
	Type: string | IonicSafeString"

	self propertyAt: #message put: anObject
]

{ #category : #api }
IonAlert >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonAlert >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonAlert >> onDidDismiss [

	"Returns a promise that resolves when the alert did dismiss.
	
	Type: <T = any>() => Promise<OverlayEventDetail<T>>"

	^ self apply: #onDidDismiss resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonAlert >> onWillDismiss [

	"Returns a promise that resolves when the alert will dismiss.
	
	Type: <T = any>() => Promise<OverlayEventDetail<T>>"

	^ self apply: #onWillDismiss resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonAlert >> overlayIndex [

	"Type: number"

	^ self propertyAt: #overlayIndex
]

{ #category : #api }
IonAlert >> overlayIndex: aNumber [

	"Type: number"

	self propertyAt: #overlayIndex put: aNumber
]

{ #category : #api }
IonAlert >> present [

	"Present the alert overlay after it has been created.
	
	Type: Promise<void>"

	^ self apply: #present resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonAlert >> subHeader [

	"The subtitle in the heading of the alert. Displayed under the title.
	
	Type: string"

	^ self propertyAt: #subHeader
]

{ #category : #api }
IonAlert >> subHeader: aString [

	"The subtitle in the heading of the alert. Displayed under the title.
	
	Type: string"

	self propertyAt: #subHeader put: aString
]

{ #category : #api }
IonAlert >> translucent [

	"If 'true', the alert will be translucent. Only applies when the mode is ''ios'' and the device supports ['backdrop-filter'](https://developer.mozilla.org/en-US/docs/Web/CSS/backdrop-filter#Browser_compatibility).
	
	Type: boolean"

	^ self propertyAt: #translucent
]

{ #category : #api }
IonAlert >> translucent: aBoolean [

	"If 'true', the alert will be translucent. Only applies when the mode is ''ios'' and the device supports ['backdrop-filter'](https://developer.mozilla.org/en-US/docs/Web/CSS/backdrop-filter#Browser_compatibility).
	
	Type: boolean"

	self propertyAt: #translucent put: aBoolean
]

{ #category : #api }
IonAlert >> trigger [

	"An ID corresponding to the trigger element that causes the alert to open when clicked.
	
	Type: string | undefined"

	^ self propertyAt: #trigger
]

{ #category : #api }
IonAlert >> trigger: aString [

	"An ID corresponding to the trigger element that causes the alert to open when clicked.
	
	Type: string | undefined"

	self propertyAt: #trigger put: aString
]
