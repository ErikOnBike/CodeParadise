Extension { #name : 'String' }

{ #category : '*CodeParadise-WebApplication-Shoelace' }
String >> asShoelaceIcon [

	<webApplicationShoelaceExtension>

	^ (Smalltalk at: #SlIcon) new
		name: self ;
		yourself
]
