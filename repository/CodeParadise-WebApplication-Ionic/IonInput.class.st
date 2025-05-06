Class {
	#name : #IonInput,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonInput >> autocapitalize [

	"Indicates whether and how the text value should be automatically capitalized as it is entered/edited by the user. Available options: ''off'', ''none'', ''on'', ''sentences'', ''words'', ''characters''.
	
	Type: string"

	^ self propertyAt: #autocapitalize
]

{ #category : #api }
IonInput >> autocapitalize: aString [

	"Indicates whether and how the text value should be automatically capitalized as it is entered/edited by the user. Available options: ''off'', ''none'', ''on'', ''sentences'', ''words'', ''characters''.
	
	Type: string"

	self propertyAt: #autocapitalize put: aString
]

{ #category : #api }
IonInput >> autocomplete [

	"Indicates whether the value of the control can be automatically completed by the browser.
	
	Type: AutocompleteTypes"

	^ self propertyAt: #autocomplete
]

{ #category : #api }
IonInput >> autocomplete: anObject [

	"Indicates whether the value of the control can be automatically completed by the browser.
	
	Type: AutocompleteTypes"

	self propertyAt: #autocomplete put: anObject
]

{ #category : #api }
IonInput >> autocorrect [

	"Whether auto correction should be enabled when the user is entering/editing the text value.
	
	Type: 'on' | 'off'"

	^ self propertyAt: #autocorrect
]

{ #category : #api }
IonInput >> autocorrect: aString [

	"Whether auto correction should be enabled when the user is entering/editing the text value.
	
	Type: 'on' | 'off'"

	self propertyAt: #autocorrect put: aString
]

{ #category : #api }
IonInput >> autofocus [

	"Sets the ['autofocus' attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/autofocus) on the native input element.  This may not be sufficient for the element to be focused on page load. See [managing focus](/docs/developing/managing-focus) for more information.
	
	Type: boolean"

	^ self propertyAt: #autofocus
]

{ #category : #api }
IonInput >> autofocus: aBoolean [

	"Sets the ['autofocus' attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/autofocus) on the native input element.  This may not be sufficient for the element to be focused on page load. See [managing focus](/docs/developing/managing-focus) for more information.
	
	Type: boolean"

	self propertyAt: #autofocus put: aBoolean
]

{ #category : #api }
IonInput >> clearInput [

	"If 'true', a clear icon will appear in the input when there is a value. Clicking it clears the input.
	
	Type: boolean"

	^ self propertyAt: #clearInput
]

{ #category : #api }
IonInput >> clearInput: aBoolean [

	"If 'true', a clear icon will appear in the input when there is a value. Clicking it clears the input.
	
	Type: boolean"

	self propertyAt: #clearInput put: aBoolean
]

{ #category : #api }
IonInput >> clearInputIcon [

	"The icon to use for the clear button. Only applies when 'clearInput' is set to 'true'.
	
	Type: string"

	^ self propertyAt: #clearInputIcon
]

{ #category : #api }
IonInput >> clearInputIcon: aString [

	"The icon to use for the clear button. Only applies when 'clearInput' is set to 'true'.
	
	Type: string"

	self propertyAt: #clearInputIcon put: aString
]

{ #category : #api }
IonInput >> clearOnEdit [

	"If 'true', the value will be cleared after focus upon edit. Defaults to 'true' when 'type' is ''password'', 'false' for all other types.
	
	Type: boolean"

	^ self propertyAt: #clearOnEdit
]

{ #category : #api }
IonInput >> clearOnEdit: aBoolean [

	"If 'true', the value will be cleared after focus upon edit. Defaults to 'true' when 'type' is ''password'', 'false' for all other types.
	
	Type: boolean"

	self propertyAt: #clearOnEdit put: aBoolean
]

{ #category : #api }
IonInput >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonInput >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonInput >> counter [

	"If 'true', a character counter will display the ratio of characters used and the total character limit. Developers must also set the 'maxlength' property for the counter to be calculated correctly.
	
	Type: boolean"

	^ self propertyAt: #counter
]

{ #category : #api }
IonInput >> counter: aBoolean [

	"If 'true', a character counter will display the ratio of characters used and the total character limit. Developers must also set the 'maxlength' property for the counter to be calculated correctly.
	
	Type: boolean"

	self propertyAt: #counter put: aBoolean
]

{ #category : #api }
IonInput >> counterFormatter [

	"A callback used to format the counter text. By default the counter text is set to 'itemLength / maxLength'.  See https://ionicframework.com/docs/troubleshooting/runtime#accessing-this if you need to access 'this' from within the callback.
	
	Type: (inputLength: number, maxLength: number) => string"

	^ self propertyAt: #counterFormatter
]

{ #category : #api }
IonInput >> counterFormatter: aBlock [

	"A callback used to format the counter text. By default the counter text is set to 'itemLength / maxLength'.  See https://ionicframework.com/docs/troubleshooting/runtime#accessing-this if you need to access 'this' from within the callback.
	
	Type: (inputLength: number, maxLength: number) => string"

	self propertyAt: #counterFormatter put: aBlock asJavaScriptFunction
]

{ #category : #api }
IonInput >> counterFormatter: inputLength maxLength: maxLength [

	"A callback used to format the counter text. By default the counter text is set to 'itemLength / maxLength'.  See https://ionicframework.com/docs/troubleshooting/runtime#accessing-this if you need to access 'this' from within the callback.
	
	Type: (inputLength: number, maxLength: number) => string"

	^ self apply: #counterFormatter withArguments: { inputLength . maxLength } resultAs: Object
]

{ #category : #api }
IonInput >> debounce [

	"Set the amount of time, in milliseconds, to wait to trigger the 'ionInput' event after each keystroke.
	
	Type: number"

	^ self propertyAt: #debounce
]

{ #category : #api }
IonInput >> debounce: aNumber [

	"Set the amount of time, in milliseconds, to wait to trigger the 'ionInput' event after each keystroke.
	
	Type: number"

	self propertyAt: #debounce put: aNumber
]

{ #category : #api }
IonInput >> disabled [

	"If 'true', the user cannot interact with the input.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonInput >> disabled: aBoolean [

	"If 'true', the user cannot interact with the input.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonInput >> enterkeyhint [

	"A hint to the browser for which enter key to display. Possible values: ''enter'', ''done'', ''go'', ''next'', ''previous'', ''search'', and ''send''.
	
	Type: 'enter' | 'done' | 'go' | 'next' | 'previous' | 'search' | 'send'"

	^ self propertyAt: #enterkeyhint
]

{ #category : #api }
IonInput >> enterkeyhint: aString [

	"A hint to the browser for which enter key to display. Possible values: ''enter'', ''done'', ''go'', ''next'', ''previous'', ''search'', and ''send''.
	
	Type: 'enter' | 'done' | 'go' | 'next' | 'previous' | 'search' | 'send'"

	self propertyAt: #enterkeyhint put: aString
]

{ #category : #api }
IonInput >> errorText [

	"Text that is placed under the input and displayed when an error is detected.
	
	Type: string"

	^ self propertyAt: #errorText
]

{ #category : #api }
IonInput >> errorText: aString [

	"Text that is placed under the input and displayed when an error is detected.
	
	Type: string"

	self propertyAt: #errorText put: aString
]

{ #category : #api }
IonInput >> fill [

	"The fill for the item. If ''solid'' the item will have a background. If ''outline'' the item will be transparent with a border. Only available in 'md' mode.
	
	Type: 'outline' | 'solid'"

	^ self propertyAt: #fill
]

{ #category : #api }
IonInput >> fill: aString [

	"The fill for the item. If ''solid'' the item will have a background. If ''outline'' the item will be transparent with a border. Only available in 'md' mode.
	
	Type: 'outline' | 'solid'"

	self propertyAt: #fill put: aString
]

{ #category : #api }
IonInput >> getInputElement [

	"Returns the native '<input>' element used under the hood.
	
	Type: Promise<HTMLInputElement>"

	^ self apply: #getInputElement resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonInput >> helperText [

	"Text that is placed under the input and displayed when no error is detected.
	
	Type: string"

	^ self propertyAt: #helperText
]

{ #category : #api }
IonInput >> helperText: aString [

	"Text that is placed under the input and displayed when no error is detected.
	
	Type: string"

	self propertyAt: #helperText put: aString
]

{ #category : #api }
IonInput >> inputmode [

	"A hint to the browser for which keyboard to display. Possible values: ''none'', ''text'', ''tel'', ''url'', ''email'', ''numeric'', ''decimal'', and ''search''.
	
	Type: 'none' | 'text' | 'tel' | 'url' | 'email' | 'numeric' | 'decimal' | 'search'"

	^ self propertyAt: #inputmode
]

{ #category : #api }
IonInput >> inputmode: aString [

	"A hint to the browser for which keyboard to display. Possible values: ''none'', ''text'', ''tel'', ''url'', ''email'', ''numeric'', ''decimal'', and ''search''.
	
	Type: 'none' | 'text' | 'tel' | 'url' | 'email' | 'numeric' | 'decimal' | 'search'"

	self propertyAt: #inputmode put: aString
]

{ #category : #api }
IonInput >> label [

	"The visible label associated with the input.  Use this if you need to render a plaintext label.  The 'label' property will take priority over the 'label' slot if both are used.
	
	Type: string"

	^ self propertyAt: #label
]

{ #category : #api }
IonInput >> label: aString [

	"The visible label associated with the input.  Use this if you need to render a plaintext label.  The 'label' property will take priority over the 'label' slot if both are used.
	
	Type: string"

	self propertyAt: #label put: aString
]

{ #category : #api }
IonInput >> labelPlacement [

	"Where to place the label relative to the input. ''start'': The label will appear to the left of the input in LTR and to the right in RTL. ''end'': The label will appear to the right of the input in LTR and to the left in RTL. ''floating'': The label will appear smaller and above the input when the input is focused or it has a value. Otherwise it will appear on top of the input. ''stacked'': The label will appear smaller and above the input regardless even when the input is blurred or has no value. ''fixed'': The label has the same behavior as ''start'' except it also has a fixed width. Long text will be truncated with ellipses ('...').
	
	Type: 'start' | 'end' | 'floating' | 'stacked' | 'fixed'"

	^ self propertyAt: #labelPlacement
]

{ #category : #api }
IonInput >> labelPlacement: aString [

	"Where to place the label relative to the input. ''start'': The label will appear to the left of the input in LTR and to the right in RTL. ''end'': The label will appear to the right of the input in LTR and to the left in RTL. ''floating'': The label will appear smaller and above the input when the input is focused or it has a value. Otherwise it will appear on top of the input. ''stacked'': The label will appear smaller and above the input regardless even when the input is blurred or has no value. ''fixed'': The label has the same behavior as ''start'' except it also has a fixed width. Long text will be truncated with ellipses ('...').
	
	Type: 'start' | 'end' | 'floating' | 'stacked' | 'fixed'"

	self propertyAt: #labelPlacement put: aString
]

{ #category : #api }
IonInput >> max [

	"The maximum value, which must not be less than its minimum (min attribute) value.
	
	Type: string | number"

	^ self propertyAt: #max
]

{ #category : #api }
IonInput >> max: anObject [

	"The maximum value, which must not be less than its minimum (min attribute) value.
	
	Type: string | number"

	self propertyAt: #max put: anObject
]

{ #category : #api }
IonInput >> maxlength [

	"If the value of the type attribute is 'text', 'email', 'search', 'password', 'tel', or 'url', this attribute specifies the maximum number of characters that the user can enter.
	
	Type: number"

	^ self propertyAt: #maxlength
]

{ #category : #api }
IonInput >> maxlength: aNumber [

	"If the value of the type attribute is 'text', 'email', 'search', 'password', 'tel', or 'url', this attribute specifies the maximum number of characters that the user can enter.
	
	Type: number"

	self propertyAt: #maxlength put: aNumber
]

{ #category : #api }
IonInput >> min [

	"The minimum value, which must not be greater than its maximum (max attribute) value.
	
	Type: string | number"

	^ self propertyAt: #min
]

{ #category : #api }
IonInput >> min: anObject [

	"The minimum value, which must not be greater than its maximum (max attribute) value.
	
	Type: string | number"

	self propertyAt: #min put: anObject
]

{ #category : #api }
IonInput >> minlength [

	"If the value of the type attribute is 'text', 'email', 'search', 'password', 'tel', or 'url', this attribute specifies the minimum number of characters that the user can enter.
	
	Type: number"

	^ self propertyAt: #minlength
]

{ #category : #api }
IonInput >> minlength: aNumber [

	"If the value of the type attribute is 'text', 'email', 'search', 'password', 'tel', or 'url', this attribute specifies the minimum number of characters that the user can enter.
	
	Type: number"

	self propertyAt: #minlength put: aNumber
]

{ #category : #api }
IonInput >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonInput >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonInput >> multiple [

	"If 'true', the user can enter more than one value. This attribute applies when the type attribute is set to ''email'', otherwise it is ignored.
	
	Type: boolean"

	^ self propertyAt: #multiple
]

{ #category : #api }
IonInput >> multiple: aBoolean [

	"If 'true', the user can enter more than one value. This attribute applies when the type attribute is set to ''email'', otherwise it is ignored.
	
	Type: boolean"

	self propertyAt: #multiple put: aBoolean
]

{ #category : #api }
IonInput >> name [

	"The name of the control, which is submitted with the form data.
	
	Type: string"

	^ self propertyAt: #name
]

{ #category : #api }
IonInput >> name: aString [

	"The name of the control, which is submitted with the form data.
	
	Type: string"

	self propertyAt: #name put: aString
]

{ #category : #api }
IonInput >> pattern [

	"A regular expression that the value is checked against. The pattern must match the entire value, not just some subset. Use the title attribute to describe the pattern to help the user. This attribute applies when the value of the type attribute is ''text'', ''search'', ''tel'', ''url'', ''email'', ''date'', or ''password'', otherwise it is ignored. When the type attribute is ''date'', 'pattern' will only be used in browsers that do not support the ''date'' input type natively. See https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/date for more information.
	
	Type: string"

	^ self propertyAt: #pattern
]

{ #category : #api }
IonInput >> pattern: aString [

	"A regular expression that the value is checked against. The pattern must match the entire value, not just some subset. Use the title attribute to describe the pattern to help the user. This attribute applies when the value of the type attribute is ''text'', ''search'', ''tel'', ''url'', ''email'', ''date'', or ''password'', otherwise it is ignored. When the type attribute is ''date'', 'pattern' will only be used in browsers that do not support the ''date'' input type natively. See https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/date for more information.
	
	Type: string"

	self propertyAt: #pattern put: aString
]

{ #category : #api }
IonInput >> placeholder [

	"Instructional text that shows before the input has a value. This property applies only when the 'type' property is set to ''email'', ''number'', ''password'', ''search'', ''tel'', ''text'', or ''url'', otherwise it is ignored.
	
	Type: string"

	^ self propertyAt: #placeholder
]

{ #category : #api }
IonInput >> placeholder: aString [

	"Instructional text that shows before the input has a value. This property applies only when the 'type' property is set to ''email'', ''number'', ''password'', ''search'', ''tel'', ''text'', or ''url'', otherwise it is ignored.
	
	Type: string"

	self propertyAt: #placeholder put: aString
]

{ #category : #api }
IonInput >> readonly [

	"If 'true', the user cannot modify the value.
	
	Type: boolean"

	^ self propertyAt: #readonly
]

{ #category : #api }
IonInput >> readonly: aBoolean [

	"If 'true', the user cannot modify the value.
	
	Type: boolean"

	self propertyAt: #readonly put: aBoolean
]

{ #category : #api }
IonInput >> required [

	"If 'true', the user must fill in a value before submitting a form.
	
	Type: boolean"

	^ self propertyAt: #required
]

{ #category : #api }
IonInput >> required: aBoolean [

	"If 'true', the user must fill in a value before submitting a form.
	
	Type: boolean"

	self propertyAt: #required put: aBoolean
]

{ #category : #api }
IonInput >> setFocus [

	"Sets focus on the native 'input' in 'ion-input'. Use this method instead of the global 'input.focus()'.  Developers who wish to focus an input when a page enters should call 'setFocus()' in the 'ionViewDidEnter()' lifecycle method.  Developers who wish to focus an input when an overlay is presented should call 'setFocus' after 'didPresent' has resolved.  See [managing focus](/docs/developing/managing-focus) for more information.
	
	Type: Promise<void>"

	^ self apply: #setFocus resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonInput >> shape [

	"The shape of the input. If 'round' it will have an increased border radius.
	
	Type: 'round'"

	^ self propertyAt: #shape
]

{ #category : #api }
IonInput >> shape: aString [

	"The shape of the input. If 'round' it will have an increased border radius.
	
	Type: 'round'"

	self propertyAt: #shape put: aString
]

{ #category : #api }
IonInput >> spellcheck [

	"If 'true', the element will have its spelling and grammar checked.
	
	Type: boolean"

	^ self propertyAt: #spellcheck
]

{ #category : #api }
IonInput >> spellcheck: aBoolean [

	"If 'true', the element will have its spelling and grammar checked.
	
	Type: boolean"

	self propertyAt: #spellcheck put: aBoolean
]

{ #category : #api }
IonInput >> step [

	"Works with the min and max attributes to limit the increments at which a value can be set. Possible values are: ''any'' or a positive floating point number.
	
	Type: string"

	^ self propertyAt: #step
]

{ #category : #api }
IonInput >> step: aString [

	"Works with the min and max attributes to limit the increments at which a value can be set. Possible values are: ''any'' or a positive floating point number.
	
	Type: string"

	self propertyAt: #step put: aString
]

{ #category : #api }
IonInput >> type [

	"The type of control to display. The default type is text.
	
	Type: TextFieldTypes"

	^ self propertyAt: #type
]

{ #category : #api }
IonInput >> type: anObject [

	"The type of control to display. The default type is text.
	
	Type: TextFieldTypes"

	self propertyAt: #type put: anObject
]

{ #category : #api }
IonInput >> value [

	"The value of the input.
	
	Type: string | number | null"

	^ self propertyAt: #value
]

{ #category : #api }
IonInput >> value: anObject [

	"The value of the input.
	
	Type: string | number | null"

	self propertyAt: #value put: anObject
]
