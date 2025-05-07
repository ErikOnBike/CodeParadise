Extension { #name : #CpDomElement }

{ #category : #'*CodeParadise-Canyon-App' }
CpDomElement >> canyonModal [

	"Answer the modal where the receiver is positioned in.
	To prevent any name class with other frameworks this method is named specifically."

	^ self parent
		ifNotNil: [ :parent | parent canyonModal ]
		ifNil: [
			"We reached the root, check our host (we might be in Shadow DOM)"
			self host ifNotNil: [ :host | host canyonModal ] ]
]

{ #category : #'*CodeParadise-Canyon-App' }
CpDomElement >> canyonPage [

	"Answer the page where the receiver is positioned in.
	To prevent any name class with other frameworks this method is named specifically."

	^ self parent
		ifNotNil: [ :parent | parent canyonPage ]
		ifNil: [
			"We reached the root, check our host (we might be in Shadow DOM)"
			self host ifNotNil: [ :host | host canyonPage ] ]
]
