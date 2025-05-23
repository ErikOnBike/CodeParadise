Class {
	#name : #IonSearchbar,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonSearchbar >> animated [

	"If 'true', enable searchbar animation.
	
	Type: boolean"

	^ self propertyAt: #animated
]

{ #category : #api }
IonSearchbar >> animated: aBoolean [

	"If 'true', enable searchbar animation.
	
	Type: boolean"

	self propertyAt: #animated put: aBoolean
]

{ #category : #api }
IonSearchbar >> autocapitalize [

	"Indicates whether and how the text value should be automatically capitalized as it is entered/edited by the user. Available options: ''off'', ''none'', ''on'', ''sentences'', ''words'', ''characters''.
	
	Type: string"

	^ self propertyAt: #autocapitalize
]

{ #category : #api }
IonSearchbar >> autocapitalize: aString [

	"Indicates whether and how the text value should be automatically capitalized as it is entered/edited by the user. Available options: ''off'', ''none'', ''on'', ''sentences'', ''words'', ''characters''.
	
	Type: string"

	self propertyAt: #autocapitalize put: aString
]

{ #category : #api }
IonSearchbar >> autocomplete [

	"Set the input's autocomplete property.
	
	Type: AutocompleteTypes"

	^ self propertyAt: #autocomplete
]

{ #category : #api }
IonSearchbar >> autocomplete: anObject [

	"Set the input's autocomplete property.
	
	Type: AutocompleteTypes"

	self propertyAt: #autocomplete put: anObject
]

{ #category : #api }
IonSearchbar >> autocorrect [

	"Set the input's autocorrect property.
	
	Type: 'on' | 'off'"

	^ self propertyAt: #autocorrect
]

{ #category : #api }
IonSearchbar >> autocorrect: aString [

	"Set the input's autocorrect property.
	
	Type: 'on' | 'off'"

	self propertyAt: #autocorrect put: aString
]

{ #category : #api }
IonSearchbar >> cancelButtonIcon [

	"Set the cancel button icon. Only applies to 'md' mode. Defaults to 'arrow-back-sharp'.
	
	Type: string"

	^ self propertyAt: #cancelButtonIcon
]

{ #category : #api }
IonSearchbar >> cancelButtonIcon: aString [

	"Set the cancel button icon. Only applies to 'md' mode. Defaults to 'arrow-back-sharp'.
	
	Type: string"

	self propertyAt: #cancelButtonIcon put: aString
]

{ #category : #api }
IonSearchbar >> cancelButtonText [

	"Set the cancel button text. Only applies to 'ios' mode.
	
	Type: string"

	^ self propertyAt: #cancelButtonText
]

{ #category : #api }
IonSearchbar >> cancelButtonText: aString [

	"Set the cancel button text. Only applies to 'ios' mode.
	
	Type: string"

	self propertyAt: #cancelButtonText put: aString
]

{ #category : #api }
IonSearchbar >> clearIcon [

	"Set the clear icon. Defaults to 'close-circle' for 'ios' and 'close-sharp' for 'md'.
	
	Type: string"

	^ self propertyAt: #clearIcon
]

{ #category : #api }
IonSearchbar >> clearIcon: aString [

	"Set the clear icon. Defaults to 'close-circle' for 'ios' and 'close-sharp' for 'md'.
	
	Type: string"

	self propertyAt: #clearIcon put: aString
]

{ #category : #api }
IonSearchbar >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonSearchbar >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonSearchbar >> debounce [

	"Set the amount of time, in milliseconds, to wait to trigger the 'ionInput' event after each keystroke.
	
	Type: number"

	^ self propertyAt: #debounce
]

{ #category : #api }
IonSearchbar >> debounce: aNumber [

	"Set the amount of time, in milliseconds, to wait to trigger the 'ionInput' event after each keystroke.
	
	Type: number"

	self propertyAt: #debounce put: aNumber
]

{ #category : #api }
IonSearchbar >> disabled [

	"If 'true', the user cannot interact with the input.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonSearchbar >> disabled: aBoolean [

	"If 'true', the user cannot interact with the input.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonSearchbar >> enterkeyhint [

	"A hint to the browser for which enter key to display. Possible values: ''enter'', ''done'', ''go'', ''next'', ''previous'', ''search'', and ''send''.
	
	Type: 'enter' | 'done' | 'go' | 'next' | 'previous' | 'search' | 'send'"

	^ self propertyAt: #enterkeyhint
]

{ #category : #api }
IonSearchbar >> enterkeyhint: aString [

	"A hint to the browser for which enter key to display. Possible values: ''enter'', ''done'', ''go'', ''next'', ''previous'', ''search'', and ''send''.
	
	Type: 'enter' | 'done' | 'go' | 'next' | 'previous' | 'search' | 'send'"

	self propertyAt: #enterkeyhint put: aString
]

{ #category : #api }
IonSearchbar >> getInputElement [

	"Returns the native '<input>' element used under the hood.
	
	Type: Promise<HTMLInputElement>"

	^ self apply: #getInputElement resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonSearchbar >> inputmode [

	"A hint to the browser for which keyboard to display. Possible values: ''none'', ''text'', ''tel'', ''url'', ''email'', ''numeric'', ''decimal'', and ''search''.
	
	Type: 'none' | 'text' | 'tel' | 'url' | 'email' | 'numeric' | 'decimal' | 'search'"

	^ self propertyAt: #inputmode
]

{ #category : #api }
IonSearchbar >> inputmode: aString [

	"A hint to the browser for which keyboard to display. Possible values: ''none'', ''text'', ''tel'', ''url'', ''email'', ''numeric'', ''decimal'', and ''search''.
	
	Type: 'none' | 'text' | 'tel' | 'url' | 'email' | 'numeric' | 'decimal' | 'search'"

	self propertyAt: #inputmode put: aString
]

{ #category : #api }
IonSearchbar >> maxlength [

	"This attribute specifies the maximum number of characters that the user can enter.
	
	Type: number"

	^ self propertyAt: #maxlength
]

{ #category : #api }
IonSearchbar >> maxlength: aNumber [

	"This attribute specifies the maximum number of characters that the user can enter.
	
	Type: number"

	self propertyAt: #maxlength put: aNumber
]

{ #category : #api }
IonSearchbar >> minlength [

	"This attribute specifies the minimum number of characters that the user can enter.
	
	Type: number"

	^ self propertyAt: #minlength
]

{ #category : #api }
IonSearchbar >> minlength: aNumber [

	"This attribute specifies the minimum number of characters that the user can enter.
	
	Type: number"

	self propertyAt: #minlength put: aNumber
]

{ #category : #api }
IonSearchbar >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonSearchbar >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonSearchbar >> name [

	"If used in a form, set the name of the control, which is submitted with the form data.
	
	Type: string"

	^ self propertyAt: #name
]

{ #category : #api }
IonSearchbar >> name: aString [

	"If used in a form, set the name of the control, which is submitted with the form data.
	
	Type: string"

	self propertyAt: #name put: aString
]

{ #category : #api }
IonSearchbar >> placeholder [

	"Set the input's placeholder. 'placeholder' can accept either plaintext or HTML as a string. To display characters normally reserved for HTML, they must be escaped. For example '<Ionic>' would become '&lt;Ionic&gt;'  For more information: [Security Documentation](https://ionicframework.com/docs/faq/security)
	
	Type: string"

	^ self propertyAt: #placeholder
]

{ #category : #api }
IonSearchbar >> placeholder: aString [

	"Set the input's placeholder. 'placeholder' can accept either plaintext or HTML as a string. To display characters normally reserved for HTML, they must be escaped. For example '<Ionic>' would become '&lt;Ionic&gt;'  For more information: [Security Documentation](https://ionicframework.com/docs/faq/security)
	
	Type: string"

	self propertyAt: #placeholder put: aString
]

{ #category : #api }
IonSearchbar >> searchIcon [

	"The icon to use as the search icon. Defaults to 'search-outline' in 'ios' mode and 'search-sharp' in 'md' mode.
	
	Type: string"

	^ self propertyAt: #searchIcon
]

{ #category : #api }
IonSearchbar >> searchIcon: aString [

	"The icon to use as the search icon. Defaults to 'search-outline' in 'ios' mode and 'search-sharp' in 'md' mode.
	
	Type: string"

	self propertyAt: #searchIcon put: aString
]

{ #category : #api }
IonSearchbar >> setFocus [

	"Sets focus on the native 'input' in 'ion-searchbar'. Use this method instead of the global 'input.focus()'.  Developers who wish to focus an input when a page enters should call 'setFocus()' in the 'ionViewDidEnter()' lifecycle method.  Developers who wish to focus an input when an overlay is presented should call 'setFocus' after 'didPresent' has resolved.  See [managing focus](/docs/developing/managing-focus) for more information.
	
	Type: Promise<void>"

	^ self apply: #setFocus resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonSearchbar >> showCancelButton [

	"Sets the behavior for the cancel button. Defaults to ''never''. Setting to ''focus'' shows the cancel button on focus. Setting to ''never'' hides the cancel button. Setting to ''always'' shows the cancel button regardless of focus state.
	
	Type: 'never' | 'focus' | 'always'"

	^ self propertyAt: #showCancelButton
]

{ #category : #api }
IonSearchbar >> showCancelButton: aString [

	"Sets the behavior for the cancel button. Defaults to ''never''. Setting to ''focus'' shows the cancel button on focus. Setting to ''never'' hides the cancel button. Setting to ''always'' shows the cancel button regardless of focus state.
	
	Type: 'never' | 'focus' | 'always'"

	self propertyAt: #showCancelButton put: aString
]

{ #category : #api }
IonSearchbar >> showClearButton [

	"Sets the behavior for the clear button. Defaults to ''focus''. Setting to ''focus'' shows the clear button on focus if the input is not empty. Setting to ''never'' hides the clear button. Setting to ''always'' shows the clear button regardless of focus state, but only if the input is not empty.
	
	Type: 'never' | 'focus' | 'always'"

	^ self propertyAt: #showClearButton
]

{ #category : #api }
IonSearchbar >> showClearButton: aString [

	"Sets the behavior for the clear button. Defaults to ''focus''. Setting to ''focus'' shows the clear button on focus if the input is not empty. Setting to ''never'' hides the clear button. Setting to ''always'' shows the clear button regardless of focus state, but only if the input is not empty.
	
	Type: 'never' | 'focus' | 'always'"

	self propertyAt: #showClearButton put: aString
]

{ #category : #api }
IonSearchbar >> spellcheck [

	"If 'true', enable spellcheck on the input.
	
	Type: boolean"

	^ self propertyAt: #spellcheck
]

{ #category : #api }
IonSearchbar >> spellcheck: aBoolean [

	"If 'true', enable spellcheck on the input.
	
	Type: boolean"

	self propertyAt: #spellcheck put: aBoolean
]

{ #category : #api }
IonSearchbar >> type [

	"Set the type of the input.
	
	Type: 'text' | 'password' | 'email' | 'number' | 'search' | 'tel' | 'url'"

	^ self propertyAt: #type
]

{ #category : #api }
IonSearchbar >> type: aString [

	"Set the type of the input.
	
	Type: 'text' | 'password' | 'email' | 'number' | 'search' | 'tel' | 'url'"

	self propertyAt: #type put: aString
]

{ #category : #api }
IonSearchbar >> value [

	"the value of the searchbar.
	
	Type: string | null"

	^ self propertyAt: #value
]

{ #category : #api }
IonSearchbar >> value: aString [

	"the value of the searchbar.
	
	Type: string | null"

	self propertyAt: #value put: aString
]
