Class {
	#name : #WaIcon,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaIcon >> animation [

	"Sets the animation for the icon
	
	Type: String
	Allowed: 'beat' | 'fade' | 'beat-fade' | 'bounce' | 'flip' | 'shake' | 'spin' | 'spin-pulse' | 'spin-reverse'"

	^ self propertyAt: #animation
]

{ #category : #accessing }
WaIcon >> animation: aString [

	"Sets the animation for the icon
	
	Type: String
	Allowed: 'beat' | 'fade' | 'beat-fade' | 'bounce' | 'flip' | 'shake' | 'spin' | 'spin-pulse' | 'spin-reverse'"

	self propertyAt: #animation put: aString
]

{ #category : #accessing }
WaIcon >> autoWidth [

	"Sets the width of the icon to match the cropped SVG viewBox. This operates like the Font `fa-width-auto` class.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #autoWidth
]

{ #category : #accessing }
WaIcon >> autoWidth: aBoolean [

	"Sets the width of the icon to match the cropped SVG viewBox. This operates like the Font `fa-width-auto` class.
	
	Type: Boolean
	Default: false"

	self propertyAt: #autoWidth put: aBoolean
]

{ #category : #'accessing - convenience' }
WaIcon >> beAutoWidth [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autoWidth: true
]

{ #category : #'accessing - convenience' }
WaIcon >> beNotAutoWidth [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autoWidth: false
]

{ #category : #'accessing - convenience' }
WaIcon >> beNotSwapOpacity [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self swapOpacity: false
]

{ #category : #'accessing - convenience' }
WaIcon >> beSwapOpacity [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self swapOpacity: true
]

{ #category : #accessing }
WaIcon >> family [

	"The family of icons to choose from. For Font Awesome Free, valid options include `classic` and `brands`. For
	Font Awesome Pro subscribers, valid options include, `classic`, `sharp`, `duotone`, `sharp-duotone`, and `brands`.
	A valid kit code must be present to show pro icons via CDN. You can set `<html data-fa-kit-code=""..."">` to provide
	one.
	
	Type: String"

	^ self propertyAt: #family
]

{ #category : #accessing }
WaIcon >> family: aString [

	"The family of icons to choose from. For Font Awesome Free, valid options include `classic` and `brands`. For
	Font Awesome Pro subscribers, valid options include, `classic`, `sharp`, `duotone`, `sharp-duotone`, and `brands`.
	A valid kit code must be present to show pro icons via CDN. You can set `<html data-fa-kit-code=""..."">` to provide
	one.
	
	Type: String"

	self propertyAt: #family put: aString
]

{ #category : #accessing }
WaIcon >> flip [

	"Sets the flip direction of the icon along the 'x' (horizontal), 'y' (vertical), or 'both' axes.
	
	Type: String
	Allowed: 'x' | 'y' | 'both'"

	^ self propertyAt: #flip
]

{ #category : #accessing }
WaIcon >> flip: aString [

	"Sets the flip direction of the icon along the 'x' (horizontal), 'y' (vertical), or 'both' axes.
	
	Type: String
	Allowed: 'x' | 'y' | 'both'"

	self propertyAt: #flip put: aString
]

{ #category : #accessing }
WaIcon >> label [

	"An alternate description to use for assistive devices. If omitted, the icon will be considered presentational and
	ignored by assistive devices.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaIcon >> label: aString [

	"An alternate description to use for assistive devices. If omitted, the icon will be considered presentational and
	ignored by assistive devices.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #accessing }
WaIcon >> library [

	"The name of a registered custom icon library.
	
	Type: String
	Default: 'default'"

	^ self propertyAt: #library
]

{ #category : #accessing }
WaIcon >> library: aString [

	"The name of a registered custom icon library.
	
	Type: String
	Default: 'default'"

	self propertyAt: #library put: aString
]

{ #category : #accessing }
WaIcon >> name [

	"The name of the icon to draw. Available names depend on the icon library being used.
	
	Type: String"

	^ self propertyAt: #name
]

{ #category : #accessing }
WaIcon >> name: aString [

	"The name of the icon to draw. Available names depend on the icon library being used.
	
	Type: String"

	self propertyAt: #name put: aString
]

{ #category : #accessing }
WaIcon >> rotate [

	"Sets the rotation degree of the icon
	
	Type: Number
	Default: 0"

	^ self propertyAt: #rotate
]

{ #category : #accessing }
WaIcon >> rotate: aNumber [

	"Sets the rotation degree of the icon
	
	Type: Number
	Default: 0"

	self propertyAt: #rotate put: aNumber
]

{ #category : #accessing }
WaIcon >> src [

	"An external URL of an SVG file. Be sure you trust the content you are including, as it will be executed as code and
	can result in XSS attacks.
	
	Type: String"

	^ self propertyAt: #src
]

{ #category : #accessing }
WaIcon >> src: aString [

	"An external URL of an SVG file. Be sure you trust the content you are including, as it will be executed as code and
	can result in XSS attacks.
	
	Type: String"

	self propertyAt: #src put: aString
]

{ #category : #accessing }
WaIcon >> swapOpacity [

	"Swaps the opacity of duotone icons.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #swapOpacity
]

{ #category : #accessing }
WaIcon >> swapOpacity: aBoolean [

	"Swaps the opacity of duotone icons.
	
	Type: Boolean
	Default: false"

	self propertyAt: #swapOpacity put: aBoolean
]

{ #category : #accessing }
WaIcon >> variant [

	"The name of the icon's variant. For Font Awesome, valid options include `thin`, `light`, `regular`, and `solid` for
	the `classic` and `sharp` families. Some variants require a Font Awesome Pro subscription. Custom icon libraries
	may or may not use this property.
	
	Type: String"

	^ self propertyAt: #variant
]

{ #category : #accessing }
WaIcon >> variant: aString [

	"The name of the icon's variant. For Font Awesome, valid options include `thin`, `light`, `regular`, and `solid` for
	the `classic` and `sharp` families. Some variants require a Font Awesome Pro subscription. Custom icon libraries
	may or may not use this property.
	
	Type: String"

	self propertyAt: #variant put: aString
]
