Extension { #name : 'String' }

{ #category : '*CodeParadise-WebApplication-Fomantic' }
String >> asFomanticIcon [

	<webApplicationFomanticExtension>

	^ ((Smalltalk classNamed: #CpHtmlElement) newWithTag: #i)
		attributeAt: #class put: self, ' icon' ;
		yourself
]
