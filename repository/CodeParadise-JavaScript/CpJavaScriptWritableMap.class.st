"
I am a writable map-like class.
See https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map#map-like_browser_apis
"
Class {
	#name : #CpJavaScriptWritableMap,
	#superclass : #CpJavaScriptReadOnlyMap,
	#category : #'CodeParadise-JavaScript-Core'
}

{ #category : #operations }
CpJavaScriptWritableMap >> clear [

	"Removes all key-value pairs from the Map object."

	self apply: #clear
]

{ #category : #operations }
CpJavaScriptWritableMap >> delete: anObject [

	"Removes the entry specified by the key from this Map.

	Returns true if an entry in the Map object has been removed successfully. false if the key is not found in the Map."

	^ self apply: #delete withArguments: { anObject }
]

{ #category : #operations }
CpJavaScriptWritableMap >> set: anAssociation [

	"Adds a new entry with a specified key and value to this Map, or updates an existing entry if the key already exists."

	self apply: #set withArguments: { anAssociation key . anAssociation value }
]

{ #category : #operations }
CpJavaScriptWritableMap >> setKey: keyObject value: valueObject [

	"Adds a new entry with a specified key and value to this Map, or updates an existing entry if the key already exists."

	self apply: #set withArguments: { keyObject . valueObject }
]
