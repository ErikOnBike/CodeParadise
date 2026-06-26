Class {
	#name : #WaRating,
	#superclass : #WaFormControl,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #convenience }
WaRating >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #convenience }
WaRating >> beLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #convenience }
WaRating >> beMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #convenience }
WaRating >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #convenience }
WaRating >> beNotReadonly [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self readonly: false
]

{ #category : #convenience }
WaRating >> beNotRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: false
]

{ #category : #convenience }
WaRating >> beReadonly [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self readonly: true
]

{ #category : #convenience }
WaRating >> beRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: true
]

{ #category : #convenience }
WaRating >> beSizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #convenience }
WaRating >> beSizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #convenience }
WaRating >> beSizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #convenience }
WaRating >> beSizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #convenience }
WaRating >> beSizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #convenience }
WaRating >> beSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #accessing }
WaRating >> defaultValue [

	"The default value of the form control. Used to reset the rating to its initial value.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #defaultValue
]

{ #category : #accessing }
WaRating >> defaultValue: aNumber [

	"The default value of the form control. Used to reset the rating to its initial value.
	
	Type: Number
	Default: 0"

	self propertyAt: #defaultValue put: aNumber
]

{ #category : #accessing }
WaRating >> disabled [

	"Disables the rating.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaRating >> disabled: aBoolean [

	"Disables the rating.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
WaRating >> form [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	^ self propertyAt: #form
]

{ #category : #accessing }
WaRating >> form: anHtmlElement [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	self propertyAt: #form put: anHtmlElement
]

{ #category : #accessing }
WaRating >> getSymbol [

	"A function that customizes the symbol to be rendered. The first and only argument is the rating's current value.
	The function should return a string containing trusted HTML of the symbol to render at the specified value. Works
	well with `<wa-icon>` elements.
	
	Type: Block ((value: number, isSelected: boolean) => string)"

	^ (self propertyAt: #getSymbol) ifNotNil: [ :function | function asBlock ifNil: [ function ] ]
]

{ #category : #accessing }
WaRating >> getSymbol: aBlock [

	"A function that customizes the symbol to be rendered. The first and only argument is the rating's current value.
	The function should return a string containing trusted HTML of the symbol to render at the specified value. Works
	well with `<wa-icon>` elements.
	
	Type: Block ((value: number, isSelected: boolean) => string)"

	self propertyAt: #getSymbol put: aBlock asJavaScriptFunction
]

{ #category : #accessing }
WaRating >> label [

	"A label that describes the rating to assistive devices.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaRating >> label: aString [

	"A label that describes the rating to assistive devices.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #accessing }
WaRating >> max [

	"The highest rating to show.
	
	Type: Number
	Default: 5"

	^ self propertyAt: #max
]

{ #category : #accessing }
WaRating >> max: aNumber [

	"The highest rating to show.
	
	Type: Number
	Default: 5"

	self propertyAt: #max put: aNumber
]

{ #category : #accessing }
WaRating >> name [

	"The name of the rating, submitted as a name/value pair with form data.
	
	Type: String"

	^ self propertyAt: #name
]

{ #category : #accessing }
WaRating >> name: aString [

	"The name of the rating, submitted as a name/value pair with form data.
	
	Type: String"

	self propertyAt: #name put: aString
]

{ #category : #accessing }
WaRating >> precision [

	"The precision at which the rating will increase and decrease. For example, to allow half-star ratings, set this
	attribute to `0.5`.
	
	Type: Number
	Default: 1"

	^ self propertyAt: #precision
]

{ #category : #accessing }
WaRating >> precision: aNumber [

	"The precision at which the rating will increase and decrease. For example, to allow half-star ratings, set this
	attribute to `0.5`.
	
	Type: Number
	Default: 1"

	self propertyAt: #precision put: aNumber
]

{ #category : #accessing }
WaRating >> readonly [

	"Makes the rating readonly.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #readonly
]

{ #category : #accessing }
WaRating >> readonly: aBoolean [

	"Makes the rating readonly.
	
	Type: Boolean
	Default: false"

	self propertyAt: #readonly put: aBoolean
]

{ #category : #accessing }
WaRating >> required [

	"Makes the rating a required field.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #required
]

{ #category : #accessing }
WaRating >> required: aBoolean [

	"Makes the rating a required field.
	
	Type: Boolean
	Default: false"

	self propertyAt: #required put: aBoolean
]

{ #category : #actions }
WaRating >> resetValidity [

	"Reset validity is a way of removing manual custom errors and native validation."

	^ self apply: #resetValidity
]

{ #category : #actions }
WaRating >> setCustomValidity: aString [

	"Do not use this when creating a ""Validator"". This is intended for end users of components.
	We track manually defined custom errors so we don't clear them on accident in our validators.
	
	Parameter: message (string)"

	^ self apply: #setCustomValidity withArguments: { aString }
]

{ #category : #accessing }
WaRating >> size [

	"The component's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	^ self propertyAt: #size
]

{ #category : #accessing }
WaRating >> size: aString [

	"The component's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	self propertyAt: #size put: aString
]

{ #category : #accessing }
WaRating >> validationTarget [

	"Override this to change where constraint validation popups are anchored.
	
	Type: HtmlElement
	Read-only: true"

	^ self propertyAt: #validationTarget
]

{ #category : #accessing }
WaRating >> value [

	"The current rating.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaRating >> value: aNumber [

	"The current rating.
	
	Type: Number
	Default: 0"

	self propertyAt: #value put: aNumber
]
