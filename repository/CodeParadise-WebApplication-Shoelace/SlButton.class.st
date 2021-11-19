Class {
	#name : #SlButton,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlButton class >> content: anElement [

	^ self new
		content: anElement ;
		yourself
]

{ #category : #accessing }
SlButton class >> content: contentElement suffix: suffixElement [

	^ self new
		content: contentElement ;
		suffix: suffixElement ;
		yourself
]

{ #category : #accessing }
SlButton class >> label: aString [

	^ self new
		content: (aString inHtmlTag: #span) ;
		yourself
]

{ #category : #accessing }
SlButton class >> label: aString suffix: suffixElement [

	^ self new
		content: (aString inHtmlTag: #span) ;
		suffix: suffixElement ;
		yourself
]

{ #category : #accessing }
SlButton class >> prefix: prefixElement content: contentElement [

	^ self new
		prefix: prefixElement ;
		content: contentElement ;
		yourself
]

{ #category : #accessing }
SlButton class >> prefix: prefixElement content: contentElement suffix: suffixElement [

	^ self new
		prefix: prefixElement ;
		content: contentElement ;
		suffix: suffixElement ;
		yourself
]

{ #category : #accessing }
SlButton class >> prefix: anElement label: aString [

	^ self new
		prefix: anElement ;
		content: (aString inHtmlTag: #span) ;
		yourself
]

{ #category : #accessing }
SlButton class >> prefix: prefixElement label: aString suffix: suffixElement [

	^ self new
		prefix: prefixElement ;
		content: (aString inHtmlTag: #span) ;
		suffix: suffixElement ;
		yourself
]

{ #category : #'accessing style' }
SlButton >> beCircle [

	self circle: true
]

{ #category : #'accessing type' }
SlButton >> beDanger [

	self type: #danger
]

{ #category : #'accessing type' }
SlButton >> beDefault [

	self type: #default
]

{ #category : #'accessing style' }
SlButton >> beDisabled [

	self disabled: true
]

{ #category : #'accessing style' }
SlButton >> beEnabled [

	"Convenience method to make receiver enabled"

	self disabled: false
]

{ #category : #'accessing type' }
SlButton >> beInfo [

	self type: #info
]

{ #category : #'accessing size' }
SlButton >> beLarge [

	self size: #large
]

{ #category : #'accessing style' }
SlButton >> beLoading [

	self loading: true
]

{ #category : #'accessing size' }
SlButton >> beMedium [

	self size: #medium
]

{ #category : #'accessing style' }
SlButton >> beNotCircle [

	self circle: false
]

{ #category : #'accessing style' }
SlButton >> beNotDisabled [

	self disabled: false
]

{ #category : #'accessing style' }
SlButton >> beNotEnabled [

	"Convenience method to clear the enabled state of the receiver"

	self disabled: true
]

{ #category : #'accessing style' }
SlButton >> beNotLoading [

	self loading: false
]

{ #category : #'accessing style' }
SlButton >> beNotOutline [

	self outline: false
]

{ #category : #'accessing style' }
SlButton >> beNotPill [

	self pill: false
]

{ #category : #'accessing style' }
SlButton >> beOutline [

	self outline: true
]

{ #category : #'accessing style' }
SlButton >> bePill [

	self pill: true
]

{ #category : #'accessing type' }
SlButton >> bePrimary [

	self type: #primary
]

{ #category : #'accessing size' }
SlButton >> beSmall [

	self size: #small
]

{ #category : #'accessing type' }
SlButton >> beSuccess [

	self type: #success
]

{ #category : #'accessing type' }
SlButton >> beText [

	self type: #text
]

{ #category : #'accessing type' }
SlButton >> beWarning [

	self type: #warning
]

{ #category : #accessing }
SlButton >> circle: aBoolean [

	self propertyAt: #circle put: aBoolean
]

{ #category : #accessing }
SlButton >> content [

	"Answer the content of the receiver, assume it is a single element"

	^ self firstChild
]

{ #category : #accessing }
SlButton >> content: anElement [

	"Set the content of the receiver to the specified element.
	Any existing content is removed."

	self replaceAllChildrenWith: anElement
]

{ #category : #accessing }
SlButton >> disabled: aBoolean [

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
SlButton >> download [

	^ self propertyAt: #download
]

{ #category : #accessing }
SlButton >> download: aString [

	self propertyAt: #download put: aString
]

{ #category : #accessing }
SlButton >> enabled: aBoolean [

	"Convenience method to set receiver's enabled state"

	self disabled: aBoolean not
]

{ #category : #testing }
SlButton >> isCircle [

	^ self propertyAt: #circle
]

{ #category : #testing }
SlButton >> isDisabled [

	^ self propertyAt: #disabled
]

{ #category : #testing }
SlButton >> isEnabled [

	"Convenience method to test if receiver is enabled"

	^ self isDisabled not
]

{ #category : #testing }
SlButton >> isLoading [

	^ self propertyAt: #loading
]

{ #category : #testing }
SlButton >> isOutline [

	^ self propertyAt: #outline
]

{ #category : #testing }
SlButton >> isPill [

	^ self propertyAt: #pill
]

{ #category : #accessing }
SlButton >> label [

	^ self textContent
]

{ #category : #accessing }
SlButton >> label: aString [

	self textContent: aString
]

{ #category : #accessing }
SlButton >> link [

	^ self propertyAt: #href
]

{ #category : #accessing }
SlButton >> link: aString [

	self propertyAt: #href put: aString
]

{ #category : #accessing }
SlButton >> link: linkString download: downloadString [

	self
		link: linkString ;
		download: downloadString
]

{ #category : #accessing }
SlButton >> link: linkString target: targetString [

	self
		link: linkString ;
		target: targetString
]

{ #category : #accessing }
SlButton >> loading: aBoolean [

	self propertyAt: #loading put: aBoolean
]

{ #category : #accessing }
SlButton >> outline: aBoolean [

	self propertyAt: #outline put: aBoolean
]

{ #category : #accessing }
SlButton >> pill: aBoolean [

	self propertyAt: #pill put: aBoolean
]

{ #category : #accessing }
SlButton >> prefix [

	^ self firstChildAtSlotNamed: #prefix
]

{ #category : #accessing }
SlButton >> prefix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #prefix
]

{ #category : #accessing }
SlButton >> size [

	^ self propertyAt: #size
]

{ #category : #accessing }
SlButton >> size: aString [

	self propertyAt: #size put: aString
]

{ #category : #accessing }
SlButton >> suffix [

	^ self firstChildAtSlotNamed: #suffix
]

{ #category : #accessing }
SlButton >> suffix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #suffix
]

{ #category : #accessing }
SlButton >> target [

	^ self propertyAt: #target
]

{ #category : #accessing }
SlButton >> target: aString [

	self propertyAt: #target put: aString
]

{ #category : #'accessing target' }
SlButton >> targetBlank [

	self target: #'_blank'
]

{ #category : #'accessing target' }
SlButton >> targetParent [

	self target: #'_parent'
]

{ #category : #'accessing target' }
SlButton >> targetSelf [

	self target: #'_self'
]

{ #category : #'accessing target' }
SlButton >> targetTop [

	self target: #'_top'
]

{ #category : #accessing }
SlButton >> type [

	^ self propertyAt: #type
]

{ #category : #accessing }
SlButton >> type: aString [

	self propertyAt: #type put: aString
]
