Class {
	#name : #IonTextarea,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonTextarea >> autoGrow [

	"If 'true', the textarea container will grow and shrink based on the contents of the textarea.
	
	Type: boolean"

	^ self propertyAt: #autoGrow
]

{ #category : #api }
IonTextarea >> autoGrow: aBoolean [

	"If 'true', the textarea container will grow and shrink based on the contents of the textarea.
	
	Type: boolean"

	self propertyAt: #autoGrow put: aBoolean
]

{ #category : #api }
IonTextarea >> autocapitalize [

	"Indicates whether and how the text value should be automatically capitalized as it is entered/edited by the user. Available options: ''off'', ''none'', ''on'', ''sentences'', ''words'', ''characters''.
	
	Type: string"

	^ self propertyAt: #autocapitalize
]

{ #category : #api }
IonTextarea >> autocapitalize: aString [

	"Indicates whether and how the text value should be automatically capitalized as it is entered/edited by the user. Available options: ''off'', ''none'', ''on'', ''sentences'', ''words'', ''characters''.
	
	Type: string"

	self propertyAt: #autocapitalize put: aString
]

{ #category : #api }
IonTextarea >> autofocus [

	"Sets the ['autofocus' attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/autofocus) on the native input element.  This may not be sufficient for the element to be focused on page load. See [managing focus](/docs/developing/managing-focus) for more information.
	
	Type: boolean"

	^ self propertyAt: #autofocus
]

{ #category : #api }
IonTextarea >> autofocus: aBoolean [

	"Sets the ['autofocus' attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/autofocus) on the native input element.  This may not be sufficient for the element to be focused on page load. See [managing focus](/docs/developing/managing-focus) for more information.
	
	Type: boolean"

	self propertyAt: #autofocus put: aBoolean
]

{ #category : #api }
IonTextarea >> clearOnEdit [

	"If 'true', the value will be cleared after focus upon edit.
	
	Type: boolean"

	^ self propertyAt: #clearOnEdit
]

{ #category : #api }
IonTextarea >> clearOnEdit: aBoolean [

	"If 'true', the value will be cleared after focus upon edit.
	
	Type: boolean"

	self propertyAt: #clearOnEdit put: aBoolean
]

{ #category : #api }
IonTextarea >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonTextarea >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonTextarea >> cols [

	"The visible width of the text control, in average character widths. If it is specified, it must be a positive integer.
	
	Type: number"

	^ self propertyAt: #cols
]

{ #category : #api }
IonTextarea >> cols: aNumber [

	"The visible width of the text control, in average character widths. If it is specified, it must be a positive integer.
	
	Type: number"

	self propertyAt: #cols put: aNumber
]

{ #category : #api }
IonTextarea >> counter [

	"If 'true', a character counter will display the ratio of characters used and the total character limit. Developers must also set the 'maxlength' property for the counter to be calculated correctly.
	
	Type: boolean"

	^ self propertyAt: #counter
]

{ #category : #api }
IonTextarea >> counter: aBoolean [

	"If 'true', a character counter will display the ratio of characters used and the total character limit. Developers must also set the 'maxlength' property for the counter to be calculated correctly.
	
	Type: boolean"

	self propertyAt: #counter put: aBoolean
]

{ #category : #api }
IonTextarea >> counterFormatter [

	"A callback used to format the counter text. By default the counter text is set to 'itemLength / maxLength'.  See https://ionicframework.com/docs/troubleshooting/runtime#accessing-this if you need to access 'this' from within the callback.
	
	Type: (inputLength: number, maxLength: number) => string"

	^ self propertyAt: #counterFormatter
]

{ #category : #api }
IonTextarea >> counterFormatter: aBlock [

	"A callback used to format the counter text. By default the counter text is set to 'itemLength / maxLength'.  See https://ionicframework.com/docs/troubleshooting/runtime#accessing-this if you need to access 'this' from within the callback.
	
	Type: (inputLength: number, maxLength: number) => string"

	self propertyAt: #counterFormatter put: aBlock asJavaScriptFunction
]

{ #category : #api }
IonTextarea >> counterFormatter: inputLength maxLength: maxLength [

	"A callback used to format the counter text. By default the counter text is set to 'itemLength / maxLength'.  See https://ionicframework.com/docs/troubleshooting/runtime#accessing-this if you need to access 'this' from within the callback.
	
	Type: (inputLength: number, maxLength: number) => string"

	^ self apply: #counterFormatter withArguments: { inputLength . maxLength } resultAs: Object
]

{ #category : #api }
IonTextarea >> debounce [

	"Set the amount of time, in milliseconds, to wait to trigger the 'ionInput' event after each keystroke.
	
	Type: number"

	^ self propertyAt: #debounce
]

{ #category : #api }
IonTextarea >> debounce: aNumber [

	"Set the amount of time, in milliseconds, to wait to trigger the 'ionInput' event after each keystroke.
	
	Type: number"

	self propertyAt: #debounce put: aNumber
]

{ #category : #api }
IonTextarea >> disabled [

	"If 'true', the user cannot interact with the textarea.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonTextarea >> disabled: aBoolean [

	"If 'true', the user cannot interact with the textarea.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonTextarea >> enterkeyhint [

	"A hint to the browser for which enter key to display. Possible values: ''enter'', ''done'', ''go'', ''next'', ''previous'', ''search'', and ''send''.
	
	Type: 'enter' | 'done' | 'go' | 'next' | 'previous' | 'search' | 'send'"

	^ self propertyAt: #enterkeyhint
]

{ #category : #api }
IonTextarea >> enterkeyhint: aString [

	"A hint to the browser for which enter key to display. Possible values: ''enter'', ''done'', ''go'', ''next'', ''previous'', ''search'', and ''send''.
	
	Type: 'enter' | 'done' | 'go' | 'next' | 'previous' | 'search' | 'send'"

	self propertyAt: #enterkeyhint put: aString
]

{ #category : #api }
IonTextarea >> errorText [

	"Text that is placed under the textarea and displayed when an error is detected.
	
	Type: string"

	^ self propertyAt: #errorText
]

{ #category : #api }
IonTextarea >> errorText: aString [

	"Text that is placed under the textarea and displayed when an error is detected.
	
	Type: string"

	self propertyAt: #errorText put: aString
]

{ #category : #api }
IonTextarea >> fill [

	"The fill for the item. If ''solid'' the item will have a background. If ''outline'' the item will be transparent with a border. Only available in 'md' mode.
	
	Type: 'outline' | 'solid'"

	^ self propertyAt: #fill
]

{ #category : #api }
IonTextarea >> fill: aString [

	"The fill for the item. If ''solid'' the item will have a background. If ''outline'' the item will be transparent with a border. Only available in 'md' mode.
	
	Type: 'outline' | 'solid'"

	self propertyAt: #fill put: aString
]

{ #category : #api }
IonTextarea >> getInputElement [

	"Returns the native '<textarea>' element used under the hood.
	
	Type: Promise<HTMLTextAreaElement>"

	^ self apply: #getInputElement resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonTextarea >> helperText [

	"Text that is placed under the textarea and displayed when no error is detected.
	
	Type: string"

	^ self propertyAt: #helperText
]

{ #category : #api }
IonTextarea >> helperText: aString [

	"Text that is placed under the textarea and displayed when no error is detected.
	
	Type: string"

	self propertyAt: #helperText put: aString
]

{ #category : #api }
IonTextarea >> inputmode [

	"A hint to the browser for which keyboard to display. Possible values: ''none'', ''text'', ''tel'', ''url'', ''email'', ''numeric'', ''decimal'', and ''search''.
	
	Type: 'none' | 'text' | 'tel' | 'url' | 'email' | 'numeric' | 'decimal' | 'search'"

	^ self propertyAt: #inputmode
]

{ #category : #api }
IonTextarea >> inputmode: aString [

	"A hint to the browser for which keyboard to display. Possible values: ''none'', ''text'', ''tel'', ''url'', ''email'', ''numeric'', ''decimal'', and ''search''.
	
	Type: 'none' | 'text' | 'tel' | 'url' | 'email' | 'numeric' | 'decimal' | 'search'"

	self propertyAt: #inputmode put: aString
]

{ #category : #api }
IonTextarea >> label [

	"The visible label associated with the textarea.  Use this if you need to render a plaintext label.  The 'label' property will take priority over the 'label' slot if both are used.
	
	Type: string"

	^ self propertyAt: #label
]

{ #category : #api }
IonTextarea >> label: aString [

	"The visible label associated with the textarea.  Use this if you need to render a plaintext label.  The 'label' property will take priority over the 'label' slot if both are used.
	
	Type: string"

	self propertyAt: #label put: aString
]

{ #category : #api }
IonTextarea >> labelPlacement [

	"Where to place the label relative to the textarea. ''start'': The label will appear to the left of the textarea in LTR and to the right in RTL. ''end'': The label will appear to the right of the textarea in LTR and to the left in RTL. ''floating'': The label will appear smaller and above the textarea when the textarea is focused or it has a value. Otherwise it will appear on top of the textarea. ''stacked'': The label will appear smaller and above the textarea regardless even when the textarea is blurred or has no value. ''fixed'': The label has the same behavior as ''start'' except it also has a fixed width. Long text will be truncated with ellipses ('...').
	
	Type: 'start' | 'end' | 'floating' | 'stacked' | 'fixed'"

	^ self propertyAt: #labelPlacement
]

{ #category : #api }
IonTextarea >> labelPlacement: aString [

	"Where to place the label relative to the textarea. ''start'': The label will appear to the left of the textarea in LTR and to the right in RTL. ''end'': The label will appear to the right of the textarea in LTR and to the left in RTL. ''floating'': The label will appear smaller and above the textarea when the textarea is focused or it has a value. Otherwise it will appear on top of the textarea. ''stacked'': The label will appear smaller and above the textarea regardless even when the textarea is blurred or has no value. ''fixed'': The label has the same behavior as ''start'' except it also has a fixed width. Long text will be truncated with ellipses ('...').
	
	Type: 'start' | 'end' | 'floating' | 'stacked' | 'fixed'"

	self propertyAt: #labelPlacement put: aString
]

{ #category : #api }
IonTextarea >> maxlength [

	"This attribute specifies the maximum number of characters that the user can enter.
	
	Type: number"

	^ self propertyAt: #maxlength
]

{ #category : #api }
IonTextarea >> maxlength: aNumber [

	"This attribute specifies the maximum number of characters that the user can enter.
	
	Type: number"

	self propertyAt: #maxlength put: aNumber
]

{ #category : #api }
IonTextarea >> minlength [

	"This attribute specifies the minimum number of characters that the user can enter.
	
	Type: number"

	^ self propertyAt: #minlength
]

{ #category : #api }
IonTextarea >> minlength: aNumber [

	"This attribute specifies the minimum number of characters that the user can enter.
	
	Type: number"

	self propertyAt: #minlength put: aNumber
]

{ #category : #api }
IonTextarea >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonTextarea >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonTextarea >> name [

	"The name of the control, which is submitted with the form data.
	
	Type: string"

	^ self propertyAt: #name
]

{ #category : #api }
IonTextarea >> name: aString [

	"The name of the control, which is submitted with the form data.
	
	Type: string"

	self propertyAt: #name put: aString
]

{ #category : #api }
IonTextarea >> placeholder [

	"Instructional text that shows before the input has a value.
	
	Type: string"

	^ self propertyAt: #placeholder
]

{ #category : #api }
IonTextarea >> placeholder: aString [

	"Instructional text that shows before the input has a value.
	
	Type: string"

	self propertyAt: #placeholder put: aString
]

{ #category : #api }
IonTextarea >> readonly [

	"If 'true', the user cannot modify the value.
	
	Type: boolean"

	^ self propertyAt: #readonly
]

{ #category : #api }
IonTextarea >> readonly: aBoolean [

	"If 'true', the user cannot modify the value.
	
	Type: boolean"

	self propertyAt: #readonly put: aBoolean
]

{ #category : #api }
IonTextarea >> required [

	"If 'true', the user must fill in a value before submitting a form.
	
	Type: boolean"

	^ self propertyAt: #required
]

{ #category : #api }
IonTextarea >> required: aBoolean [

	"If 'true', the user must fill in a value before submitting a form.
	
	Type: boolean"

	self propertyAt: #required put: aBoolean
]

{ #category : #api }
IonTextarea >> rows [

	"The number of visible text lines for the control.
	
	Type: number"

	^ self propertyAt: #rows
]

{ #category : #api }
IonTextarea >> rows: aNumber [

	"The number of visible text lines for the control.
	
	Type: number"

	self propertyAt: #rows put: aNumber
]

{ #category : #api }
IonTextarea >> setFocus [

	"Sets focus on the native 'textarea' in 'ion-textarea'. Use this method instead of the global 'textarea.focus()'.  See [managing focus](/docs/developing/managing-focus) for more information.
	
	Type: Promise<void>"

	^ self apply: #setFocus resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonTextarea >> shape [

	"The shape of the textarea. If 'round' it will have an increased border radius.
	
	Type: 'round'"

	^ self propertyAt: #shape
]

{ #category : #api }
IonTextarea >> shape: aString [

	"The shape of the textarea. If 'round' it will have an increased border radius.
	
	Type: 'round'"

	self propertyAt: #shape put: aString
]

{ #category : #api }
IonTextarea >> spellcheck [

	"If 'true', the element will have its spelling and grammar checked.
	
	Type: boolean"

	^ self propertyAt: #spellcheck
]

{ #category : #api }
IonTextarea >> spellcheck: aBoolean [

	"If 'true', the element will have its spelling and grammar checked.
	
	Type: boolean"

	self propertyAt: #spellcheck put: aBoolean
]

{ #category : #api }
IonTextarea >> value [

	"The value of the textarea.
	
	Type: string | null"

	^ self propertyAt: #value
]

{ #category : #api }
IonTextarea >> value: aString [

	"The value of the textarea.
	
	Type: string | null"

	self propertyAt: #value put: aString
]

{ #category : #api }
IonTextarea >> wrap [

	"Indicates how the control wraps text.
	
	Type: 'hard' | 'soft' | 'off'"

	^ self propertyAt: #wrap
]

{ #category : #api }
IonTextarea >> wrap: aString [

	"Indicates how the control wraps text.
	
	Type: 'hard' | 'soft' | 'off'"

	self propertyAt: #wrap put: aString
]
