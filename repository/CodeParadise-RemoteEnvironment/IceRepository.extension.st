Extension { #name : #IceRepository }

{ #category : #'*CodeParadise-RemoteEnvironment' }
IceRepository class >> folderNamed: folderName in: repositoryName [

	self registry
		detect: [ :each | each name = repositoryName ]
		ifFound: [ :repository | ^ repository location / folderName ]
		ifNone: [ Error signal: 'Failed to find folder ', folderName printString , ' under Iceberg repository ' , repositoryName printString ]

]
