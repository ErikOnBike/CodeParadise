"
I represent both the Browser URLSearchParams and the Node.js URLSearchParams.
These classes are similar enough to have to same proxy implementation.
"
Class {
	#name : #CpBrowserURLSearchParams,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Shared'
}

{ #category : #operations }
CpBrowserURLSearchParams >> appendKey: aString value: anObject [

	"Appends a specified key/value pair as a new search parameter."

	self apply: #append withArguments: { aString . anObject }
]

{ #category : #convenience }
CpBrowserURLSearchParams >> asDictionary [

	"Answer a Dictionary containing the entries of the receiver.
	The keys are converted to symbols.

	Implementation:
	In case a key is present more than once, the latest value is kept."

	| dictionary |

	dictionary := Dictionary new.

	"Entries are given as array with the key in the first and value in the second slot"
	self entries do: [ :each |
		dictionary at: each first asSymbol put: each second ].

	^ dictionary
]

{ #category : #operations }
CpBrowserURLSearchParams >> deleteKey: aString [

	"Deletes search parameters that match a name, and optional value, from the list of all search parameters."

	self apply: #append withArguments: { aString }
]

{ #category : #operations }
CpBrowserURLSearchParams >> deleteKey: aString value: anObject [

	"Deletes search parameters that match a name, and optional value, from the list of all search parameters."

	self apply: #append withArguments: { aString . anObject }
]

{ #category : #operations }
CpBrowserURLSearchParams >> entries [

	"Returns an iterator allowing iteration through all key/value pairs contained in this object in the same order as they appear in the query string."

	^ self apply: #entries resultAs: CpJavaScriptIteratorProtocol
]

{ #category : #operations }
CpBrowserURLSearchParams >> forEach: aFunction [

	"Allows iteration through all values contained in this object via a callback function."

	self apply: #forEach withArguments: { aFunction }
]

{ #category : #operations }
CpBrowserURLSearchParams >> getKey: aString [

	"Returns the first value associated with the given search parameter."

	^ self apply: #get withArguments: { aString }
]

{ #category : #operations }
CpBrowserURLSearchParams >> hasKey: aString [

	"Returns a boolean value indicating if a given parameter, or parameter and value pair, exists."

	^ self apply: #has withArguments: { aString }
]

{ #category : #operations }
CpBrowserURLSearchParams >> hasKey: aString value: anObject [

	"Returns a boolean value indicating if a given parameter, or parameter and value pair, exists."

	^ self apply: #has withArguments: { aString . anObject }
]

{ #category : #operations }
CpBrowserURLSearchParams >> keys [

	"Returns an iterator allowing iteration through all keys of the key/value pairs contained in this object."

	^ self apply: #keys resultAs: CpJavaScriptIteratorProtocol
]

{ #category : #operations }
CpBrowserURLSearchParams >> setKey: aString value: anObject [

	"Sets the value associated with a given search parameter to the given value. If there are several values, the others are deleted."

	self apply: #set withArguments: { aString . anObject }
]

{ #category : #accessing }
CpBrowserURLSearchParams >> size [

	"Indicates the total number of search parameter entries."

	^ self propertyAt: #size
]

{ #category : #operations }
CpBrowserURLSearchParams >> sort [

	"Sorts all key/value pairs, if any, by their keys."

	self apply: #sort
]

{ #category : #operations }
CpBrowserURLSearchParams >> toString [

	"Returns a string containing a query string suitable for use in a URL."

	^ self apply: #toString
]

{ #category : #operations }
CpBrowserURLSearchParams >> values [

	"Returns an iterator allowing iteration through all values of the key/value pairs contained in this object."

	^ self apply: #values resultAs: CpJavaScriptIteratorProtocol
]
