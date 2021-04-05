Extension { #name : #String }

{ #category : #'*CodeParadise-WebApplication-Shoelace' }
String >> asShoelaceIcon [

	<webApplicationShoelaceExtension>

	^ (Smalltalk at: #SlIcon) new
		attributeAt: #name put: self ;
		yourself
]
