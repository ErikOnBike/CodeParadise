Extension { #name : #String }

{ #category : #'*CodeParadise-WebApplication-Shoelace' }
String >> asShoelaceIcon [

	<webApplicationShoelaceExtension>

	^ (Smalltalk classNamed: #SlIcon) new
		name: self ;
		yourself
]
