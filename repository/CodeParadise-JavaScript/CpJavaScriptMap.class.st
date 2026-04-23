"
I am the actual Map class (not one of the map-like objects).
See https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map#map-like_browser_apis
"
Class {
	#name : #CpJavaScriptMap,
	#superclass : #CpJavaScriptWritableMap,
	#category : #'CodeParadise-JavaScript-Core'
}

{ #category : #operations }
CpJavaScriptMap >> getOrInsert: anAssociation [

	"Returns the value corresponding to the specified key in this Map. If the key is not present, it inserts a new entry with the key and a given default value, and returns the inserted value."

	^ self apply: #getOrInsert withArguments: { anAssociation key . anAssociation value }
]

{ #category : #operations }
CpJavaScriptMap >> getOrInsert: keyObject value: valueObject [

	"Returns the value corresponding to the specified key in this Map. If the key is not present, it inserts a new entry with the key and a given default value, and returns the inserted value."

	^ self apply: #getOrInsert withArguments: { keyObject . valueObject }
]

{ #category : #operations }
CpJavaScriptMap >> getOrInsertComputed: anAssociation [

	"Returns the value corresponding to the specified key in this Map. If the key is not present, it inserts a new entry with the key and a default value computed from a given callback, and returns the inserted value."

	^ self apply: #getOrInsertComputed withArguments: { anAssociation key . anAssociation value asJavaScriptFunction }
]

{ #category : #operations }
CpJavaScriptMap >> getOrInsertComputed: anObject value: aBlock [

	"Returns the value corresponding to the specified key in this Map. If the key is not present, it inserts a new entry with the key and a default value computed from a given callback, and returns the inserted value."

	^ self apply: #getOrInsertComputed withArguments: { anObject . aBlock asJavaScriptFunction }
]
