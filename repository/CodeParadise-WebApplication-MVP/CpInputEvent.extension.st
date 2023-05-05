Extension { #name : #CpInputEvent }

{ #category : #'*CodeParadise-WebApplication-MVP' }
CpInputEvent >> handleEventForField: aSymbol inView: aView [

	"Let the specified view handle the receiver event"

	aView handleInputEvent: self forField: aSymbol
]
