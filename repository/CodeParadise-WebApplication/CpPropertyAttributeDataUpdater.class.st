Class {
	#name : #CpPropertyAttributeDataUpdater,
	#superclass : #CpPrefixedAttributeDataUpdater,
	#category : #'CodeParadise-WebApplication-Support'
}

{ #category : #accessing }
CpPropertyAttributeDataUpdater class >> prefix [

	^ 'property-'
]

{ #category : #rendering }
CpPropertyAttributeDataUpdater >> renderData: anObject on: anElement [

	anElement propertyAt: self name put: (self valueFromData: anObject)
]

{ #category : #accessing }
CpPropertyAttributeDataUpdater >> valueFromData: anObject [

	"Answer the value from the specified data Object.
	Handle key #yourself specifically to refer to the data object itself (if not overwritten)."

	^ anObject at: key ifAbsent: [
		key = #yourself
			ifTrue: [ anObject ] ]
]
