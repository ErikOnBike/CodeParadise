Class {
	#name : #WaButton,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaButton >> appearance [

	"The button's visual appearance.
	
	Type: String
	Default: 'accent'
	Allowed: 'accent' | 'filled' | 'outlined' | 'filled-outlined' | 'plain'"

	^ self propertyAt: #appearance
]

{ #category : #accessing }
WaButton >> appearance: aString [

	"The button's visual appearance.
	
	Type: String
	Default: 'accent'
	Allowed: 'accent' | 'filled' | 'outlined' | 'filled-outlined' | 'plain'"

	self propertyAt: #appearance put: aString
]

{ #category : #convenience }
WaButton >> beAccent [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #accent
]

{ #category : #convenience }
WaButton >> beBrand [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #brand
]

{ #category : #convenience }
WaButton >> beDanger [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #danger
]

{ #category : #convenience }
WaButton >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #convenience }
WaButton >> beFilled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #filled
]

{ #category : #convenience }
WaButton >> beFilledOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #'filled-outlined'
]

{ #category : #convenience }
WaButton >> beFormNoValidate [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self formNoValidate: true
]

{ #category : #convenience }
WaButton >> beLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #convenience }
WaButton >> beLoading [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self loading: true
]

{ #category : #convenience }
WaButton >> beMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #convenience }
WaButton >> beNeutral [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #neutral
]

{ #category : #convenience }
WaButton >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #convenience }
WaButton >> beNotFormNoValidate [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self formNoValidate: false
]

{ #category : #convenience }
WaButton >> beNotLoading [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self loading: false
]

{ #category : #convenience }
WaButton >> beNotPill [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pill: false
]

{ #category : #convenience }
WaButton >> beOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #outlined
]

{ #category : #convenience }
WaButton >> bePill [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pill: true
]

{ #category : #convenience }
WaButton >> bePlain [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #plain
]

{ #category : #convenience }
WaButton >> beSizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #convenience }
WaButton >> beSizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #convenience }
WaButton >> beSizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #convenience }
WaButton >> beSizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #convenience }
WaButton >> beSizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #convenience }
WaButton >> beSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #convenience }
WaButton >> beSuccess [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #success
]

{ #category : #convenience }
WaButton >> beWarning [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #warning
]

{ #category : #convenience }
WaButton >> beWithCaret [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withCaret: true
]

{ #category : #convenience }
WaButton >> beWithEnd [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withEnd: true
]

{ #category : #convenience }
WaButton >> beWithStart [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withStart: true
]

{ #category : #convenience }
WaButton >> beWithoutCaret [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withCaret: false
]

{ #category : #convenience }
WaButton >> beWithoutEnd [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withEnd: false
]

{ #category : #convenience }
WaButton >> beWithoutStart [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withStart: false
]

{ #category : #actions }
WaButton >> blur [

	"Removes focus from the button."

	^ self apply: #blur
]

{ #category : #actions }
WaButton >> click [

	"Simulates a click on the button."

	^ self apply: #click
]

{ #category : #accessing }
WaButton >> disabled [

	"Disables the button.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaButton >> disabled: aBoolean [

	"Disables the button.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
WaButton >> download [

	"Tells the browser to download the linked file as this filename. Only used when `href` is present.
	
	Type: String"

	^ self propertyAt: #download
]

{ #category : #accessing }
WaButton >> download: aString [

	"Tells the browser to download the linked file as this filename. Only used when `href` is present.
	
	Type: String"

	self propertyAt: #download put: aString
]

{ #category : #actions }
WaButton >> focus [

	"Sets focus on the button."

	^ self apply: #focus
]

{ #category : #actions }
WaButton >> focus: anObject [

	"Sets focus on the button.
	
	Parameter: options (FocusOptions)"

	^ self apply: #focus withArguments: { anObject }
]

{ #category : #accessing }
WaButton >> form [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	^ self propertyAt: #form
]

{ #category : #accessing }
WaButton >> form: anHtmlElement [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	self propertyAt: #form put: anHtmlElement
]

{ #category : #accessing }
WaButton >> formAction [

	"Used to override the form owner's `action` attribute.
	
	Type: String"

	^ self propertyAt: #formAction
]

{ #category : #accessing }
WaButton >> formAction: aString [

	"Used to override the form owner's `action` attribute.
	
	Type: String"

	self propertyAt: #formAction put: aString
]

{ #category : #accessing }
WaButton >> formEnctype [

	"Used to override the form owner's `enctype` attribute.
	
	Type: String
	Allowed: 'application/x-www-form-urlencoded' | 'multipart/form-data' | 'text/plain'"

	^ self propertyAt: #formEnctype
]

{ #category : #accessing }
WaButton >> formEnctype: aString [

	"Used to override the form owner's `enctype` attribute.
	
	Type: String
	Allowed: 'application/x-www-form-urlencoded' | 'multipart/form-data' | 'text/plain'"

	self propertyAt: #formEnctype put: aString
]

{ #category : #accessing }
WaButton >> formMethod [

	"Used to override the form owner's `method` attribute.
	
	Type: String
	Allowed: 'post' | 'get'"

	^ self propertyAt: #formMethod
]

{ #category : #accessing }
WaButton >> formMethod: aString [

	"Used to override the form owner's `method` attribute.
	
	Type: String
	Allowed: 'post' | 'get'"

	self propertyAt: #formMethod put: aString
]

{ #category : #accessing }
WaButton >> formNoValidate [

	"Used to override the form owner's `novalidate` attribute.
	
	Type: Boolean"

	^ self propertyAt: #formNoValidate
]

{ #category : #accessing }
WaButton >> formNoValidate: aBoolean [

	"Used to override the form owner's `novalidate` attribute.
	
	Type: Boolean"

	self propertyAt: #formNoValidate put: aBoolean
]

{ #category : #accessing }
WaButton >> formTarget [

	"Used to override the form owner's `target` attribute.
	
	Type: String
	Allowed: '_self' | '_blank' | '_parent' | '_top'"

	^ self propertyAt: #formTarget
]

{ #category : #accessing }
WaButton >> formTarget: aString [

	"Used to override the form owner's `target` attribute.
	
	Type: String
	Allowed: '_self' | '_blank' | '_parent' | '_top'"

	self propertyAt: #formTarget put: aString
]

{ #category : #accessing }
WaButton >> href [

	"When set, the underlying button will be rendered as an `<a>` with this `href` instead of a `<button>`.
	
	Type: String"

	^ self propertyAt: #href
]

{ #category : #accessing }
WaButton >> href: aString [

	"When set, the underlying button will be rendered as an `<a>` with this `href` instead of a `<button>`.
	
	Type: String"

	self propertyAt: #href put: aString
]

{ #category : #accessing }
WaButton >> loading [

	"Draws the button in a loading state.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #loading
]

{ #category : #accessing }
WaButton >> loading: aBoolean [

	"Draws the button in a loading state.
	
	Type: Boolean
	Default: false"

	self propertyAt: #loading put: aBoolean
]

{ #category : #accessing }
WaButton >> name [

	"The name of the button, submitted as a name/value pair with form data, but only when this button is the submitter.
	This attribute is ignored when `href` is present.
	
	Type: String"

	^ self propertyAt: #name
]

{ #category : #accessing }
WaButton >> name: aString [

	"The name of the button, submitted as a name/value pair with form data, but only when this button is the submitter.
	This attribute is ignored when `href` is present.
	
	Type: String"

	self propertyAt: #name put: aString
]

{ #category : #accessing }
WaButton >> pill [

	"Draws a pill-style button with rounded edges.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #pill
]

{ #category : #accessing }
WaButton >> pill: aBoolean [

	"Draws a pill-style button with rounded edges.
	
	Type: Boolean
	Default: false"

	self propertyAt: #pill put: aBoolean
]

{ #category : #accessing }
WaButton >> rel [

	"When using `href`, this attribute will map to the underlying link's `rel` attribute.
	
	Type: String"

	^ self propertyAt: #rel
]

{ #category : #accessing }
WaButton >> rel: aString [

	"When using `href`, this attribute will map to the underlying link's `rel` attribute.
	
	Type: String"

	self propertyAt: #rel put: aString
]

{ #category : #actions }
WaButton >> resetValidity [

	"Reset validity is a way of removing manual custom errors and native validation."

	^ self apply: #resetValidity
]

{ #category : #actions }
WaButton >> setCustomValidity: aString [

	"Do not use this when creating a ""Validator"". This is intended for end users of components.
	We track manually defined custom errors so we don't clear them on accident in our validators.
	
	Parameter: message (string)"

	^ self apply: #setCustomValidity withArguments: { aString }
]

{ #category : #accessing }
WaButton >> size [

	"The button's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	^ self propertyAt: #size
]

{ #category : #accessing }
WaButton >> size: aString [

	"The button's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	self propertyAt: #size put: aString
]

{ #category : #accessing }
WaButton >> target [

	"Tells the browser where to open the link. Only used when `href` is present.
	
	Type: String
	Allowed: '_blank' | '_parent' | '_self' | '_top'"

	^ self propertyAt: #target
]

{ #category : #accessing }
WaButton >> target: aString [

	"Tells the browser where to open the link. Only used when `href` is present.
	
	Type: String
	Allowed: '_blank' | '_parent' | '_self' | '_top'"

	self propertyAt: #target put: aString
]

{ #category : #accessing }
WaButton >> type [

	"The type of button. Note that the default value is `button` instead of `submit`, which is opposite of how native
	`<button>` elements behave. When the type is `submit`, the button will submit the surrounding form.
	
	Type: String
	Default: 'button'
	Allowed: 'button' | 'submit' | 'reset'"

	^ self propertyAt: #type
]

{ #category : #accessing }
WaButton >> type: aString [

	"The type of button. Note that the default value is `button` instead of `submit`, which is opposite of how native
	`<button>` elements behave. When the type is `submit`, the button will submit the surrounding form.
	
	Type: String
	Default: 'button'
	Allowed: 'button' | 'submit' | 'reset'"

	self propertyAt: #type put: aString
]

{ #category : #accessing }
WaButton >> validationTarget [

	"Override this to change where constraint validation popups are anchored.
	
	Type: HtmlElement
	Read-only: true"

	^ self propertyAt: #validationTarget
]

{ #category : #accessing }
WaButton >> value [

	"The value of the button, submitted as a pair with the button's name as part of the form data, but only when this
	button is the submitter. This attribute is ignored when `href` is present.
	
	Type: String"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaButton >> value: aString [

	"The value of the button, submitted as a pair with the button's name as part of the form data, but only when this
	button is the submitter. This attribute is ignored when `href` is present.
	
	Type: String"

	self propertyAt: #value put: aString
]

{ #category : #accessing }
WaButton >> variant [

	"The button's theme variant. Defaults to `neutral` if not within another element with a variant.
	
	Type: String
	Default: 'neutral'
	Allowed: 'neutral' | 'brand' | 'success' | 'warning' | 'danger'"

	^ self propertyAt: #variant
]

{ #category : #accessing }
WaButton >> variant: aString [

	"The button's theme variant. Defaults to `neutral` if not within another element with a variant.
	
	Type: String
	Default: 'neutral'
	Allowed: 'neutral' | 'brand' | 'success' | 'warning' | 'danger'"

	self propertyAt: #variant put: aString
]

{ #category : #accessing }
WaButton >> withCaret [

	"Draws the button with a caret. Used to indicate that the button triggers a dropdown menu or similar behavior.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withCaret
]

{ #category : #accessing }
WaButton >> withCaret: aBoolean [

	"Draws the button with a caret. Used to indicate that the button triggers a dropdown menu or similar behavior.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withCaret put: aBoolean
]

{ #category : #accessing }
WaButton >> withEnd [

	"Only required for SSR. Set to `true` if you're slotting in an `end` element so the server-rendered markup
	includes the end slot before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withEnd
]

{ #category : #accessing }
WaButton >> withEnd: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in an `end` element so the server-rendered markup
	includes the end slot before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withEnd put: aBoolean
]

{ #category : #accessing }
WaButton >> withStart [

	"Only required for SSR. Set to `true` if you're slotting in a `start` element so the server-rendered markup
	includes the start slot before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withStart
]

{ #category : #accessing }
WaButton >> withStart: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `start` element so the server-rendered markup
	includes the start slot before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withStart put: aBoolean
]
