Class {
	#name : #CpJavaScriptDate,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Core'
}

{ #category : #accessing }
CpJavaScriptDate class >> dayInMilliseconds [

	"1000 * 60 * 60 * 24"

	^ 86400000
]

{ #category : #accessing }
CpJavaScriptDate class >> dayInSeconds [

	"60 * 60 * 24"

	^ 86400
]

{ #category : #accessing }
CpJavaScriptDate class >> daysBetween: dateRef and: dateComp [

	"Answer the number of days between the specified Dates.
	A positive number means dateRef < dateComp.
	A negative number means dateRef > dateComp.
	A 0 means dateRef = dateComp.

	See #postInstallOnce"

	^ CpGlobalThis apply: #cpDateDaysBetween:and: withArguments: { dateRef . dateComp }
]

{ #category : #'instance creation' }
CpJavaScriptDate class >> fromMilliseconds: anInteger [

	"Answer a new instance of the receiver using the specified number of milliseconds"

	^ self newInstanceWithArguments: { anInteger }
]

{ #category : #'instance creation' }
CpJavaScriptDate class >> fromSeconds: anInteger [

	"Answer a new instance of the receiver using the specified number of seconds"

	^ CpGlobalThis apply: #cpDateFromSeconds: withArguments: { anInteger }
]

{ #category : #'instance creation' }
CpJavaScriptDate class >> fromString: aString [

	"Answer a new instance of the receiver based on the specified String representation"

	^ CpGlobalThis apply: #cpDateFromString: withArguments: { aString }
]

{ #category : #accessing }
CpJavaScriptDate class >> isoStringFromTimestamp: anInteger [

	"Answer an ISO 8601 String representation of the specified timestamp (in seconds)"

	^ (self fromSeconds: anInteger)
		toISOString
]

{ #category : #accessing }
CpJavaScriptDate class >> now [

	"Returns the numeric value corresponding to the current time—the number of milliseconds since January 1, 1970 00:00:00 UTC, with leap seconds ignored."

	^ self apply: #now
]

{ #category : #accessing }
CpJavaScriptDate class >> parse: aString [

	"Parse the specified date String and answer a timestamp in milliseconds.
	Use #fromString: to retrieve an instance of the receiver."

	^ self apply: #parse withArguments: { aString }
]

{ #category : #'class initialization' }
CpJavaScriptDate class >> postInstallOnce [

	"Add some helper functions.

	Add a helper function to answer a new Date based on seconds since Unix epoch.
	Add a helper function to answer a new Date based on a String representation.
	Add a helper function to answer the current timestamp in seconds (instead of milliseconds).
	Add a helper function to answer the timestamp in seconds of a particular Date.
	Add a helper function to find the difference in days between two dates.

	Date object's timestamps are LargeIntegers. By having these convenience methods
	a little less conversion between SmallIntegers and LargeIntegers is required.
	And therefore a little less GC on these instances."

	"cpDateFromString: - Answer a new Date insance based on a String representation"
	CpGlobalThis propertyAt: #cpDateFromString: put: (CpJavaScriptFunction
		method:
'return new Date(Date.parse(str));'
		arguments: #('str')).

	"cpDateFromSeconds: - Answer a new Date instance based on seconds since Unix epoch."
	CpGlobalThis propertyAt: #cpDateFromSeconds: put: (CpJavaScriptFunction
		method:
'return new Date(seconds * 1000);'
		arguments: #('seconds')).

	"cpDateTimestampNow - Answer time as seconds sinde Unix epoch.
	The milliseconds part is stripped of, i.e. no rounding is being performed."
	CpGlobalThis propertyAt: #cpDateTimestampNow put: (CpJavaScriptFunction
		method:
'return Math.floor(Date.now() / 1000);'
		arguments: #()).

	"cpDateTimestampFrom: - Answer the timestamp of a particular date."
	CpGlobalThis propertyAt: #cpDateTimestampFrom: put: (CpJavaScriptFunction
		method:
'return Math.floor(date.getTime() / 1000);'
		arguments: #('date')).

	"cpDateDaysBetween:and: - Answer number of days between two dates.
	1 day = 24 * 60 * 60 * 1000 milliseconds = 86400000 milliseconds"
	CpGlobalThis propertyAt: #cpDateDaysBetween:and: put: (CpJavaScriptFunction
		method:
'let ref = new Date(dateRef);
let comp = new Date(dateComp);
ref.setHours(0, 0, 0, 0);
comp.setHours(0, 0, 0, 0);
return Math.round((comp - ref) / 86400000);'
		arguments: #('dateRef' 'dateComp'))
]

{ #category : #accessing }
CpJavaScriptDate class >> timestampFrom: aDate [

	"Answer the timestamp (seconds since Unix epoch) from the specified Date.

	See #postInstallOnce"

	^ CpGlobalThis apply: #cpDateTimestampFrom: withArguments: { aDate }
]

{ #category : #accessing }
CpJavaScriptDate class >> timestampNow [

	"Answer the current timestamp as seconds since Unix epoch (midnight Jan 1, 1970, UTC).

	See #postInstallOnce"

	^ CpGlobalThis apply: #cpDateTimestampNow
]

{ #category : #'instance creation' }
CpJavaScriptDate class >> today [

	"Answer an instance of the receiver for today (0:00 hrs)"

	^ self newInstance
		resetTime ;
		yourself
]

{ #category : #'instance creation' }
CpJavaScriptDate class >> tomorrow [

	"Answer an instance of the receiver for tomorrow (0:00 hrs)"

	^ (self fromSeconds: self timestampNow + self dayInSeconds)
		resetTime ;
		yourself
]

{ #category : #'instance creation' }
CpJavaScriptDate class >> yesterday [

	"Answer an instance of the receiver for yesterday (0:00 hrs)"

	^ (self fromSeconds: self timestampNow - self dayInSeconds)
		resetTime ;
		yourself
]

{ #category : #comparing }
CpJavaScriptDate >> < aDate [

	^ aDate afterDate: self
]

{ #category : #comparing }
CpJavaScriptDate >> <= aDate [

	^ (aDate beforeDate: self) not
]

{ #category : #comparing }
CpJavaScriptDate >> = aDate [

	^ aDate equalsDate: self
]

{ #category : #comparing }
CpJavaScriptDate >> > aDate [

	^ aDate beforeDate: self
]

{ #category : #comparing }
CpJavaScriptDate >> >= aDate [

	^ (aDate afterDate: self) not
]

{ #category : #comparing }
CpJavaScriptDate >> afterDate: aDate [

	"Compare full, including timestamp"

	^ self time > aDate time
]

{ #category : #comparing }
CpJavaScriptDate >> beforeDate: aDate [

	"Compare full, including timestamp"

	^ self time < aDate time
]

{ #category : #copying }
CpJavaScriptDate >> copy [

	^ self class fromSeconds: self timestamp
]

{ #category : #accessing }
CpJavaScriptDate >> dateString [

	"Answer the date String of the receiver in the format: YYYY-MM-DD.
	Assume year is between 1000 and 9999 (i.e. 4 digits long)."

	^ String streamContents: [ :stream |
		stream
			print: self year ;
			nextPut: $-.
		self printPart: self monthIndex on: stream.
		stream nextPut: $-.
		self printPart: self dayIndex on: stream ]
]

{ #category : #accessing }
CpJavaScriptDate >> dayIndex [

	"Get the day index"

	^ self apply: #getDate
]

{ #category : #accessing }
CpJavaScriptDate >> dayIndex: anInteger [

	"Set the day index"

	self apply: #setDate withArguments: { anInteger }
]

{ #category : #accessing }
CpJavaScriptDate >> dayOfWeekIndex [

	"Get the day of the week index (ISO 8601 based: Monday = 1, Tuesday = 2, ..., Sunday = 7)"

	| index |

	index := self apply: #getDay.
	^ index = 0
		ifTrue: [ 7 ]
		ifFalse: [ index ]
]

{ #category : #accessing }
CpJavaScriptDate >> daysBetween: aDate [

	"Answer the number of days between the receiver and the specified Date.
	A positive value means that the specified Date is in the future (from the
	receiver's perspective). A negative value means that the specified Date is
	in the past (from the receiver's perspective). The value 0 means both Dates
	are the same."

	^ self class
		daysBetween: self and: aDate
]

{ #category : #accessing }
CpJavaScriptDate >> daysInMonth [

	"Answer the number of days in the current month.

	Implementation:
	Create a new Date instance and setting the day to the last day of
	the month and then answer the dayIndex."

	| endOfMonth |

	"Create date on next month and day index 0 => last day of this month.
	All wrapping is performed by the JavaScript Date class."
	endOfMonth := self class
		year: self year month: self monthIndex + 1 day: 0.

	^ endOfMonth dayIndex
]

{ #category : #comparing }
CpJavaScriptDate >> equalsDate: aDate [

	"Compare full, including timestamp"

	^ self time = aDate time
]

{ #category : #comparing }
CpJavaScriptDate >> equalsDateOnly: aDate [

	"Compare date only, ignore time"

	| selfDate compareDate |

	selfDate := self copy ; resetTime ; yourself.
	compareDate := aDate copy ; resetTime ; yourself.

	^ selfDate equalsDate: compareDate
]

{ #category : #accessing }
CpJavaScriptDate >> hours [

	^ self apply: #getHours
]

{ #category : #accessing }
CpJavaScriptDate >> hours: hours [

	self apply: #setHours withArguments: { hours }
]

{ #category : #accessing }
CpJavaScriptDate >> hours: hours minutes: minutes [

	self apply: #setHours withArguments: { hours . minutes }
]

{ #category : #accessing }
CpJavaScriptDate >> hours: hours minutes: minutes seconds: seconds [

	self apply: #setHours withArguments: { hours . minutes . seconds }
]

{ #category : #accessing }
CpJavaScriptDate >> hours: hours minutes: minutes seconds: seconds milliseconds: milliseconds [

	self apply: #setHours withArguments: { hours . minutes . seconds . milliseconds }
]

{ #category : #accessing }
CpJavaScriptDate >> lastWeekdayOfMonthIndex [

	"Answer the max occurrence count (the ordinal value) of the receiver's weekday within
	its current month.
	I.e.
		2025-01-01 is a Wednesday. For this date the weekdayOfMonthIndex = 1
		2025-01-08 is a Wednesday. For this date the weekdayOfMonthIndex = 2
		etc.
	The maximum index value any weekday can have within a month is 5.
	For January 2025 there are 5 Wednesdays: 1, 8, 15, 22, 29.
	Some weekdays have only 4 occurrences (never less since smallest month has 28 days).
	For January 2025 there are 4 Tuesdays: 7, 14, 21, 28."

	^ self weekdayOfMonthIndex + ((self daysInMonth - self dayIndex) // 7)
]

{ #category : #accessing }
CpJavaScriptDate >> milliseconds [

	^ self apply: #getMilliseconds
]

{ #category : #accessing }
CpJavaScriptDate >> milliseconds: milliseconds [

	self apply: #setMilliseconds withArguments: { milliseconds }
]

{ #category : #accessing }
CpJavaScriptDate >> minutes [

	^ self apply: #getMinutes
]

{ #category : #accessing }
CpJavaScriptDate >> minutes: minutes [

	self apply: #setMinutes withArguments: { minutes }
]

{ #category : #accessing }
CpJavaScriptDate >> minutes: minutes seconds: seconds [

	self apply: #setMinutes withArguments: { minutes . seconds }
]

{ #category : #accessing }
CpJavaScriptDate >> minutes: minutes seconds: seconds milliseconds: milliseconds [

	self apply: #setMinutes withArguments: { minutes . seconds . milliseconds }
]

{ #category : #accessing }
CpJavaScriptDate >> month [

	"Get the month (BE AWARE this is JavaScript style 0-based index)"

	^ self apply: #getMonth
]

{ #category : #accessing }
CpJavaScriptDate >> month: anInteger [

	"Set the month (BE AWARE this is JavaScript style 0-based index)"

	self apply: #setMonth withArguments: { anInteger }
]

{ #category : #accessing }
CpJavaScriptDate >> monthIndex [

	"Get the month index (BE AWARE this is Smalltalk style 1-based index)"

	^ self month + 1
]

{ #category : #accessing }
CpJavaScriptDate >> monthIndex: anInteger [

	"Set the month index (BE AWARE this is Smalltalk style 1-based index)"

	self month: anInteger - 1
]

{ #category : #private }
CpJavaScriptDate >> printPart: anInteger on: aStream [

	anInteger < 10
		ifTrue: [ aStream nextPut: $0 ].
	aStream print: anInteger
]

{ #category : #accessing }
CpJavaScriptDate >> resetTime [

	"Reset the time part of the receiver"

	self hours: 0 minutes: 0 seconds: 0 milliseconds: 0
]

{ #category : #accessing }
CpJavaScriptDate >> seconds [

	^ self apply: #getSeconds
]

{ #category : #accessing }
CpJavaScriptDate >> seconds: seconds [

	self apply: #setSeconds withArguments: { seconds }
]

{ #category : #accessing }
CpJavaScriptDate >> seconds: seconds milliseconds: milliseconds [

	self apply: #setSeconds withArguments: { seconds . milliseconds }
]

{ #category : #accessing }
CpJavaScriptDate >> shortTimeString [

	"Answer the time String of the receiver in the format: HH:mm"

	^ String streamContents: [ :stream |
		self printPart: self hours on: stream.
		stream nextPut: $:.
		self printPart: self minutes on: stream ]
]

{ #category : #accessing }
CpJavaScriptDate >> time [

	"Answer the milliseconds since unix epoch (see class methods #timestamp and #now)"

	^ self apply: #getTime
]

{ #category : #accessing }
CpJavaScriptDate >> timeString [

	"Answer the time String of the receiver in the format: HH:mm:ss"

	^ String streamContents: [ :stream |
		self printPart: self hours on: stream.
		stream nextPut: $:.
		self printPart: self minutes on: stream.
		stream nextPut: $:.
		self printPart: self seconds on: stream ]
]

{ #category : #accessing }
CpJavaScriptDate >> timestamp [

	"Answer the seconds since unix epoch (see class methods #timestamp and #now)"

	^ self class
		timestampFrom: self
]

{ #category : #accessing }
CpJavaScriptDate >> toISOString [

	^ self apply: #toISOString
]

{ #category : #accessing }
CpJavaScriptDate >> weekdayOfMonthIndex [

	"Answer the occurrence count (the ordinal value) of the receiver's weekday within
	its current month.
	I.e.
		2025-01-01 is a Wednesday. For this date the weekdayOfMonthIndex = 1
		2025-01-08 is a Wednesday. For this date the weekdayOfMonthIndex = 2
		etc.
	The maximum index value any weekday can have within a month is 5.
	For January 2025 there are 5 Wednesdays: 1, 8, 15, 22, 29.
	Some weekdays have only 4 occurrences (never less since smallest month has 28 days).
	For January 2025 there are 4 Tuesdays: 7, 14, 21, 28.

	The current occurrence can therefore be any number between 1 and 5."

	^ ((self dayIndex - 1) // 7) + 1
]

{ #category : #accessing }
CpJavaScriptDate >> year [

	"Get the year"

	^ self apply: #getFullYear
]

{ #category : #accessing }
CpJavaScriptDate >> year: anInteger [

	"Set the year"

	self apply: #setFullYear withArguments: { anInteger }
]
