Extension { #name : 'CpChangeEvent' }

{ #category : '*CodeParadise-WebApplication-MVP' }
CpChangeEvent >> handleEventForField: aSymbol inView: aView [

	"Let the specified view handle the receiver event"

	aView handleChangeEvent: self forField: aSymbol
]
