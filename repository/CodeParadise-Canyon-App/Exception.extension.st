Extension { #name : #Exception }

{ #category : #'*CodeParadise-Canyon-App' }
Exception >> isRestResponseError [

	<canyonApplicationExtension>

	^ false
]

{ #category : #'*CodeParadise-Canyon-App' }
Exception >> statusCode [

	"Answer internal error status code"

	<canyonApplicationExtension>

	^ 0
]
