Extension { #name : #String }

{ #category : #'*CodeParadise-WebApplication-WebAwesome' }
String >> asWebAwesomeIcon [

	<webApplicationWebAwesomeExtension>
	<ignoreReference: #WaIcon>

	^ WaIcon new
		name: self ;
		yourself
]
