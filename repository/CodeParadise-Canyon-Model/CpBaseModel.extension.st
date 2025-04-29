Extension { #name : #CpBaseModel }

{ #category : #'*CodeParadise-Canyon-Model' }
CpBaseModel class >> errorUndefinedProperty: aSymbol [

	"Signal error about undefined property.

	This method is a (temporary) hack. See the comment in CynPropertyModel class >> #errorUndefinedProperty:"

	self error: 'Undefined property ', aSymbol, ' in a ', self name
]
