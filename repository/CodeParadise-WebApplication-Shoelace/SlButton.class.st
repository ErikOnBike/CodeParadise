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

	self attributeAt: #circle put: ''
]

{ #category : #'accessing style' }
SlButton >> beDisabled [

	self attributeAt: #disabled put: ''
]

{ #category : #'accessing style' }
SlButton >> beLoading [

	self attributeAt: #loading put: ''
]

{ #category : #'accessing style' }
SlButton >> beNoCircle [

	self removeAttributeAt: #circle
]

{ #category : #'accessing style' }
SlButton >> beNoPill [

	self removeAttributeAt: #pill
]

{ #category : #'accessing style' }
SlButton >> beNotDisabled [

	self removeAttributeAt: #disabled
]

{ #category : #'accessing style' }
SlButton >> beNotLoading [

	self removeAttributeAt: #loading
]

{ #category : #'accessing style' }
SlButton >> bePill [

	self attributeAt: #pill put: ''
]

{ #category : #accessing }
SlButton >> content [

	"Answer the content of the receiver, assume it is a single element"

	self firstChild
]

{ #category : #accessing }
SlButton >> content: anElement [

	"Set the content of the receiver to the specified element.
	Any existing content is removed."

	self replaceAllChildrenWith: anElement
]

{ #category : #'accessing type' }
SlButton >> danger [

	self type: #danger
]

{ #category : #'accessing type' }
SlButton >> default [

	self type: #default
]

{ #category : #'accessing link' }
SlButton >> download: aString [

	self attributeAt: #download put: aString
]

{ #category : #'accessing type' }
SlButton >> info [

	self type: #info
]

{ #category : #'accessing style' }
SlButton >> isCircle [

	^ (self attributeAt: #circle) notNil
]

{ #category : #'accessing style' }
SlButton >> isDisabled [

	^ (self attributeAt: #disabled) notNil
]

{ #category : #'accessing style' }
SlButton >> isLoading [

	^ (self attributeAt: #loading) notNil
]

{ #category : #'accessing style' }
SlButton >> isPill [

	^ (self attributeAt: #pill) notNil
]

{ #category : #accessing }
SlButton >> label: aString [

	self content: (aString inHtmlTag: #span)
]

{ #category : #'accessing size' }
SlButton >> large [

	self size: #large
]

{ #category : #'accessing link' }
SlButton >> link: aString [

	self attributeAt: #href put: aString
]

{ #category : #'accessing link' }
SlButton >> link: linkString download: downloadString [

	self
		link: linkString ;
		download: downloadString
]

{ #category : #'accessing link' }
SlButton >> link: linkString target: targetString [

	self
		link: linkString ;
		target: targetString
]

{ #category : #'accessing size' }
SlButton >> medium [

	self size: #medium
]

{ #category : #accessing }
SlButton >> prefix [

	self firstChildAtSlotNamed: #prefix
]

{ #category : #accessing }
SlButton >> prefix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #prefix
]

{ #category : #'accessing type' }
SlButton >> primary [

	self type: #primary
]

{ #category : #'accessing size' }
SlButton >> size [

	^ self attributeAt: #size
]

{ #category : #'accessing size' }
SlButton >> size: aString [

	self attributeAt: #size put: aString
]

{ #category : #'accessing size' }
SlButton >> small [

	self size: #small
]

{ #category : #'accessing type' }
SlButton >> success [

	self type: #success
]

{ #category : #accessing }
SlButton >> suffix [

	self firstChildAtSlotNamed: #suffix
]

{ #category : #accessing }
SlButton >> suffix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #suffix
]

{ #category : #'accessing link' }
SlButton >> target: aString [

	self attributeAt: #target put: aString
]

{ #category : #'accessing type' }
SlButton >> text [

	self type: #text
]

{ #category : #'accessing type' }
SlButton >> type [

	^ self attributeAt: #type
]

{ #category : #'accessing type' }
SlButton >> type: aString [

	self attributeAt: #type put: aString
]

{ #category : #'accessing type' }
SlButton >> warning [

	self type: #warning
]
