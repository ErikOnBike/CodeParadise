"
I am a utility Class to create DateStrings.
I am able to create and manipulate Strings in the format: <yyyy>-<mm>-<dd>

I am implemented using the default JavaScript Date class. At some point I should be
replaced by the Dates in the JavaScript Temporal namespace, but it is not yet
available in all browsers.

"
Class {
	#name : #CynDateString,
	#superclass : #Object,
	#category : #'CodeParadise-Canyon-Model-Support'
}

{ #category : #support }
CynDateString class >> addDays: anInteger to: aString [

	"Create a new DateString by adding days to an existing DateString"

	| date |

	date := self parseString: aString.

	date at: 3 put: (date at: 3) + anInteger.

	^ self createDateString: date
]

{ #category : #private }
CynDateString class >> createDateString: anArray [

	"Create a Date string representation from the specified internal model.
	The internal model can have overflow or underflow values for certain
	values, which are converted to create a valid date. Like month 14 will
	result in an additional year and the month becoming 2.

	Implementation:
	The internal model uses an array to store: year, month, day."

	| dateArgs date |

	"Convert possibly overflow or underflow month or day index using JavaScript's
	Date constructor. Remember months are 0-based indexed."
	dateArgs := Array new: 3 streamContents: [ :stream |
		stream
			nextPut: (anArray at: 1) ;
			nextPut: (anArray at: 2) - 1 ;
			nextPut: (anArray at: 3) ].

	date := CpJavaScriptObject newInstanceFor: #Date withArguments: dateArgs.

	^ self jsDateToString: date
]

{ #category : #private }
CynDateString class >> jsDateToString: aJavaScriptDate [

	"Convert JavaScript date instance to a String with format: <yyyy-mm-dd>

	Assuming years are in the <1000 - 9999> range ;-)"

	^ String new: 10 streamContents: [ :stream |
		| month day |
		stream
			print: (aJavaScriptDate apply: #getFullYear) ;
			nextPut: $-.
		(month := (aJavaScriptDate apply: #getMonth) + 1) < 10
			ifTrue: [ stream nextPut: $0 ].
		stream
			print: month ;
			nextPut: $-.
		(day := aJavaScriptDate apply: #getDate) < 10
			ifTrue: [ stream nextPut: $0 ].
		stream print: day ]
]

{ #category : #private }
CynDateString class >> parseString: aString [

	"Convert the date String to an Array of Integers.
	The input String is assumed to be formatted: <yyyy-mm-dd>
	The resulting Array contains (in order): year, month, day

	Implementation:
	Extract parts and convert parts to integers. For a little efficiency,
	create Array manually instead of using #collect: and then #asArray."

	| parts |

	parts := aString findTokens: $-.

	^ Array new: 3 streamContents: [ :stream |
		parts do: [ :each | stream nextPut: each asNumber ] ]
]

{ #category : #support }
CynDateString class >> today [

	"Answer a DateString for today"

	^ self jsDateToString: (CpJavaScriptObject newInstanceFor: #Date)
]

{ #category : #support }
CynDateString class >> tomorrow [

	"Answer a DateString for tomorrow"

	^ self addDays: 1 to: self today
]
