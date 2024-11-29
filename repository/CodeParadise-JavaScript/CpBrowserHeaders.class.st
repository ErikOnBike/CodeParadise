"
I represent both the Browser Headers and the Node.js Headers.
These classes are similar enough to have to same proxy implementation.
"
Class {
	#name : #CpBrowserHeaders,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Shared'
}

{ #category : #'instance creation' }
CpBrowserHeaders class >> init: anObject [

	"Answer an instance of the receiver initialized with the specified Object.
	
	See also: https://developer.mozilla.org/en-US/docs/Web/API/Headers/Headers"

	^ self newInstanceWithArguments: { anObject }
]

{ #category : #operations }
CpBrowserHeaders >> append: anAssociation [

	"Appends a new value onto an existing header inside a Headers object, or adds the header if it does not already exist."

	self apply: #append withArguments: { anAssociation key . anAssociation value }
]

{ #category : #operations }
CpBrowserHeaders >> appendName: nameString value: valueString [

	"Appends a new value onto an existing header inside a Headers object, or adds the header if it does not already exist."

	self apply: #append withArguments: { nameString . valueString }
]

{ #category : #operations }
CpBrowserHeaders >> delete: aString [

	"Deletes a header from a Headers object"

	self apply: #delete withArguments: { aString }
]

{ #category : #operations }
CpBrowserHeaders >> entries [

	"Returns an iterator allowing to go through all key/value pairs contained in this object"

	^ self apply: #entries
]

{ #category : #operations }
CpBrowserHeaders >> forEach: aBlock [

	"Executes a provided function once for each key/value pair in this Headers object"

	^ self apply: #forEach withArguments: { aBlock }
]

{ #category : #operations }
CpBrowserHeaders >> get: aString [

	"Returns a String sequence of all the values of a header within a Headers object with a given name"

	^ self apply: #get withArguments: { aString }
]

{ #category : #operations }
CpBrowserHeaders >> getSetCookie [

	"Returns an array containing the values of all Set-Cookie headers associated with a response"

	^ self apply: #getSetCookie
]

{ #category : #operations }
CpBrowserHeaders >> has: aString [

	"Returns a boolean stating whether a Headers object contains a certain header"

	^ self apply: #has withArguments: { aString }
]

{ #category : #operations }
CpBrowserHeaders >> keys [

	"Returns an iterator allowing you to go through all keys of the key/value pairs contained in this object"

	^ self apply: #keys
]

{ #category : #operations }
CpBrowserHeaders >> set: anAssociation [

	"Sets a new value for an existing header inside a Headers object, or adds the header if it does not already exist"

	^ self apply: #set withArguments: { anAssociation key . anAssociation value }
]

{ #category : #operations }
CpBrowserHeaders >> setName: nameString value: valueString [

	"Sets a new value for an existing header inside a Headers object, or adds the header if it does not already exist"

	^ self apply: #set withArguments: { nameString . valueString }
]

{ #category : #operations }
CpBrowserHeaders >> values [

	"Returns an iterator allowing you to go through all values of the key/value pairs contained in this object"

	^ self apply: #values
]
