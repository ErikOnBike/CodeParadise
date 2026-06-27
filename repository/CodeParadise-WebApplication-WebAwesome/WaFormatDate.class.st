Class {
	#name : #WaFormatDate,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaFormatDate >> date [

	"The date/time to format. If not set, the current date and time will be used. When passing a string, it's strongly
	recommended to use the ISO 8601 format to ensure timezones are handled correctly. To convert a date to this format
	in JavaScript, use [`date.toISOString()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/toISOString).
	
	Type: DateOrString
	Default: 'DateAndTime now'"

	^ self propertyAt: #date
]

{ #category : #accessing }
WaFormatDate >> date: aDateOrString [

	"The date/time to format. If not set, the current date and time will be used. When passing a string, it's strongly
	recommended to use the ISO 8601 format to ensure timezones are handled correctly. To convert a date to this format
	in JavaScript, use [`date.toISOString()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/toISOString).
	
	Type: DateOrString
	Default: 'DateAndTime now'"

	self propertyAt: #date put: aDateOrString
]

{ #category : #accessing }
WaFormatDate >> day [

	"The format for displaying the day.
	
	Type: String
	Allowed: 'numeric' | '2-digit'"

	^ self propertyAt: #day
]

{ #category : #accessing }
WaFormatDate >> day: aString [

	"The format for displaying the day.
	
	Type: String
	Allowed: 'numeric' | '2-digit'"

	self propertyAt: #day put: aString
]

{ #category : #accessing }
WaFormatDate >> era [

	"The format for displaying the era.
	
	Type: String
	Allowed: 'narrow' | 'short' | 'long'"

	^ self propertyAt: #era
]

{ #category : #accessing }
WaFormatDate >> era: aString [

	"The format for displaying the era.
	
	Type: String
	Allowed: 'narrow' | 'short' | 'long'"

	self propertyAt: #era put: aString
]

{ #category : #accessing }
WaFormatDate >> hour [

	"The format for displaying the hour.
	
	Type: String
	Allowed: 'numeric' | '2-digit'"

	^ self propertyAt: #hour
]

{ #category : #accessing }
WaFormatDate >> hour: aString [

	"The format for displaying the hour.
	
	Type: String
	Allowed: 'numeric' | '2-digit'"

	self propertyAt: #hour put: aString
]

{ #category : #accessing }
WaFormatDate >> hourFormat [

	"The format for displaying the hour.
	
	Type: String
	Default: 'auto'
	Allowed: 'auto' | '12' | '24'"

	^ self propertyAt: #hourFormat
]

{ #category : #accessing }
WaFormatDate >> hourFormat: aString [

	"The format for displaying the hour.
	
	Type: String
	Default: 'auto'
	Allowed: 'auto' | '12' | '24'"

	self propertyAt: #hourFormat put: aString
]

{ #category : #accessing }
WaFormatDate >> minute [

	"The format for displaying the minute.
	
	Type: String
	Allowed: 'numeric' | '2-digit'"

	^ self propertyAt: #minute
]

{ #category : #accessing }
WaFormatDate >> minute: aString [

	"The format for displaying the minute.
	
	Type: String
	Allowed: 'numeric' | '2-digit'"

	self propertyAt: #minute put: aString
]

{ #category : #accessing }
WaFormatDate >> month [

	"The format for displaying the month.
	
	Type: String
	Allowed: 'numeric' | '2-digit' | 'narrow' | 'short' | 'long'"

	^ self propertyAt: #month
]

{ #category : #accessing }
WaFormatDate >> month: aString [

	"The format for displaying the month.
	
	Type: String
	Allowed: 'numeric' | '2-digit' | 'narrow' | 'short' | 'long'"

	self propertyAt: #month put: aString
]

{ #category : #accessing }
WaFormatDate >> second [

	"The format for displaying the second.
	
	Type: String
	Allowed: 'numeric' | '2-digit'"

	^ self propertyAt: #second
]

{ #category : #accessing }
WaFormatDate >> second: aString [

	"The format for displaying the second.
	
	Type: String
	Allowed: 'numeric' | '2-digit'"

	self propertyAt: #second put: aString
]

{ #category : #accessing }
WaFormatDate >> timeZone [

	"The time zone to express the time in.
	
	Type: String"

	^ self propertyAt: #timeZone
]

{ #category : #accessing }
WaFormatDate >> timeZone: aString [

	"The time zone to express the time in.
	
	Type: String"

	self propertyAt: #timeZone put: aString
]

{ #category : #accessing }
WaFormatDate >> timeZoneName [

	"The format for displaying the time.
	
	Type: String
	Allowed: 'short' | 'long'"

	^ self propertyAt: #timeZoneName
]

{ #category : #accessing }
WaFormatDate >> timeZoneName: aString [

	"The format for displaying the time.
	
	Type: String
	Allowed: 'short' | 'long'"

	self propertyAt: #timeZoneName put: aString
]

{ #category : #accessing }
WaFormatDate >> weekday [

	"The format for displaying the weekday.
	
	Type: String
	Allowed: 'narrow' | 'short' | 'long'"

	^ self propertyAt: #weekday
]

{ #category : #accessing }
WaFormatDate >> weekday: aString [

	"The format for displaying the weekday.
	
	Type: String
	Allowed: 'narrow' | 'short' | 'long'"

	self propertyAt: #weekday put: aString
]

{ #category : #accessing }
WaFormatDate >> year [

	"The format for displaying the year.
	
	Type: String
	Allowed: 'numeric' | '2-digit'"

	^ self propertyAt: #year
]

{ #category : #accessing }
WaFormatDate >> year: aString [

	"The format for displaying the year.
	
	Type: String
	Allowed: 'numeric' | '2-digit'"

	self propertyAt: #year put: aString
]
