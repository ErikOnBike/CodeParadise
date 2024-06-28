Class {
	#name : #CpJavaScriptURLSearchParams,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #operations }
CpJavaScriptURLSearchParams >> appendKey: aString value: anObject [

	"Appends a specified key/value pair as a new search parameter."

	self apply: #append withArguments: { aString . anObject }
]

{ #category : #operations }
CpJavaScriptURLSearchParams >> deleteKey: aString [

	"Deletes search parameters that match a name, and optional value, from the list of all search parameters."

	self apply: #append withArguments: { aString }
]

{ #category : #operations }
CpJavaScriptURLSearchParams >> deleteKey: aString value: anObject [

	"Deletes search parameters that match a name, and optional value, from the list of all search parameters."

	self apply: #append withArguments: { aString . anObject }
]

{ #category : #operations }
CpJavaScriptURLSearchParams >> forEach: aFunction [

	"Allows iteration through all values contained in this object via a callback function."

	self apply: #forEach withArguments: { aFunction }
]

{ #category : #operations }
CpJavaScriptURLSearchParams >> getKey: aString [

	"Returns the first value associated with the given search parameter."

	^ self apply: #get withArguments: { aString }
]

{ #category : #operations }
CpJavaScriptURLSearchParams >> hasKey: aString [

	"Returns a boolean value indicating if a given parameter, or parameter and value pair, exists."

	^ self apply: #has withArguments: { aString }
]

{ #category : #operations }
CpJavaScriptURLSearchParams >> hasKey: aString value: anObject [

	"Returns a boolean value indicating if a given parameter, or parameter and value pair, exists."

	^ self apply: #has withArguments: { aString . anObject }
]

{ #category : #operations }
CpJavaScriptURLSearchParams >> setKey: aString value: anObject [

	"Sets the value associated with a given search parameter to the given value. If there are several values, the others are deleted."

	self apply: #set withArguments: { aString . anObject }
]

{ #category : #accessing }
CpJavaScriptURLSearchParams >> size [

	"Indicates the total number of search parameter entries."

	^ self propertyAt: #size
]

{ #category : #operations }
CpJavaScriptURLSearchParams >> sort [

	"Sorts all key/value pairs, if any, by their keys."

	self apply: #sort
]

{ #category : #operations }
CpJavaScriptURLSearchParams >> toString [

	"Returns a string containing a query string suitable for use in a URL."

	^ self apply: #toString
]
