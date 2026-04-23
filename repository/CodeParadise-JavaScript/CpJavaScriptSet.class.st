Class {
	#name : #CpJavaScriptSet,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Core'
}

{ #category : #operations }
CpJavaScriptSet >> add: anObject [

	"Inserts the specified value into this set, if it is not already present."

	self apply: #add withArguments: { anObject }
]

{ #category : #operations }
CpJavaScriptSet >> clear [

	"Removes all elements from the Set object."

	self apply: #clear
]

{ #category : #operations }
CpJavaScriptSet >> delete: anObject [

	"Removes the specified value from this set, if it is in the set.
	
	Returns true if a value in the Set object has been removed successfully. false if the value is not found in the Set."

	^ self apply: #delete withArguments: { anObject }
]

{ #category : #operations }
CpJavaScriptSet >> difference: aSet [

	"Takes a set and returns a new set containing elements in this set but not in the given set."

	^ self apply: #difference withArguments: { aSet } resultAs: CpJavaScriptSet
]

{ #category : #operations }
CpJavaScriptSet >> entries [

	"Returns a new iterator object that contains [value, value] for each element in the Set object, in insertion order. This is similar to the Map object, so that each entry's key is the same as its value for a Set."

	^ self apply: #entries resultAs: CpJavaScriptIteratorProtocol
]

{ #category : #operations }
CpJavaScriptSet >> forEach: aBlock [

	"Calls callbackFn once for each value present in the Set object, in insertion order. If a thisArg parameter is provided, it will be used as the this value for each invocation of callbackFn."

	self apply: #forEach withArguments: { aBlock asJavaScriptFunction }
]

{ #category : #operations }
CpJavaScriptSet >> has: anObject [

	"Returns a boolean indicating whether the specified value exists in this Set or not."

	^ self apply: #has withArguments: { anObject }
]

{ #category : #operations }
CpJavaScriptSet >> intersection: aSet [

	"Takes a set and returns a new set containing elements in both this set and the given set."

	^ self apply: #intersection withArguments: { aSet } resultAs: CpJavaScriptSet
]

{ #category : #operations }
CpJavaScriptSet >> isDisjointFrom: aSet [

	"Takes a set and returns a boolean indicating if this set has no elements in common with the given set."

	^ self apply: #isDisjointFrom withArguments: { aSet }
]

{ #category : #operations }
CpJavaScriptSet >> isSubsetOf: aSet [

	"Takes a set and returns a boolean indicating if all elements of this set are in the given set."

	^ self apply: #isSubsetOf withArguments: { aSet }
]

{ #category : #operations }
CpJavaScriptSet >> isSupersetOf: aSet [

	"Takes a set and returns a boolean indicating if all elements of the given set are in this set."

	^ self apply: #isSupersetOf withArguments: { aSet }
]

{ #category : #operations }
CpJavaScriptSet >> keys [

	"An alias for Set.prototype.values()."

	^ self apply: #keys resultAs: CpJavaScriptIteratorProtocol
]

{ #category : #accessing }
CpJavaScriptSet >> size [

	"Returns the number of values in the Set object."

	^ self propertyAt: #size
]

{ #category : #operations }
CpJavaScriptSet >> symmetricDifference: aSet [

	"Takes a set and returns a new set containing elements which are in either this set or the given set, but not in both."

	^ self apply: #symmetricDifference withArguments: { aSet } resultAs: CpJavaScriptSet
]

{ #category : #operations }
CpJavaScriptSet >> union: aSet [

	"Takes a set and returns a new set containing elements which are in either or both of this set and the given set."

	^ self apply: #union withArguments: { aSet } resultAs: CpJavaScriptSet
]

{ #category : #operations }
CpJavaScriptSet >> values [

	"Returns a new iterator object that yields the values for each element in the Set object in insertion order."

	^ self apply: #values resultAs: CpJavaScriptIteratorProtocol
]
