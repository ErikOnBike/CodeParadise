"
I represent the Intl.PluralRules in Browser and Node.js.
"
Class {
	#name : #CpBrowserPluralRules,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Shared'
}

{ #category : #'instance creation' }
CpBrowserPluralRules class >> cardinalLocale: aString [

	"Answer a new instance of the receiver for the specified locale"

	^ self locale: aString type: #cardinal
]

{ #category : #accessing }
CpBrowserPluralRules class >> getClass [

	^ CpBrowserIntl namespace
		getClass: self
]

{ #category : #'instance creation' }
CpBrowserPluralRules class >> locale: aString [

	"Answer a new instance of the receiver for the specified locale (cardinal by default)"

	^ self newInstanceWithArguments: { aString }
]

{ #category : #'instance creation' }
CpBrowserPluralRules class >> locale: aString type: aSymbol [

	"Answer a new instance of the receiver for the specified locale"

	^ self newInstanceWithArguments: { aString . { #type -> aSymbol } asDictionary }
]

{ #category : #'instance creation' }
CpBrowserPluralRules class >> ordinalLocale: aString [

	"Answer a new instance of the receiver for the specified locale"

	^ self locale: aString type: #ordinal
]

{ #category : #operations }
CpBrowserPluralRules >> resolvedOptions [

	"Returns a new object with properties reflecting the locale and collation options computed during initialization of the object"

	^ self apply: #resolvedOptions
]

{ #category : #operations }
CpBrowserPluralRules >> select: anInteger [

	"Returns a string indicating which plural rule to use for locale-aware formatting"

	^ self apply: #select withArguments: { anInteger }
]

{ #category : #operations }
CpBrowserPluralRules >> selectRange: fromInteger to: toInteger [

	"This method receives two values and returns a string indicating which plural rule to use for locale-aware formatting"

	^ self apply: #selectRange withArguments: { fromInteger . toInteger }
]
