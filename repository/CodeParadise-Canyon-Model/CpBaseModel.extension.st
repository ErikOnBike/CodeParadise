Extension { #name : #CpBaseModel }

{ #category : #'*CodeParadise-Canyon-Model' }
CpBaseModel class >> errorUndefinedProperty: aSymbol [

	"Signal error"

	self error: 'Undefined property ', aSymbol, ' in a ', self name
]
