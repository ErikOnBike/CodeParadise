Extension { #name : #CpServerEnvironment }

{ #category : #'*CodeParadise-WebApplication-Development' }
CpServerEnvironment >> handleError: aString [

	"Handle an error with the specified description"

	super handleError: aString.

	self halt
]
