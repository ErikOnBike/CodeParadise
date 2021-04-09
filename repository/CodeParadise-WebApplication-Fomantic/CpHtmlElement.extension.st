Extension { #name : #CpHtmlElement }

{ #category : #'*CodeParadise-WebApplication-Fomantic' }
CpHtmlElement >> asFomanticElement [

	"Answer the receiver as a Fomantic element
	(if applicable, oterhwise answer the receiver)"

	<primitive: 'primitiveFUIElementAsFomanticElement' module: 'CpFomanticPlugin'>
	^ self
]
