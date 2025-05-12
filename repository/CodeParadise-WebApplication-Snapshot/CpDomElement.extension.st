Extension { #name : #CpDomElement }

{ #category : #'*CodeParadise-WebApplication-Snapshot' }
CpDomElement >> privateAttachToId: idString [

	"Attach the receiver to an existing DOM element.
	This should only be used on startup of an image to connect the Smalltalk DOM elements
	with the browser DOM elements (to restore the visual representation)."

	<primitive: 'primitiveDomElementPrivateAttachToId:' module: 'CpDOMPlugin'>
	self error: ('Failed to attach Smalltalk DOM element to the browser DOM element (with id {1})' format: { idString })
]
