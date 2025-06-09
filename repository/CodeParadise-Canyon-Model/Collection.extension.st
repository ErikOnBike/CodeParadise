Extension { #name : #Collection }

{ #category : #'*CodeParadise-Canyon-Model' }
Collection >> mergeIntoPropertyModel: aPropertyModel [

	"Merge the receiver into the specified PropertyModel.

	Implementation:
	Only works for keyed collections (like Dictionary or OrderedDictionary).
	Since they don't share a direct common ancestor, use Collection."

	<canyonModelExtension>

	self keysAndValuesDo: [ :key :value |
		aPropertyModel propertyAt: key put: value ]
]
