"
I represent a JSON structure. I do NOT represent individual JSON
values (like String or Integer), but my properties do.

The properties of my instances can be accessed like a Dictionary.
All keys are (converted to) Strings.
All values should be one of:
	Object (another JSON structure)
	String
	Integer
	Float
	Boolean
	nil
	Array (of one of the above or another Array)

See also: https://www.json.org

Implementation:
I wrap a Dictionary or an OrderedDictionary and perform any
required conversions for keys and values.

"
Class {
	#name : #CpJsonObject,
	#superclass : #Object,
	#instVars : [
		'dict'
	],
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #'instance creation' }
CpJsonObject class >> fromDictionary: aDictionary [

	^ self basicNew
		initializeWithDictionary: aDictionary ;
		yourself
]

{ #category : #'instance creation' }
CpJsonObject class >> fromString: aString [

	^ self fromDictionary: (CpJavaScriptJSON parse: aString)
]

{ #category : #'instance creation' }
CpJsonObject class >> new [

	"Answer a new empty JSON structure"

	^ self wrap: Dictionary new
]

{ #category : #'instance creation' }
CpJsonObject class >> wrap: aDictionary [

	"Answer an instance of the receiver wrapping the specified Dictionary.
	This assumes the Dictionary already is JSON compatible (see class comment
	for an explanation)."

	^ self basicNew
		initializeWithWrappedDictionary: aDictionary ;
		yourself
]

{ #category : #adding }
CpJsonObject >> add: anAssociation [

	"Add a new key/value pair, maintaining the JSON structure"

	^ dict add: anAssociation key asString -> anAssociation value asJsonObjectValue
]

{ #category : #converting }
CpJsonObject >> asDictionary [

	^ dict copy
]

{ #category : #converting }
CpJsonObject >> asJsonObjectValue [

	"Answer a representation of the receiver to be used in a JSON Object.

	Implementation:
	Since my instance variable #dict is already created using #asJsonObjectValue
	and is maintained as such, simply answer a copy."

	^ dict copy
]

{ #category : #'accessing - dictionary access' }
CpJsonObject >> associations [

	^ dict associations
]

{ #category : #'accessing - dictionary access' }
CpJsonObject >> associationsDo: aBlock [

	dict associationsDo: aBlock
]

{ #category : #accessing }
CpJsonObject >> at: anObject [

	"Answer property value or nil if not present"

	^ self at: anObject ifAbsent: [ nil ]
]

{ #category : #accessing }
CpJsonObject >> at: anObject ifAbsent: aBlock [

	"Answer property value or evaluate the specified Block if not present"

	^ dict at: anObject asString ifAbsent: aBlock
]

{ #category : #accessing }
CpJsonObject >> at: anObject ifAbsentPut: aBlock [

	"Answer property value or evaluate the specified Block and set the property to this value.
	Maintain the JSON structure by using a String key and converting the value using #asJsonObjectValue"

	^ dict at: anObject asString ifAbsentPut: [ aBlock value asJsonObjectValue ]
]

{ #category : #accessing }
CpJsonObject >> at: anObject ifPresent: aBlock [

	"Answer the result of evaluating the Block with the found Object,
	or answer nil if such Object is not found"

	^ dict at: anObject asString ifPresent: aBlock
]

{ #category : #accessing }
CpJsonObject >> at: anObject ifPresent: presentBlock ifAbsent: absentBlock [

	"Answer the result of evaluating either the present or the absent Block"

	^ dict at: anObject asString ifPresent: presentBlock ifAbsent: absentBlock
]

{ #category : #accessing }
CpJsonObject >> at: anObject ifPresent: presentBlock ifAbsentPut: absentBlock [

	"Answer the evaluation of the present Block (optionally receiving the property value) if present
	or evaluate the specified absent Block and set the property to this value.
	Maintain the JSON structure by using a String key and converting the value using #asJsonObjectValue"

	^ dict
		at: anObject asString
		ifPresent: presentBlock
		ifAbsentPut: [ absentBlock value asJsonObjectValue ]
]

{ #category : #accessing }
CpJsonObject >> at: keyObject put: valueObject [

	"Update property value.
	Maintain the JSON structure by using a String key and converting the value using #asJsonObjectValue"

	^ dict at: keyObject asString put: valueObject asJsonObjectValue
]

{ #category : #accessing }
CpJsonObject >> atPath: aCollection [

	"Answer the element at the specified path (a Collection of Dictionary and/or Array
	indices, i.e. Strings or Integers).
	If an element (somewhere along the path) is not present, nil is answered.
	If an element (somewhere along the path, not being the last element) is not a
	structural element like a Dictionary or an Array, an error will be signalled."

	^ aCollection inject: self into: [ :result :index |
		result
			ifNotNil: [ :jsonObject |
				(self isStructuralElement: jsonObject)
					ifFalse: [ self error: ('indexing JSON object {1} for non indexable field {2} of {3}' format: { self printString . index printString . aCollection printString }) ].
				jsonObject at: index ifAbsent: [ nil ] ]
			ifNil: [ ^ nil ] ]
]

{ #category : #'accessing - dictionary access' }
CpJsonObject >> do: aBlock [

	dict do: aBlock
]

{ #category : #'reflective operations' }
CpJsonObject >> doesNotUnderstand: aMessage [

	"Convenience mechanism to allow sending arbitrary messages to the JSON Object.
	Accept getters and setters.

	Be aware: some names are selectors of methods in Object and will therefore not be
	handled by this DNU mechanism. E.g. #value, #class, #error:"

	| key isSetter |

	"Check for keyword message"
	key := aMessage selector asString.
	(key first isLetter or: [ key first = $_ ])
		ifFalse: [ ^ super doesNotUnderstand: aMessage ].

	"Check for too many arguments (not a simple setter)"
	isSetter := key endsWith: ':'.
	(isSetter and: [ aMessage arguments size > 1 ])
		ifTrue: [ ^ super doesNotUnderstand: aMessage ].

	isSetter
		ifTrue: [ self at: key allButLast put: aMessage arguments first ]
		ifFalse: [ ^ self at: key ]
]

{ #category : #'accessing - dictionary access' }
CpJsonObject >> includesKey: anObject [

	^ dict includesKey: anObject asString
]

{ #category : #initialization }
CpJsonObject >> initializeWithDictionary: aDictionary [

	self initialize.

	dict := aDictionary asJsonObjectValue
]

{ #category : #initialization }
CpJsonObject >> initializeWithWrappedDictionary: aDictionary [

	self initialize.

	dict := aDictionary
]

{ #category : #private }
CpJsonObject >> isStructuralElement: anObject [

	"Answer whether the specified Object is a structural element
	which can contain other elements.

	Implementation:
	Because the tiny image lacks different methods like #isCollection
	and #isDictionary, an old fashioned match on class is performed."

	^ anObject class = CpJsonObject or: [
		anObject isArray or: [
			anObject class = Dictionary or: [
				anObject class = OrderedDictionary ] ] ]
]

{ #category : #'accessing - dictionary access' }
CpJsonObject >> keys [

	^ dict keys
]

{ #category : #'accessing - dictionary access' }
CpJsonObject >> keysAndValuesDo: aBlock [

	dict keysAndValuesDo: aBlock
]

{ #category : #'accessing - dictionary access' }
CpJsonObject >> keysDo: aBlock [

	dict keysDo: aBlock
]

{ #category : #printing }
CpJsonObject >> printOn: aStream [

	"Print the receiver on the specified Stream.

	Implementation:
	Use the JSON.stringify() method to create a regular JSON representation of the receiver.
	Since the VM does not recognize the receiver as a Dictionary-like Object, make an explicit
	Dictionary for this purpose."

	aStream nextPutAll: (CpJavaScriptJSON stringify: dict)
]
