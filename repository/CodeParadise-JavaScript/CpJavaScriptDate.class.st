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

{ #category : #'instance creation' }
CpJavaScriptDate class >> fromMilliseconds: anInteger [

	"Answer a new instance of the receiver using the specified number of milliseconds"

	^ self newInstanceWithArguments: { anInteger }
]

{ #category : #'instance creation' }
CpJavaScriptDate class >> fromSeconds: anInteger [

	"Answer a new instance of the receiver using the specified number of seconds"

	^ self fromMilliseconds: anInteger * 1000
]

{ #category : #'instance creation' }
CpJavaScriptDate class >> fromString: aString [

	"Answer a new instance of the receiver based on the specified String representation"

	^ self fromMilliseconds: (self parse: aString)
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

	"Parse the specified date String and answer a timestamp in milliseconds"

	^ self apply: #parse withArguments: { aString }
]

{ #category : #accessing }
CpJavaScriptDate class >> timestampNow [

	"Answer the current timestamp as seconds since Unix epoch (midnight Jan 1, 1970, UTC).

	Implementation:
	The milliseconds part is stripped of, i.e. no rounding is being performed."

	^ self now // 1000
]

{ #category : #'instance creation' }
CpJavaScriptDate class >> today [

	"Answer an instance of the receiver for today (0:00 hrs)"

	^ (self fromMilliseconds: self now)
		resetTime ;
		yourself
]

{ #category : #'instance creation' }
CpJavaScriptDate class >> tomorrow [

	"Answer an instance of the receiver for tomorrow (0:00 hrs)"

	^ (self fromMilliseconds: self now + self dayInMilliseconds)
		resetTime ;
		yourself
]

{ #category : #'instance creation' }
CpJavaScriptDate class >> yesterday [

	"Answer an instance of the receiver for yesterday (0:00 hrs)"

	^ (self fromMilliseconds: self now - self dayInMilliseconds)
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

	^ self class fromMilliseconds: self time
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

	self apply: #getDate withArguments: { anInteger }
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

	^ self time // 1000
]

{ #category : #accessing }
CpJavaScriptDate >> toISOString [

	^ self apply: #toISOString
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
