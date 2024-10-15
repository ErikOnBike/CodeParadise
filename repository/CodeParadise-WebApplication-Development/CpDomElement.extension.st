Extension { #name : #CpDomElement }

{ #category : #'*CodeParadise-WebApplication-Development' }
CpDomElement >> allNonShadowedElementsDo: aBlock [

	"Evaluate the specified Block on the receiver and all elements attached to the receiver.
	This means all child elements and the child elements of these child elements.
	This can include a huge amount of Element. Use with care!"

	aBlock value: self.

	self children do: [ :each | each allNonShadowedElementsDo: aBlock ]
]
