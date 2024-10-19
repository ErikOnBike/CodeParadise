Class {
	#name : #IonPopover,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonPopover >> alignment [

	"Describes how to align the popover content with the 'reference' point. Defaults to ''center'' for 'ios' mode, and ''start'' for 'md' mode.
	
	Type: PositionAlign"

	^ self propertyAt: #alignment
]

{ #category : #api }
IonPopover >> alignment: anObject [

	"Describes how to align the popover content with the 'reference' point. Defaults to ''center'' for 'ios' mode, and ''start'' for 'md' mode.
	
	Type: PositionAlign"

	self propertyAt: #alignment put: anObject
]

{ #category : #api }
IonPopover >> animated [

	"If 'true', the popover will animate.
	
	Type: boolean"

	^ self propertyAt: #animated
]

{ #category : #api }
IonPopover >> animated: aBoolean [

	"If 'true', the popover will animate.
	
	Type: boolean"

	self propertyAt: #animated put: aBoolean
]

{ #category : #api }
IonPopover >> arrow [

	"If 'true', the popover will display an arrow that points at the 'reference' when running in 'ios' mode. Does not apply in 'md' mode.
	
	Type: boolean"

	^ self propertyAt: #arrow
]

{ #category : #api }
IonPopover >> arrow: aBoolean [

	"If 'true', the popover will display an arrow that points at the 'reference' when running in 'ios' mode. Does not apply in 'md' mode.
	
	Type: boolean"

	self propertyAt: #arrow put: aBoolean
]

{ #category : #api }
IonPopover >> backdropDismiss [

	"If 'true', the popover will be dismissed when the backdrop is clicked.
	
	Type: boolean"

	^ self propertyAt: #backdropDismiss
]

{ #category : #api }
IonPopover >> backdropDismiss: aBoolean [

	"If 'true', the popover will be dismissed when the backdrop is clicked.
	
	Type: boolean"

	self propertyAt: #backdropDismiss put: aBoolean
]

{ #category : #api }
IonPopover >> component [

	"The component to display inside of the popover. You only need to use this if you are not using a JavaScript framework. Otherwise, you can just slot your component inside of 'ion-popover'.
	
	Type: ComponentRef"

	^ self propertyAt: #component
]

{ #category : #api }
IonPopover >> component: anObject [

	"The component to display inside of the popover. You only need to use this if you are not using a JavaScript framework. Otherwise, you can just slot your component inside of 'ion-popover'.
	
	Type: ComponentRef"

	self propertyAt: #component put: anObject
]

{ #category : #api }
IonPopover >> componentProps [

	"The data to pass to the popover component. You only need to use this if you are not using a JavaScript framework. Otherwise, you can just set the props directly on your component.
	
	Type: ComponentProps"

	^ self propertyAt: #componentProps
]

{ #category : #api }
IonPopover >> componentProps: anObject [

	"The data to pass to the popover component. You only need to use this if you are not using a JavaScript framework. Otherwise, you can just set the props directly on your component.
	
	Type: ComponentProps"

	self propertyAt: #componentProps put: anObject
]

{ #category : #api }
IonPopover >> cssClass [

	"Additional classes to apply for custom CSS. If multiple classes are provided they should be separated by spaces.
	
	Type: string | string[]"

	^ self propertyAt: #cssClass
]

{ #category : #api }
IonPopover >> cssClass: anObject [

	"Additional classes to apply for custom CSS. If multiple classes are provided they should be separated by spaces.
	
	Type: string | string[]"

	self propertyAt: #cssClass put: anObject
]

{ #category : #api }
IonPopover >> delegate [

	"Type: FrameworkDelegate"

	^ self propertyAt: #delegate
]

{ #category : #api }
IonPopover >> delegate: anObject [

	"Type: FrameworkDelegate"

	self propertyAt: #delegate put: anObject
]

{ #category : #api }
IonPopover >> dismiss [

	"Dismiss the popover overlay after it has been presented.
	@param data Any data to emit in the dismiss events.
	@param role The role of the element that is dismissing the popover. For example, 'cancel' or 'backdrop'.
	@param dismissParentPopover If 'true', dismissing this popover will also dismiss a parent popover if this popover is nested. Defaults to 'true'.  This is a no-op if the overlay has not been presented yet. If you want to remove an overlay from the DOM that was never presented, use the [remove](https://developer.mozilla.org/en-US/docs/Web/API/Element/remove) method.
	
	Type: (data?: any, role?: string, dismissParentPopover?: boolean) => Promise<boolean>"

	^ self apply: #dismiss resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonPopover >> dismiss: data [

	"Dismiss the popover overlay after it has been presented.
	@param data Any data to emit in the dismiss events.
	@param role The role of the element that is dismissing the popover. For example, 'cancel' or 'backdrop'.
	@param dismissParentPopover If 'true', dismissing this popover will also dismiss a parent popover if this popover is nested. Defaults to 'true'.  This is a no-op if the overlay has not been presented yet. If you want to remove an overlay from the DOM that was never presented, use the [remove](https://developer.mozilla.org/en-US/docs/Web/API/Element/remove) method.
	
	Type: (data?: any, role?: string, dismissParentPopover?: boolean) => Promise<boolean>"

	^ self apply: #dismiss withArguments: { data } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonPopover >> dismiss: data role: role [

	"Dismiss the popover overlay after it has been presented.
	@param data Any data to emit in the dismiss events.
	@param role The role of the element that is dismissing the popover. For example, 'cancel' or 'backdrop'.
	@param dismissParentPopover If 'true', dismissing this popover will also dismiss a parent popover if this popover is nested. Defaults to 'true'.  This is a no-op if the overlay has not been presented yet. If you want to remove an overlay from the DOM that was never presented, use the [remove](https://developer.mozilla.org/en-US/docs/Web/API/Element/remove) method.
	
	Type: (data?: any, role?: string, dismissParentPopover?: boolean) => Promise<boolean>"

	^ self apply: #dismiss withArguments: { data . role } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonPopover >> dismiss: data role: role dismissParentPopover: dismissParentPopover [

	"Dismiss the popover overlay after it has been presented.
	@param data Any data to emit in the dismiss events.
	@param role The role of the element that is dismissing the popover. For example, 'cancel' or 'backdrop'.
	@param dismissParentPopover If 'true', dismissing this popover will also dismiss a parent popover if this popover is nested. Defaults to 'true'.  This is a no-op if the overlay has not been presented yet. If you want to remove an overlay from the DOM that was never presented, use the [remove](https://developer.mozilla.org/en-US/docs/Web/API/Element/remove) method.
	
	Type: (data?: any, role?: string, dismissParentPopover?: boolean) => Promise<boolean>"

	^ self apply: #dismiss withArguments: { data . role . dismissParentPopover } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonPopover >> dismissOnSelect [

	"If 'true', the popover will be automatically dismissed when the content has been clicked.
	
	Type: boolean"

	^ self propertyAt: #dismissOnSelect
]

{ #category : #api }
IonPopover >> dismissOnSelect: aBoolean [

	"If 'true', the popover will be automatically dismissed when the content has been clicked.
	
	Type: boolean"

	self propertyAt: #dismissOnSelect put: aBoolean
]

{ #category : #api }
IonPopover >> enterAnimation [

	"Animation to use when the popover is presented.
	
	Type: AnimationBuilder"

	^ self propertyAt: #enterAnimation
]

{ #category : #api }
IonPopover >> enterAnimation: anObject [

	"Animation to use when the popover is presented.
	
	Type: AnimationBuilder"

	self propertyAt: #enterAnimation put: anObject
]

{ #category : #api }
IonPopover >> event [

	"The event to pass to the popover animation.
	
	Type: any"

	^ self propertyAt: #event
]

{ #category : #api }
IonPopover >> event: anObject [

	"The event to pass to the popover animation.
	
	Type: any"

	self propertyAt: #event put: anObject
]

{ #category : #api }
IonPopover >> focusTrap [

	"If 'true', focus will not be allowed to move outside of this overlay. If 'false', focus will be allowed to move outside of the overlay.  In most scenarios this property should remain set to 'true'. Setting this property to 'false' can cause severe accessibility issues as users relying on assistive technologies may be able to move focus into a confusing state. We recommend only setting this to 'false' when absolutely necessary.  Developers may want to consider disabling focus trapping if this overlay presents a non-Ionic overlay from a 3rd party library. Developers would disable focus trapping on the Ionic overlay when presenting the 3rd party overlay and then re-enable focus trapping when dismissing the 3rd party overlay and moving focus back to the Ionic overlay.
	
	Type: boolean"

	^ self propertyAt: #focusTrap
]

{ #category : #api }
IonPopover >> focusTrap: aBoolean [

	"If 'true', focus will not be allowed to move outside of this overlay. If 'false', focus will be allowed to move outside of the overlay.  In most scenarios this property should remain set to 'true'. Setting this property to 'false' can cause severe accessibility issues as users relying on assistive technologies may be able to move focus into a confusing state. We recommend only setting this to 'false' when absolutely necessary.  Developers may want to consider disabling focus trapping if this overlay presents a non-Ionic overlay from a 3rd party library. Developers would disable focus trapping on the Ionic overlay when presenting the 3rd party overlay and then re-enable focus trapping when dismissing the 3rd party overlay and moving focus back to the Ionic overlay.
	
	Type: boolean"

	self propertyAt: #focusTrap put: aBoolean
]

{ #category : #api }
IonPopover >> getParentPopover [

	"Type: Promise<HTMLIonPopoverElement | null>"

	^ self apply: #getParentPopover resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonPopover >> hasController [

	"Type: boolean"

	^ self propertyAt: #hasController
]

{ #category : #api }
IonPopover >> hasController: aBoolean [

	"Type: boolean"

	self propertyAt: #hasController put: aBoolean
]

{ #category : #api }
IonPopover >> htmlAttributes [

	"Additional attributes to pass to the popover.
	
	Type: { [key: string]: any }"

	^ self propertyAt: #htmlAttributes
]

{ #category : #api }
IonPopover >> htmlAttributes: anObject [

	"Additional attributes to pass to the popover.
	
	Type: { [key: string]: any }"

	self propertyAt: #htmlAttributes put: anObject
]

{ #category : #api }
IonPopover >> isOpen [

	"If 'true', the popover will open. If 'false', the popover will close. Use this if you need finer grained control over presentation, otherwise just use the popoverController or the 'trigger' property. Note: 'isOpen' will not automatically be set back to 'false' when the popover dismisses. You will need to do that in your code.
	
	Type: boolean"

	^ self propertyAt: #isOpen
]

{ #category : #api }
IonPopover >> isOpen: aBoolean [

	"If 'true', the popover will open. If 'false', the popover will close. Use this if you need finer grained control over presentation, otherwise just use the popoverController or the 'trigger' property. Note: 'isOpen' will not automatically be set back to 'false' when the popover dismisses. You will need to do that in your code.
	
	Type: boolean"

	self propertyAt: #isOpen put: aBoolean
]

{ #category : #api }
IonPopover >> keepContentsMounted [

	"If 'true', the component passed into 'ion-popover' will automatically be mounted when the popover is created. The component will remain mounted even when the popover is dismissed. However, the component will be destroyed when the popover is destroyed. This property is not reactive and should only be used when initially creating a popover.  Note: This feature only applies to inline popovers in JavaScript frameworks such as Angular, React, and Vue.
	
	Type: boolean"

	^ self propertyAt: #keepContentsMounted
]

{ #category : #api }
IonPopover >> keepContentsMounted: aBoolean [

	"If 'true', the component passed into 'ion-popover' will automatically be mounted when the popover is created. The component will remain mounted even when the popover is dismissed. However, the component will be destroyed when the popover is destroyed. This property is not reactive and should only be used when initially creating a popover.  Note: This feature only applies to inline popovers in JavaScript frameworks such as Angular, React, and Vue.
	
	Type: boolean"

	self propertyAt: #keepContentsMounted put: aBoolean
]

{ #category : #api }
IonPopover >> keyboardClose [

	"If 'true', the keyboard will be automatically dismissed when the overlay is presented.
	
	Type: boolean"

	^ self propertyAt: #keyboardClose
]

{ #category : #api }
IonPopover >> keyboardClose: aBoolean [

	"If 'true', the keyboard will be automatically dismissed when the overlay is presented.
	
	Type: boolean"

	self propertyAt: #keyboardClose put: aBoolean
]

{ #category : #api }
IonPopover >> keyboardEvents [

	"Type: boolean"

	^ self propertyAt: #keyboardEvents
]

{ #category : #api }
IonPopover >> keyboardEvents: aBoolean [

	"Type: boolean"

	self propertyAt: #keyboardEvents put: aBoolean
]

{ #category : #api }
IonPopover >> leaveAnimation [

	"Animation to use when the popover is dismissed.
	
	Type: AnimationBuilder"

	^ self propertyAt: #leaveAnimation
]

{ #category : #api }
IonPopover >> leaveAnimation: anObject [

	"Animation to use when the popover is dismissed.
	
	Type: AnimationBuilder"

	self propertyAt: #leaveAnimation put: anObject
]

{ #category : #api }
IonPopover >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonPopover >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonPopover >> onDidDismiss [

	"Returns a promise that resolves when the popover did dismiss.
	
	Type: <T = any>() => Promise<OverlayEventDetail<T>>"

	^ self apply: #onDidDismiss resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonPopover >> onWillDismiss [

	"Returns a promise that resolves when the popover will dismiss.
	
	Type: <T = any>() => Promise<OverlayEventDetail<T>>"

	^ self apply: #onWillDismiss resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonPopover >> overlayIndex [

	"Type: number"

	^ self propertyAt: #overlayIndex
]

{ #category : #api }
IonPopover >> overlayIndex: aNumber [

	"Type: number"

	self propertyAt: #overlayIndex put: aNumber
]

{ #category : #api }
IonPopover >> present [

	"Present the popover overlay after it has been created. Developers can pass a mouse, touch, or pointer event to position the popover relative to where that event was dispatched.
	
	Type: (event?: MouseEvent | TouchEvent | PointerEvent | CustomEvent) => Promise<void>"

	^ self apply: #present resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonPopover >> present: event [

	"Present the popover overlay after it has been created. Developers can pass a mouse, touch, or pointer event to position the popover relative to where that event was dispatched.
	
	Type: (event?: MouseEvent | TouchEvent | PointerEvent | CustomEvent) => Promise<void>"

	^ self apply: #present withArguments: { event } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonPopover >> presentFromTrigger [

	"When opening a popover from a trigger, we should not be modifying the 'event' prop from inside the component. Additionally, when pressing the 'Right' arrow key, we need to shift focus to the first descendant in the newly presented popover.
	
	Type: (event?: any, focusDescendant?: boolean) => Promise<void>"

	^ self apply: #presentFromTrigger resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonPopover >> presentFromTrigger: event [

	"When opening a popover from a trigger, we should not be modifying the 'event' prop from inside the component. Additionally, when pressing the 'Right' arrow key, we need to shift focus to the first descendant in the newly presented popover.
	
	Type: (event?: any, focusDescendant?: boolean) => Promise<void>"

	^ self apply: #presentFromTrigger withArguments: { event } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonPopover >> presentFromTrigger: event focusDescendant: focusDescendant [

	"When opening a popover from a trigger, we should not be modifying the 'event' prop from inside the component. Additionally, when pressing the 'Right' arrow key, we need to shift focus to the first descendant in the newly presented popover.
	
	Type: (event?: any, focusDescendant?: boolean) => Promise<void>"

	^ self apply: #presentFromTrigger withArguments: { event . focusDescendant } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonPopover >> reference [

	"Describes what to position the popover relative to. If ''trigger'', the popover will be positioned relative to the trigger button. If passing in an event, this is determined via event.target. If ''event'', the popover will be positioned relative to the x/y coordinates of the trigger action. If passing in an event, this is determined via event.clientX and event.clientY.
	
	Type: PositionReference"

	^ self propertyAt: #reference
]

{ #category : #api }
IonPopover >> reference: anObject [

	"Describes what to position the popover relative to. If ''trigger'', the popover will be positioned relative to the trigger button. If passing in an event, this is determined via event.target. If ''event'', the popover will be positioned relative to the x/y coordinates of the trigger action. If passing in an event, this is determined via event.clientX and event.clientY.
	
	Type: PositionReference"

	self propertyAt: #reference put: anObject
]

{ #category : #api }
IonPopover >> showBackdrop [

	"If 'true', a backdrop will be displayed behind the popover. This property controls whether or not the backdrop darkens the screen when the popover is presented. It does not control whether or not the backdrop is active or present in the DOM.
	
	Type: boolean"

	^ self propertyAt: #showBackdrop
]

{ #category : #api }
IonPopover >> showBackdrop: aBoolean [

	"If 'true', a backdrop will be displayed behind the popover. This property controls whether or not the backdrop darkens the screen when the popover is presented. It does not control whether or not the backdrop is active or present in the DOM.
	
	Type: boolean"

	self propertyAt: #showBackdrop put: aBoolean
]

{ #category : #api }
IonPopover >> side [

	"Describes which side of the 'reference' point to position the popover on. The ''start'' and ''end'' values are RTL-aware, and the ''left'' and ''right'' values are not.
	
	Type: PositionSide"

	^ self propertyAt: #side
]

{ #category : #api }
IonPopover >> side: anObject [

	"Describes which side of the 'reference' point to position the popover on. The ''start'' and ''end'' values are RTL-aware, and the ''left'' and ''right'' values are not.
	
	Type: PositionSide"

	self propertyAt: #side put: anObject
]

{ #category : #api }
IonPopover >> size [

	"Describes how to calculate the popover width. If ''cover'', the popover width will match the width of the trigger. If ''auto'', the popover width will be set to a static default value.
	
	Type: PopoverSize"

	^ self propertyAt: #size
]

{ #category : #api }
IonPopover >> size: anObject [

	"Describes how to calculate the popover width. If ''cover'', the popover width will match the width of the trigger. If ''auto'', the popover width will be set to a static default value.
	
	Type: PopoverSize"

	self propertyAt: #size put: anObject
]

{ #category : #api }
IonPopover >> translucent [

	"If 'true', the popover will be translucent. Only applies when the mode is ''ios'' and the device supports ['backdrop-filter'](https://developer.mozilla.org/en-US/docs/Web/CSS/backdrop-filter#Browser_compatibility).
	
	Type: boolean"

	^ self propertyAt: #translucent
]

{ #category : #api }
IonPopover >> translucent: aBoolean [

	"If 'true', the popover will be translucent. Only applies when the mode is ''ios'' and the device supports ['backdrop-filter'](https://developer.mozilla.org/en-US/docs/Web/CSS/backdrop-filter#Browser_compatibility).
	
	Type: boolean"

	self propertyAt: #translucent put: aBoolean
]

{ #category : #api }
IonPopover >> trigger [

	"An ID corresponding to the trigger element that causes the popover to open. Use the 'trigger-action' property to customize the interaction that results in the popover opening.
	
	Type: string | undefined"

	^ self propertyAt: #trigger
]

{ #category : #api }
IonPopover >> trigger: aString [

	"An ID corresponding to the trigger element that causes the popover to open. Use the 'trigger-action' property to customize the interaction that results in the popover opening.
	
	Type: string | undefined"

	self propertyAt: #trigger put: aString
]

{ #category : #api }
IonPopover >> triggerAction [

	"Describes what kind of interaction with the trigger that should cause the popover to open. Does not apply when the 'trigger' property is 'undefined'. If ''click'', the popover will be presented when the trigger is left clicked. If ''hover'', the popover will be presented when a pointer hovers over the trigger. If ''context-menu'', the popover will be presented when the trigger is right clicked on desktop and long pressed on mobile. This will also prevent your device's normal context menu from appearing.
	
	Type: TriggerAction"

	^ self propertyAt: #triggerAction
]

{ #category : #api }
IonPopover >> triggerAction: anObject [

	"Describes what kind of interaction with the trigger that should cause the popover to open. Does not apply when the 'trigger' property is 'undefined'. If ''click'', the popover will be presented when the trigger is left clicked. If ''hover'', the popover will be presented when a pointer hovers over the trigger. If ''context-menu'', the popover will be presented when the trigger is right clicked on desktop and long pressed on mobile. This will also prevent your device's normal context menu from appearing.
	
	Type: TriggerAction"

	self propertyAt: #triggerAction put: anObject
]
