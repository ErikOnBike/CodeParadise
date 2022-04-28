Class {
	#name : #SlIconButton,
	#superclass : #SlIcon,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #'accessing style' }
SlIconButton >> beDisabled [

	self disabled: true
]

{ #category : #'accessing style' }
SlIconButton >> beEnabled [

	"Convenience method to make receiver enabled"

	self disabled: false
]

{ #category : #'accessing style' }
SlIconButton >> beNotDisabled [

	self disabled: false
]

{ #category : #'accessing style' }
SlIconButton >> beNotEnabled [

	"Convenience method to clear the enabled state of the receiver"

	self disabled: true
]

{ #category : #accessing }
SlIconButton >> disabled: aBoolean [

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
SlIconButton >> download [

	^ self propertyAt: #download
]

{ #category : #accessing }
SlIconButton >> download: aString [

	self propertyAt: #download put: aString
]

{ #category : #accessing }
SlIconButton >> enabled: aBoolean [

	"Convenience method to set receiver's enabled state"

	self disabled: aBoolean not
]

{ #category : #initialization }
SlIconButton >> initialize [

	super initialize.

	self when: CpPrimaryClickEvent send: #onPrivateClick: to: self
]

{ #category : #testing }
SlIconButton >> isDisabled [

	^ self propertyAt: #disabled
]

{ #category : #testing }
SlIconButton >> isEnabled [

	"Convenience method to test if receiver is enabled"

	^ self isDisabled not
]

{ #category : #accessing }
SlIconButton >> link [

	^ self propertyAt: #href
]

{ #category : #accessing }
SlIconButton >> link: aString [

	self propertyAt: #href put: aString
]

{ #category : #accessing }
SlIconButton >> link: linkString download: downloadString [

	self
		link: linkString ;
		download: downloadString
]

{ #category : #accessing }
SlIconButton >> link: linkString target: targetString [

	self
		link: linkString ;
		target: targetString
]

{ #category : #'private - event handling' }
SlIconButton >> onPrivateClick: aClickEvent [

	"The receiver has generated a click event (as oppposed to having actually
	been clicked by a pointer device). Emulate regular click event."

	"Implementation: a Click event is not a pointer event, but the protocol matches enough"
	aClickEvent isNoButtonPressed
		ifTrue: [ self announce: ((CpPrimaryClickEvent newFromMouseEvent: aClickEvent) ifNil: [ ^ self ]) ]
]

{ #category : #accessing }
SlIconButton >> target [

	^ self propertyAt: #target
]

{ #category : #accessing }
SlIconButton >> target: aString [

	self propertyAt: #target put: aString
]

{ #category : #'accessing target' }
SlIconButton >> targetBlank [

	self target: #'_blank'
]

{ #category : #'accessing target' }
SlIconButton >> targetParent [

	self target: #'_parent'
]

{ #category : #'accessing target' }
SlIconButton >> targetSelf [

	self target: #'_self'
]

{ #category : #'accessing target' }
SlIconButton >> targetTop [

	self target: #'_top'
]
