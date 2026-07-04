Class {
	#name : #WaRelativeTime,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - convenience' }
WaRelativeTime >> beNotSync [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self sync: false
]

{ #category : #'accessing - convenience' }
WaRelativeTime >> beSync [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self sync: true
]

{ #category : #accessing }
WaRelativeTime >> date [

	"The date from which to calculate time from. If not set, the current date and time will be used. When passing a
	string, it's strongly recommended to use the ISO 8601 format to ensure timezones are handled correctly. To convert
	a date to this format in JavaScript, use [`date.toISOString()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/toISOString).
	
	Type: DateOrString
	Default: 'DateAndTime now'"

	^ self propertyAt: #date
]

{ #category : #accessing }
WaRelativeTime >> date: aDateOrString [

	"The date from which to calculate time from. If not set, the current date and time will be used. When passing a
	string, it's strongly recommended to use the ISO 8601 format to ensure timezones are handled correctly. To convert
	a date to this format in JavaScript, use [`date.toISOString()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/toISOString).
	
	Type: DateOrString
	Default: 'DateAndTime now'"

	self propertyAt: #date put: aDateOrString
]

{ #category : #accessing }
WaRelativeTime >> format [

	"The formatting style to use.
	
	Type: String
	Default: 'long'
	Allowed: 'long' | 'short' | 'narrow'"

	^ self propertyAt: #format
]

{ #category : #accessing }
WaRelativeTime >> format: aString [

	"The formatting style to use.
	
	Type: String
	Default: 'long'
	Allowed: 'long' | 'short' | 'narrow'"

	self propertyAt: #format put: aString
]

{ #category : #accessing }
WaRelativeTime >> numeric [

	"When `auto`, values such as ""yesterday"" and ""tomorrow"" will be shown when possible. When `always`, values such as
	""1 day ago"" and ""in 1 day"" will be shown.
	
	Type: String
	Default: 'auto'
	Allowed: 'always' | 'auto'"

	^ self propertyAt: #numeric
]

{ #category : #accessing }
WaRelativeTime >> numeric: aString [

	"When `auto`, values such as ""yesterday"" and ""tomorrow"" will be shown when possible. When `always`, values such as
	""1 day ago"" and ""in 1 day"" will be shown.
	
	Type: String
	Default: 'auto'
	Allowed: 'always' | 'auto'"

	self propertyAt: #numeric put: aString
]

{ #category : #accessing }
WaRelativeTime >> sync [

	"Keep the displayed value up to date as time passes.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #sync
]

{ #category : #accessing }
WaRelativeTime >> sync: aBoolean [

	"Keep the displayed value up to date as time passes.
	
	Type: Boolean
	Default: false"

	self propertyAt: #sync put: aBoolean
]
