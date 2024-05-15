Extension { #name : 'IceRepository' }

{ #category : '*CodeParadise-RemoteEnvironment' }
IceRepository class >> directoryNamed: directoryName in: repositoryName [

	self registry
		detect: [ :each | each name = repositoryName ]
		ifFound: [ :repository | ^ repository location / directoryName ]
		ifNone: [ Error signal: 'Failed to find directory ', directoryName printString , ' under Iceberg repository ' , repositoryName printString ]

]
