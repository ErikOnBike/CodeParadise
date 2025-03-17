Extension { #name : #String }

{ #category : #'*CodeParadise-WebApplication-Shoelace' }
String >> asShoelaceIcon [

	<webApplicationShoelaceExtension>
	<ignoreReference: #SlIcon>

	^ SlIcon named: self
]
