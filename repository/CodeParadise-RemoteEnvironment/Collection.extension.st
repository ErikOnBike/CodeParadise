Extension { #name : #Collection }

{ #category : #'*CodeParadise-RemoteEnvironment' }
Collection >> ifEmptyOrNil: aBlock [

	<clientEnvironment>

	^ self isEmpty
		ifTrue: [ aBlock value ]
		ifFalse: [ self ]
]
