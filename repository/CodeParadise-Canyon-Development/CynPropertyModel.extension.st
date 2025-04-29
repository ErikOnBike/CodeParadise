Extension { #name : #CynPropertyModel }

{ #category : #'*CodeParadise-Canyon-Development' }
CynPropertyModel class >> errorUndefinedProperty: aSymbol [

	"This method is a (temporary) hack to allow updating a model while running an application.
	By default the ShiftInstaller will try to morph existing instances when a class changes.
	When a rename is performed, this will result in an error because instances are accessed
	using invalid property names (because of the rename).
	To allow this hack to work, the actual implementation is added to the superclass."

	<serverEnvironment>

	(thisContext findContextSuchThat: [ :each | each receiver class name = #ShiftClassInstaller ])
		ifNotNil: [ ^ self ].

	super errorUndefinedProperty: aSymbol
]
