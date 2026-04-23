"
I am a read-only map-like class.
See https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map#map-like_browser_apis
"
Class {
	#name : #CpJavaScriptReadOnlyMap,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Core'
}

{ #category : #operations }
CpJavaScriptReadOnlyMap >> entries [

	"Returns a new Iterator object that contains a two-member array of [key, value] for each element in the Map object in insertion order."

	^ self apply: #entries resultAs: CpJavaScriptIteratorProtocol
]

{ #category : #operations }
CpJavaScriptReadOnlyMap >> forEach: aBlock [

	"Calls callbackFn once for each key-value pair present in the Map object, in insertion order. If a thisArg parameter is provided to forEach, it will be used as the this value for each callback.

	Arguments for the Block: value, key, map"

	self apply: #forEach withArguments: { aBlock asJavaScriptFunction }
]

{ #category : #operations }
CpJavaScriptReadOnlyMap >> get: anObject [

	"Returns the value corresponding to the key in this Map, or undefined if there is none."

	^ self apply: #get withArguments: { anObject }
]

{ #category : #operations }
CpJavaScriptReadOnlyMap >> has: anObject [

	"Returns a boolean indicating whether an entry with the specified key exists in this Map or not."

	^ self apply: #has withArguments: { anObject }
]

{ #category : #operations }
CpJavaScriptReadOnlyMap >> keys [

	"Returns a new Iterator object that contains the keys for each element in the Map object in insertion order."

	^ self apply: #keys resultAs: CpJavaScriptIteratorProtocol
]

{ #category : #accessing }
CpJavaScriptReadOnlyMap >> size [

	"Returns the number of key/value pairs in the Map object."

	^ self propertyAt: #size
]

{ #category : #operations }
CpJavaScriptReadOnlyMap >> values [

	"Returns a new Iterator object that contains the values for each element in the Map object in insertion order."

	^ self apply: #values resultAs: CpJavaScriptIteratorProtocol
]
