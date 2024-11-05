Class {
	#name : #CpBrowserFormData,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-Core'
}

{ #category : #'instance creation' }
CpBrowserFormData class >> form: aFormElement [

	"Creates a new FormData object"

	^ self newInstanceWithArguments: { aFormElement }
]

{ #category : #'instance creation' }
CpBrowserFormData class >> form: aFormElement submitter: aButtonElement [

	"Creates a new FormData object"

	^ self newInstanceWithArguments: { aFormElement . aButtonElement }
]

{ #category : #accessing }
CpBrowserFormData >> append: anAssociation [

	"Appends a new value onto an existing key inside a FormData object, or adds the key if it does not already exist"

	self apply: #append withArguments: { anAssociation key . anAssociation value }
]

{ #category : #accessing }
CpBrowserFormData >> appendName: nameString value: valueString [

	"Appends a new value onto an existing key inside a FormData object, or adds the key if it does not already exist"

	self apply: #append withArguments: { nameString . valueString }
]

{ #category : #accessing }
CpBrowserFormData >> appendName: nameString value: aBlob filename: filenameString [

	"Appends a new value onto an existing key inside a FormData object, or adds the key if it does not already exist"

	self apply: #append withArguments: { nameString . aBlob . filenameString }
]

{ #category : #accessing }
CpBrowserFormData >> delete: aString [

	"Deletes a key/value pair from a FormData object"

	self apply: #delete withArguments: { aString }
]

{ #category : #accessing }
CpBrowserFormData >> entries [

	"Returns an iterator that iterates through all key/value pairs contained in the FormData"

	^ self apply: #entries
]

{ #category : #accessing }
CpBrowserFormData >> get: aString [

	"Returns the first value associated with a given key from within a FormData object"

	^ self apply: #get withArguments: { aString }
]

{ #category : #accessing }
CpBrowserFormData >> getAll [

	"Returns an array of all the values associated with a given key from within a FormData"

	^ self apply: #getAll
]

{ #category : #accessing }
CpBrowserFormData >> has: aString [

	"Returns whether a FormData object contains a certain key"

	^ self apply: #has withArguments: { aString }
]

{ #category : #accessing }
CpBrowserFormData >> keys [

	"Returns an iterator iterates through all keys of the key/value pairs contained in the FormData"

	^ self apply: #keys
]

{ #category : #accessing }
CpBrowserFormData >> set: anAssociation [

	"Sets a new value for an existing key inside a FormData object, or adds the key/value if it does not already exist"

	^ self apply: #set withArguments: { anAssociation key . anAssociation value }
]

{ #category : #accessing }
CpBrowserFormData >> setName: nameString value: valueString [

	"Sets a new value for an existing key inside a FormData object, or adds the key/value if it does not already exist"

	^ self apply: #set withArguments: { nameString . valueString }
]

{ #category : #accessing }
CpBrowserFormData >> setName: nameString value: aBlob filename: filenameString [

	"Sets a new value for an existing key inside a FormData object, or adds the key/value if it does not already exist"

	^ self apply: #set withArguments: { nameString . aBlob . filenameString }
]

{ #category : #accessing }
CpBrowserFormData >> values [

	"Returns an iterator that iterates through all values contained in the FormData"

	^ self apply: #values
]
