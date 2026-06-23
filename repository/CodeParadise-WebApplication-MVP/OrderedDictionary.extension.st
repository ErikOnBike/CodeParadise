Extension { #name : #OrderedDictionary }

{ #category : #'*CodeParadise-WebApplication-MVP' }
OrderedDictionary >> asPropertySlotDefinitionOn: aStream [

	"Write the receiver as the PropertySlotDefinition on the specified Stream.

	Implementation:
	A space 'heavy' representation is chose for readability (except for the empty variant)."

	| needsSeparator |

	self ifEmpty: [
		aStream nextPutAll: '{}'.
		^ self ].

	aStream nextPutAll: '{ '.

	needsSeparator := false.
	self associationsDo: [ :assoc |
		needsSeparator
			ifTrue: [ aStream nextPutAll: '. ' ]
			ifFalse: [ needsSeparator := true ].
		aStream
			store: assoc key ;
			nextPutAll: ' -> ' ;
			store: assoc value ;
			space ].

	aStream nextPut: $}
]

{ #category : #'*CodeParadise-WebApplication-MVP' }
OrderedDictionary >> doSafely: aBlock [

	"Evaluate the specified Block for all values of the receiver in order of its keys.
	This method allows elements of the receiver to be removed during the iteration
	(hence its name)."

	orderedKeys copy do: [ :key | self at: key
		ifPresent: [ :each | aBlock value: each ]
		ifAbsent: [ "ignore removed elements" ] ]
]
