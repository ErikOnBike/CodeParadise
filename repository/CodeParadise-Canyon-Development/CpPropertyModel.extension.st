Extension { #name : #CpPropertyModel }

{ #category : #'*CodeParadise-Canyon-Development' }
CpPropertyModel class >> errorUndefinedProperty: aSymbol [

	<serverEnvironment>

	(thisContext findContextSuchThat: [ :each | each receiver class name = #ShiftClassInstaller ])
		ifNotNil: [ ^ self ].

	super errorUndefinedProperty: aSymbol
]
