Class {
	#name : 'SlAlert',
	#superclass : 'SlElement',
	#category : 'CodeParadise-WebApplication-Shoelace-Elements',
	#package : 'CodeParadise-WebApplication-Shoelace',
	#tag : 'Elements'
}

{ #category : 'accessing style' }
SlAlert >> beClosable [

	self closable: true
]

{ #category : 'accessing variant' }
SlAlert >> beDanger [

	self variant: #danger
]

{ #category : 'accessing variant' }
SlAlert >> beNeutral [

	self variant: #neutral
]

{ #category : 'accessing style' }
SlAlert >> beNotClosable [

	self closable: false
]

{ #category : 'accessing style' }
SlAlert >> beNotOpen [

	self open: false
]

{ #category : 'accessing style' }
SlAlert >> beOpen [

	self open: true
]

{ #category : 'accessing variant' }
SlAlert >> bePrimary [

	self variant: #primary
]

{ #category : 'accessing variant' }
SlAlert >> beSuccess [

	self variant: #success
]

{ #category : 'accessing variant' }
SlAlert >> beWarning [

	self variant: #warning
]

{ #category : 'copying' }
SlAlert >> clone [

	"Deep clone the receiver.

	Implementation:
	Set the (non reflecting properties explicitly)."

	^ super clone
		duration: self duration ;
		yourself

]

{ #category : 'accessing' }
SlAlert >> closable [

	^ self propertyAt: #closable
]

{ #category : 'accessing' }
SlAlert >> closable: aBoolean [

	self propertyAt: #closable put: aBoolean
]

{ #category : 'accessing' }
SlAlert >> duration [

	^ self propertyAt: #duration
]

{ #category : 'accessing' }
SlAlert >> duration: aNumber [

	self propertyAt: #duration put: aNumber
]

{ #category : 'actions' }
SlAlert >> hide [

	self apply: #hide withArguments: #()
]

{ #category : 'accessing' }
SlAlert >> open [

	^ self propertyAt: #open
]

{ #category : 'accessing' }
SlAlert >> open: aBoolean [

	self propertyAt: #open put: aBoolean
]

{ #category : 'actions' }
SlAlert >> show [

	self apply: #show withArguments: #()
]

{ #category : 'actions' }
SlAlert >> toast [

	self apply: #toast withArguments: #()
]

{ #category : 'accessing' }
SlAlert >> variant [

	^ self propertyAt: #variant
]

{ #category : 'accessing' }
SlAlert >> variant: aString [

	self propertyAt: #variant put: aString
]
