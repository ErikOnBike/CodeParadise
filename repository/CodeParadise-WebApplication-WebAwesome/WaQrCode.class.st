Class {
	#name : #WaQrCode,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaQrCode >> background [

	"The background color. This can be any valid CSS color or `transparent`. It cannot be a CSS custom property.
	
	Type: String
	Default: ''"

	^ self propertyAt: #background
]

{ #category : #accessing }
WaQrCode >> background: aString [

	"The background color. This can be any valid CSS color or `transparent`. It cannot be a CSS custom property.
	
	Type: String
	Default: ''"

	self propertyAt: #background put: aString
]

{ #category : #accessing }
WaQrCode >> errorCorrection [

	"The level of error correction to use. [Learn more](https://www.qrcode.com/en/about/error_correction.html)
	
	Type: String
	Default: 'H'
	Allowed: 'L' | 'M' | 'Q' | 'H'"

	^ self propertyAt: #errorCorrection
]

{ #category : #accessing }
WaQrCode >> errorCorrection: aString [

	"The level of error correction to use. [Learn more](https://www.qrcode.com/en/about/error_correction.html)
	
	Type: String
	Default: 'H'
	Allowed: 'L' | 'M' | 'Q' | 'H'"

	self propertyAt: #errorCorrection put: aString
]

{ #category : #accessing }
WaQrCode >> fill [

	"The fill color. This can be any valid CSS color, but not a CSS custom property.
	
	Type: String
	Default: ''"

	^ self propertyAt: #fill
]

{ #category : #accessing }
WaQrCode >> fill: aString [

	"The fill color. This can be any valid CSS color, but not a CSS custom property.
	
	Type: String
	Default: ''"

	self propertyAt: #fill put: aString
]

{ #category : #accessing }
WaQrCode >> label [

	"The label for assistive devices to announce. If unspecified, the value will be used instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaQrCode >> label: aString [

	"The label for assistive devices to announce. If unspecified, the value will be used instead.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #accessing }
WaQrCode >> radius [

	"The edge radius of each module. Must be between 0 and 0.5.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #radius
]

{ #category : #accessing }
WaQrCode >> radius: aNumber [

	"The edge radius of each module. Must be between 0 and 0.5.
	
	Type: Number
	Default: 0"

	self propertyAt: #radius put: aNumber
]

{ #category : #accessing }
WaQrCode >> size [

	"The size of the QR code, in pixels.
	
	Type: Number
	Default: 128"

	^ self propertyAt: #size
]

{ #category : #accessing }
WaQrCode >> size: aNumber [

	"The size of the QR code, in pixels.
	
	Type: Number
	Default: 128"

	self propertyAt: #size put: aNumber
]

{ #category : #accessing }
WaQrCode >> value [

	"The QR code's value.
	
	Type: String
	Default: ''"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaQrCode >> value: aString [

	"The QR code's value.
	
	Type: String
	Default: ''"

	self propertyAt: #value put: aString
]
