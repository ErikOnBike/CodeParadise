Extension { #name : #OrderedDictionary }

{ #category : #'*CodeParadise-WebApplication-MVP' }
OrderedDictionary >> doSafely: aBlock [

	"Evaluate the specified Block for all values of the receiver in order of its keys.
	This method allows elements of the receiver to be removed during the iteration
	(hence its name)."

	orderedKeys copy do: [ :key | self at: key
		ifPresent: [ :each | aBlock value: each ]
		ifAbsent: [ "ignore removed elements" ] ]
]
