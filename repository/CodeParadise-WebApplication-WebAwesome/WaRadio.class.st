Class {
	#name : #WaRadio,
	#superclass : #WaFormControl,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaRadio >> appearance [

	"The radio's visual appearance.
	
	Type: String
	Default: 'default'
	Allowed: 'default' | 'button'"

	^ self propertyAt: #appearance
]

{ #category : #accessing }
WaRadio >> appearance: aString [

	"The radio's visual appearance.
	
	Type: String
	Default: 'default'
	Allowed: 'default' | 'button'"

	self propertyAt: #appearance put: aString
]

{ #category : #'accessing - convenience' }
WaRadio >> beButton [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #button
]

{ #category : #'accessing - convenience' }
WaRadio >> beDefault [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #default
]

{ #category : #'accessing - convenience' }
WaRadio >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #'accessing - convenience' }
WaRadio >> beLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #'accessing - convenience' }
WaRadio >> beMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #'accessing - convenience' }
WaRadio >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #'accessing - convenience' }
WaRadio >> beSizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #'accessing - convenience' }
WaRadio >> beSizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #'accessing - convenience' }
WaRadio >> beSizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #'accessing - convenience' }
WaRadio >> beSizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #'accessing - convenience' }
WaRadio >> beSizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #'accessing - convenience' }
WaRadio >> beSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #accessing }
WaRadio >> disabled [

	"Disables the radio.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaRadio >> disabled: aBoolean [

	"Disables the radio.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
WaRadio >> form [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	^ self propertyAt: #form
]

{ #category : #accessing }
WaRadio >> form: anHtmlElement [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	self propertyAt: #form put: anHtmlElement
]

{ #category : #accessing }
WaRadio >> name [

	"The name of the input, submitted as a name/value pair with form data.
	
	Type: String"

	^ self propertyAt: #name
]

{ #category : #accessing }
WaRadio >> name: aString [

	"The name of the input, submitted as a name/value pair with form data.
	
	Type: String"

	self propertyAt: #name put: aString
]

{ #category : #actions }
WaRadio >> resetValidity [

	"Reset validity is a way of removing manual custom errors and native validation."

	^ self apply: #resetValidity
]

{ #category : #actions }
WaRadio >> setCustomValidity: aString [

	"Do not use this when creating a ""Validator"". This is intended for end users of components.
	We track manually defined custom errors so we don't clear them on accident in our validators.
	
	Parameter: message (string)"

	^ self apply: #setCustomValidity withArguments: { aString }
]

{ #category : #accessing }
WaRadio >> size [

	"The radio's size. When used inside a radio group, the size will be determined by the radio group's size, which will
	override this attribute.
	
	Type: String
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	^ self propertyAt: #size
]

{ #category : #accessing }
WaRadio >> size: aString [

	"The radio's size. When used inside a radio group, the size will be determined by the radio group's size, which will
	override this attribute.
	
	Type: String
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	self propertyAt: #size put: aString
]

{ #category : #accessing }
WaRadio >> validationTarget [

	"Override this to change where constraint validation popups are anchored.
	
	Type: HtmlElement
	Read-only: true"

	^ self propertyAt: #validationTarget
]

{ #category : #accessing }
WaRadio >> value [

	"The radio's value. When selected, the radio group will receive this value.
	
	Type: String"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaRadio >> value: aString [

	"The radio's value. When selected, the radio group will receive this value.
	
	Type: String"

	self propertyAt: #value put: aString
]
