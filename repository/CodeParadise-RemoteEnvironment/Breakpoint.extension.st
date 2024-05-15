Extension { #name : 'Breakpoint' }

{ #category : '*CodeParadise-RemoteEnvironment' }
Breakpoint >> cpEncodeWith: anEncoder [

	"Currently breakpoints are not supported in the client environment"

	(thisContext sender tempAt: 1) browse.

	self halt: 'See the browser opened beneath this debugger'
]
