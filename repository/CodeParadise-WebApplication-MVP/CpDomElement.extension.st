Extension { #name : #CpDomElement }

{ #category : #'*CodeParadise-WebApplication-MVP' }
CpDomElement >> attachAsField: aSymbol to: aFieldsView [

	"Attach field event handlers to the receiver for the specified CpFieldsView"

	aFieldsView attachEventHandlersFor: aSymbol to: self
]

{ #category : #'*CodeParadise-WebApplication-MVP' }
CpDomElement >> changeEventClass [

	^ CpChangeEvent
]

{ #category : #'*CodeParadise-WebApplication-MVP' }
CpDomElement >> inputEventClass [

	^ CpInputEvent
]

{ #category : #'*CodeParadise-WebApplication-MVP' }
CpDomElement >> translateToLocalPoint: screenPoint [

	"Answer the Point which represents the position of the screenPoint relative to the receiver"

	^ screenPoint
]
