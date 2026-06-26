Class {
	#name : #WaFormatNumber,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #convenience }
WaFormatNumber >> beWithGrouping [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutGrouping: false
]

{ #category : #convenience }
WaFormatNumber >> beWithoutGrouping [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutGrouping: true
]

{ #category : #accessing }
WaFormatNumber >> currency [

	"The [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217) currency code to use when formatting.
	
	Type: String
	Default: 'USD'"

	^ self propertyAt: #currency
]

{ #category : #accessing }
WaFormatNumber >> currency: aString [

	"The [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217) currency code to use when formatting.
	
	Type: String
	Default: 'USD'"

	self propertyAt: #currency put: aString
]

{ #category : #accessing }
WaFormatNumber >> currencyDisplay [

	"How to display the currency.
	
	Type: String
	Default: 'symbol'
	Allowed: 'symbol' | 'narrowSymbol' | 'code' | 'name'"

	^ self propertyAt: #currencyDisplay
]

{ #category : #accessing }
WaFormatNumber >> currencyDisplay: aString [

	"How to display the currency.
	
	Type: String
	Default: 'symbol'
	Allowed: 'symbol' | 'narrowSymbol' | 'code' | 'name'"

	self propertyAt: #currencyDisplay put: aString
]

{ #category : #accessing }
WaFormatNumber >> maximumFractionDigits [

	"The maximum number of fraction digits to use. Possible values are 0-100.
	
	Type: Number"

	^ self propertyAt: #maximumFractionDigits
]

{ #category : #accessing }
WaFormatNumber >> maximumFractionDigits: aNumber [

	"The maximum number of fraction digits to use. Possible values are 0-100.
	
	Type: Number"

	self propertyAt: #maximumFractionDigits put: aNumber
]

{ #category : #accessing }
WaFormatNumber >> maximumSignificantDigits [

	"The maximum number of significant digits to use,. Possible values are 1-21.
	
	Type: Number"

	^ self propertyAt: #maximumSignificantDigits
]

{ #category : #accessing }
WaFormatNumber >> maximumSignificantDigits: aNumber [

	"The maximum number of significant digits to use,. Possible values are 1-21.
	
	Type: Number"

	self propertyAt: #maximumSignificantDigits put: aNumber
]

{ #category : #accessing }
WaFormatNumber >> minimumFractionDigits [

	"The minimum number of fraction digits to use. Possible values are 0-100.
	
	Type: Number"

	^ self propertyAt: #minimumFractionDigits
]

{ #category : #accessing }
WaFormatNumber >> minimumFractionDigits: aNumber [

	"The minimum number of fraction digits to use. Possible values are 0-100.
	
	Type: Number"

	self propertyAt: #minimumFractionDigits put: aNumber
]

{ #category : #accessing }
WaFormatNumber >> minimumIntegerDigits [

	"The minimum number of integer digits to use. Possible values are 1-21.
	
	Type: Number"

	^ self propertyAt: #minimumIntegerDigits
]

{ #category : #accessing }
WaFormatNumber >> minimumIntegerDigits: aNumber [

	"The minimum number of integer digits to use. Possible values are 1-21.
	
	Type: Number"

	self propertyAt: #minimumIntegerDigits put: aNumber
]

{ #category : #accessing }
WaFormatNumber >> minimumSignificantDigits [

	"The minimum number of significant digits to use. Possible values are 1-21.
	
	Type: Number"

	^ self propertyAt: #minimumSignificantDigits
]

{ #category : #accessing }
WaFormatNumber >> minimumSignificantDigits: aNumber [

	"The minimum number of significant digits to use. Possible values are 1-21.
	
	Type: Number"

	self propertyAt: #minimumSignificantDigits put: aNumber
]

{ #category : #accessing }
WaFormatNumber >> type [

	"The formatting style to use.
	
	Type: String
	Default: 'decimal'
	Allowed: 'currency' | 'decimal' | 'percent'"

	^ self propertyAt: #type
]

{ #category : #accessing }
WaFormatNumber >> type: aString [

	"The formatting style to use.
	
	Type: String
	Default: 'decimal'
	Allowed: 'currency' | 'decimal' | 'percent'"

	self propertyAt: #type put: aString
]

{ #category : #accessing }
WaFormatNumber >> value [

	"The number to format.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaFormatNumber >> value: aNumber [

	"The number to format.
	
	Type: Number
	Default: 0"

	self propertyAt: #value put: aNumber
]

{ #category : #accessing }
WaFormatNumber >> withoutGrouping [

	"Turns off grouping separators.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withoutGrouping
]

{ #category : #accessing }
WaFormatNumber >> withoutGrouping: aBoolean [

	"Turns off grouping separators.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withoutGrouping put: aBoolean
]
