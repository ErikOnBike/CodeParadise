Extension { #name : #Collection }

{ #category : #'*CodeParadise-Canyon-Model' }
Collection >> mergeIntoPropertyModel: aPropertyModel [

	self keysAndValuesDo: [ :key :value |
		aPropertyModel propertyAt: key put: value ]
]
