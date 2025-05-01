Class {
	#name : #IonModal,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonModal >> animated [

	"If 'true', the modal will animate.
	
	Type: boolean"

	^ self propertyAt: #animated
]

{ #category : #api }
IonModal >> animated: aBoolean [

	"If 'true', the modal will animate.
	
	Type: boolean"

	self propertyAt: #animated put: aBoolean
]

{ #category : #api }
IonModal >> backdropBreakpoint [

	"A decimal value between 0 and 1 that indicates the point after which the backdrop will begin to fade in when using a sheet modal. Prior to this point, the backdrop will be hidden and the content underneath the sheet can be interacted with. This value is exclusive meaning the backdrop will become active after the value specified.
	
	Type: number"

	^ self propertyAt: #backdropBreakpoint
]

{ #category : #api }
IonModal >> backdropBreakpoint: aNumber [

	"A decimal value between 0 and 1 that indicates the point after which the backdrop will begin to fade in when using a sheet modal. Prior to this point, the backdrop will be hidden and the content underneath the sheet can be interacted with. This value is exclusive meaning the backdrop will become active after the value specified.
	
	Type: number"

	self propertyAt: #backdropBreakpoint put: aNumber
]

{ #category : #api }
IonModal >> backdropDismiss [

	"If 'true', the modal will be dismissed when the backdrop is clicked.
	
	Type: boolean"

	^ self propertyAt: #backdropDismiss
]

{ #category : #api }
IonModal >> backdropDismiss: aBoolean [

	"If 'true', the modal will be dismissed when the backdrop is clicked.
	
	Type: boolean"

	self propertyAt: #backdropDismiss put: aBoolean
]

{ #category : #api }
IonModal >> breakpoints [

	"The breakpoints to use when creating a sheet modal. Each value in the array must be a decimal between 0 and 1 where 0 indicates the modal is fully closed and 1 indicates the modal is fully open. Values are relative to the height of the modal, not the height of the screen. One of the values in this array must be the value of the 'initialBreakpoint' property. For example: [0, .25, .5, 1]
	
	Type: number[]"

	^ self propertyAt: #breakpoints
]

{ #category : #api }
IonModal >> breakpoints: anObject [

	"The breakpoints to use when creating a sheet modal. Each value in the array must be a decimal between 0 and 1 where 0 indicates the modal is fully closed and 1 indicates the modal is fully open. Values are relative to the height of the modal, not the height of the screen. One of the values in this array must be the value of the 'initialBreakpoint' property. For example: [0, .25, .5, 1]
	
	Type: number[]"

	self propertyAt: #breakpoints put: anObject
]

{ #category : #api }
IonModal >> canDismiss [

	"Determines whether or not a modal can dismiss when calling the 'dismiss' method.  If the value is 'true' or the value's function returns 'true', the modal will close when trying to dismiss. If the value is 'false' or the value's function returns 'false', the modal will not close when trying to dismiss.  See https://ionicframework.com/docs/troubleshooting/runtime#accessing-this if you need to access 'this' from within the callback.
	
	Type: boolean | ((data?: any, role?: string) => Promise<boolean>)"

	^ self propertyAt: #canDismiss
]

{ #category : #api }
IonModal >> canDismiss: aPromise [

	"Determines whether or not a modal can dismiss when calling the 'dismiss' method.  If the value is 'true' or the value's function returns 'true', the modal will close when trying to dismiss. If the value is 'false' or the value's function returns 'false', the modal will not close when trying to dismiss.  See https://ionicframework.com/docs/troubleshooting/runtime#accessing-this if you need to access 'this' from within the callback.
	
	Type: boolean | ((data?: any, role?: string) => Promise<boolean>)"

	self propertyAt: #canDismiss put: aPromise
]

{ #category : #api }
IonModal >> component [

	"The component to display inside of the modal.
	
	Type: ComponentRef"

	^ self propertyAt: #component
]

{ #category : #api }
IonModal >> component: anObject [

	"The component to display inside of the modal.
	
	Type: ComponentRef"

	self propertyAt: #component put: anObject
]

{ #category : #api }
IonModal >> componentProps [

	"The data to pass to the modal component.
	
	Type: ComponentProps"

	^ self propertyAt: #componentProps
]

{ #category : #api }
IonModal >> componentProps: anObject [

	"The data to pass to the modal component.
	
	Type: ComponentProps"

	self propertyAt: #componentProps put: anObject
]

{ #category : #api }
IonModal >> cssClass [

	"Additional classes to apply for custom CSS. If multiple classes are provided they should be separated by spaces.
	
	Type: string | string[]"

	^ self propertyAt: #cssClass
]

{ #category : #api }
IonModal >> cssClass: anObject [

	"Additional classes to apply for custom CSS. If multiple classes are provided they should be separated by spaces.
	
	Type: string | string[]"

	self propertyAt: #cssClass put: anObject
]

{ #category : #api }
IonModal >> delegate [

	"Type: FrameworkDelegate"

	^ self propertyAt: #delegate
]

{ #category : #api }
IonModal >> delegate: anObject [

	"Type: FrameworkDelegate"

	self propertyAt: #delegate put: anObject
]

{ #category : #api }
IonModal >> dismiss [

	"Dismiss the modal overlay after it has been presented.
	@param data Any data to emit in the dismiss events.
	@param role The role of the element that is dismissing the modal. For example, 'cancel' or 'backdrop'.  This is a no-op if the overlay has not been presented yet. If you want to remove an overlay from the DOM that was never presented, use the [remove](https://developer.mozilla.org/en-US/docs/Web/API/Element/remove) method.
	
	Type: (data?: any, role?: string) => Promise<boolean>"

	^ self apply: #dismiss resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonModal >> dismiss: data [

	"Dismiss the modal overlay after it has been presented.
	@param data Any data to emit in the dismiss events.
	@param role The role of the element that is dismissing the modal. For example, 'cancel' or 'backdrop'.  This is a no-op if the overlay has not been presented yet. If you want to remove an overlay from the DOM that was never presented, use the [remove](https://developer.mozilla.org/en-US/docs/Web/API/Element/remove) method.
	
	Type: (data?: any, role?: string) => Promise<boolean>"

	^ self apply: #dismiss withArguments: { data } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonModal >> dismiss: data role: role [

	"Dismiss the modal overlay after it has been presented.
	@param data Any data to emit in the dismiss events.
	@param role The role of the element that is dismissing the modal. For example, 'cancel' or 'backdrop'.  This is a no-op if the overlay has not been presented yet. If you want to remove an overlay from the DOM that was never presented, use the [remove](https://developer.mozilla.org/en-US/docs/Web/API/Element/remove) method.
	
	Type: (data?: any, role?: string) => Promise<boolean>"

	^ self apply: #dismiss withArguments: { data . role } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonModal >> enterAnimation [

	"Animation to use when the modal is presented.
	
	Type: AnimationBuilder"

	^ self propertyAt: #enterAnimation
]

{ #category : #api }
IonModal >> enterAnimation: anObject [

	"Animation to use when the modal is presented.
	
	Type: AnimationBuilder"

	self propertyAt: #enterAnimation put: anObject
]

{ #category : #api }
IonModal >> expandToScroll [

	"Controls whether scrolling or dragging within the sheet modal expands it to a larger breakpoint. This only takes effect when 'breakpoints' and 'initialBreakpoint' are set.  If 'true', scrolling or dragging anywhere in the modal will first expand it to the next breakpoint. Once fully expanded, scrolling will affect the content. If 'false', scrolling will always affect the content. The modal will only expand when dragging the header or handle. The modal will close when dragging the header or handle. It can also be closed when dragging the content, but only if the content is scrolled to the top.
	
	Type: boolean"

	^ self propertyAt: #expandToScroll
]

{ #category : #api }
IonModal >> expandToScroll: aBoolean [

	"Controls whether scrolling or dragging within the sheet modal expands it to a larger breakpoint. This only takes effect when 'breakpoints' and 'initialBreakpoint' are set.  If 'true', scrolling or dragging anywhere in the modal will first expand it to the next breakpoint. Once fully expanded, scrolling will affect the content. If 'false', scrolling will always affect the content. The modal will only expand when dragging the header or handle. The modal will close when dragging the header or handle. It can also be closed when dragging the content, but only if the content is scrolled to the top.
	
	Type: boolean"

	self propertyAt: #expandToScroll put: aBoolean
]

{ #category : #api }
IonModal >> focusTrap [

	"If 'true', focus will not be allowed to move outside of this overlay. If 'false', focus will be allowed to move outside of the overlay.  In most scenarios this property should remain set to 'true'. Setting this property to 'false' can cause severe accessibility issues as users relying on assistive technologies may be able to move focus into a confusing state. We recommend only setting this to 'false' when absolutely necessary.  Developers may want to consider disabling focus trapping if this overlay presents a non-Ionic overlay from a 3rd party library. Developers would disable focus trapping on the Ionic overlay when presenting the 3rd party overlay and then re-enable focus trapping when dismissing the 3rd party overlay and moving focus back to the Ionic overlay.
	
	Type: boolean"

	^ self propertyAt: #focusTrap
]

{ #category : #api }
IonModal >> focusTrap: aBoolean [

	"If 'true', focus will not be allowed to move outside of this overlay. If 'false', focus will be allowed to move outside of the overlay.  In most scenarios this property should remain set to 'true'. Setting this property to 'false' can cause severe accessibility issues as users relying on assistive technologies may be able to move focus into a confusing state. We recommend only setting this to 'false' when absolutely necessary.  Developers may want to consider disabling focus trapping if this overlay presents a non-Ionic overlay from a 3rd party library. Developers would disable focus trapping on the Ionic overlay when presenting the 3rd party overlay and then re-enable focus trapping when dismissing the 3rd party overlay and moving focus back to the Ionic overlay.
	
	Type: boolean"

	self propertyAt: #focusTrap put: aBoolean
]

{ #category : #api }
IonModal >> getCurrentBreakpoint [

	"Returns the current breakpoint of a sheet style modal
	
	Type: Promise<number | undefined>"

	^ self apply: #getCurrentBreakpoint resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonModal >> handle [

	"The horizontal line that displays at the top of a sheet modal. It is 'true' by default when setting the 'breakpoints' and 'initialBreakpoint' properties.
	
	Type: boolean"

	^ self propertyAt: #handle
]

{ #category : #api }
IonModal >> handle: aBoolean [

	"The horizontal line that displays at the top of a sheet modal. It is 'true' by default when setting the 'breakpoints' and 'initialBreakpoint' properties.
	
	Type: boolean"

	self propertyAt: #handle put: aBoolean
]

{ #category : #api }
IonModal >> handleBehavior [

	"The interaction behavior for the sheet modal when the handle is pressed.  Defaults to ''none'', which  means the modal will not change size or position when the handle is pressed. Set to ''cycle'' to let the modal cycle between available breakpoints when pressed.  Handle behavior is unavailable when the 'handle' property is set to 'false' or when the 'breakpoints' property is not set (using a fullscreen or card modal).
	
	Type: ModalHandleBehavior"

	^ self propertyAt: #handleBehavior
]

{ #category : #api }
IonModal >> handleBehavior: anObject [

	"The interaction behavior for the sheet modal when the handle is pressed.  Defaults to ''none'', which  means the modal will not change size or position when the handle is pressed. Set to ''cycle'' to let the modal cycle between available breakpoints when pressed.  Handle behavior is unavailable when the 'handle' property is set to 'false' or when the 'breakpoints' property is not set (using a fullscreen or card modal).
	
	Type: ModalHandleBehavior"

	self propertyAt: #handleBehavior put: anObject
]

{ #category : #api }
IonModal >> hasController [

	"Type: boolean"

	^ self propertyAt: #hasController
]

{ #category : #api }
IonModal >> hasController: aBoolean [

	"Type: boolean"

	self propertyAt: #hasController put: aBoolean
]

{ #category : #api }
IonModal >> htmlAttributes [

	"Additional attributes to pass to the modal.
	
	Type: { [key: string]: any }"

	^ self propertyAt: #htmlAttributes
]

{ #category : #api }
IonModal >> htmlAttributes: anObject [

	"Additional attributes to pass to the modal.
	
	Type: { [key: string]: any }"

	self propertyAt: #htmlAttributes put: anObject
]

{ #category : #api }
IonModal >> initialBreakpoint [

	"A decimal value between 0 and 1 that indicates the initial point the modal will open at when creating a sheet modal. This value must also be listed in the 'breakpoints' array.
	
	Type: number"

	^ self propertyAt: #initialBreakpoint
]

{ #category : #api }
IonModal >> initialBreakpoint: aNumber [

	"A decimal value between 0 and 1 that indicates the initial point the modal will open at when creating a sheet modal. This value must also be listed in the 'breakpoints' array.
	
	Type: number"

	self propertyAt: #initialBreakpoint put: aNumber
]

{ #category : #api }
IonModal >> isOpen [

	"If 'true', the modal will open. If 'false', the modal will close. Use this if you need finer grained control over presentation, otherwise just use the modalController or the 'trigger' property. Note: 'isOpen' will not automatically be set back to 'false' when the modal dismisses. You will need to do that in your code.
	
	Type: boolean"

	^ self propertyAt: #isOpen
]

{ #category : #api }
IonModal >> isOpen: aBoolean [

	"If 'true', the modal will open. If 'false', the modal will close. Use this if you need finer grained control over presentation, otherwise just use the modalController or the 'trigger' property. Note: 'isOpen' will not automatically be set back to 'false' when the modal dismisses. You will need to do that in your code.
	
	Type: boolean"

	self propertyAt: #isOpen put: aBoolean
]

{ #category : #api }
IonModal >> keepContentsMounted [

	"If 'true', the component passed into 'ion-modal' will automatically be mounted when the modal is created. The component will remain mounted even when the modal is dismissed. However, the component will be destroyed when the modal is destroyed. This property is not reactive and should only be used when initially creating a modal.  Note: This feature only applies to inline modals in JavaScript frameworks such as Angular, React, and Vue.
	
	Type: boolean"

	^ self propertyAt: #keepContentsMounted
]

{ #category : #api }
IonModal >> keepContentsMounted: aBoolean [

	"If 'true', the component passed into 'ion-modal' will automatically be mounted when the modal is created. The component will remain mounted even when the modal is dismissed. However, the component will be destroyed when the modal is destroyed. This property is not reactive and should only be used when initially creating a modal.  Note: This feature only applies to inline modals in JavaScript frameworks such as Angular, React, and Vue.
	
	Type: boolean"

	self propertyAt: #keepContentsMounted put: aBoolean
]

{ #category : #api }
IonModal >> keyboardClose [

	"If 'true', the keyboard will be automatically dismissed when the overlay is presented.
	
	Type: boolean"

	^ self propertyAt: #keyboardClose
]

{ #category : #api }
IonModal >> keyboardClose: aBoolean [

	"If 'true', the keyboard will be automatically dismissed when the overlay is presented.
	
	Type: boolean"

	self propertyAt: #keyboardClose put: aBoolean
]

{ #category : #api }
IonModal >> leaveAnimation [

	"Animation to use when the modal is dismissed.
	
	Type: AnimationBuilder"

	^ self propertyAt: #leaveAnimation
]

{ #category : #api }
IonModal >> leaveAnimation: anObject [

	"Animation to use when the modal is dismissed.
	
	Type: AnimationBuilder"

	self propertyAt: #leaveAnimation put: anObject
]

{ #category : #api }
IonModal >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonModal >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonModal >> onDidDismiss [

	"Returns a promise that resolves when the modal did dismiss.
	
	Type: <T = any>() => Promise<OverlayEventDetail<T>>"

	^ self apply: #onDidDismiss resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonModal >> onWillDismiss [

	"Returns a promise that resolves when the modal will dismiss.
	
	Type: <T = any>() => Promise<OverlayEventDetail<T>>"

	^ self apply: #onWillDismiss resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonModal >> overlayIndex [

	"Type: number"

	^ self propertyAt: #overlayIndex
]

{ #category : #api }
IonModal >> overlayIndex: aNumber [

	"Type: number"

	self propertyAt: #overlayIndex put: aNumber
]

{ #category : #api }
IonModal >> present [

	"Present the modal overlay after it has been created.
	
	Type: Promise<void>"

	^ self apply: #present resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonModal >> presentingElement [

	"The element that presented the modal. This is used for card presentation effects and for stacking multiple modals on top of each other. Only applies in iOS mode.
	
	Type: HTMLElement"

	^ self propertyAt: #presentingElement
]

{ #category : #api }
IonModal >> presentingElement: anObject [

	"The element that presented the modal. This is used for card presentation effects and for stacking multiple modals on top of each other. Only applies in iOS mode.
	
	Type: HTMLElement"

	self propertyAt: #presentingElement put: anObject
]

{ #category : #api }
IonModal >> setCurrentBreakpoint: breakpoint [

	"Move a sheet style modal to a specific breakpoint. The breakpoint value must be a value defined in your 'breakpoints' array.
	
	Type: (breakpoint: number) => Promise<void>"

	^ self apply: #setCurrentBreakpoint withArguments: { breakpoint } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonModal >> showBackdrop [

	"If 'true', a backdrop will be displayed behind the modal. This property controls whether or not the backdrop darkens the screen when the modal is presented. It does not control whether or not the backdrop is active or present in the DOM.
	
	Type: boolean"

	^ self propertyAt: #showBackdrop
]

{ #category : #api }
IonModal >> showBackdrop: aBoolean [

	"If 'true', a backdrop will be displayed behind the modal. This property controls whether or not the backdrop darkens the screen when the modal is presented. It does not control whether or not the backdrop is active or present in the DOM.
	
	Type: boolean"

	self propertyAt: #showBackdrop put: aBoolean
]

{ #category : #api }
IonModal >> trigger [

	"An ID corresponding to the trigger element that causes the modal to open when clicked.
	
	Type: string | undefined"

	^ self propertyAt: #trigger
]

{ #category : #api }
IonModal >> trigger: aString [

	"An ID corresponding to the trigger element that causes the modal to open when clicked.
	
	Type: string | undefined"

	self propertyAt: #trigger put: aString
]
