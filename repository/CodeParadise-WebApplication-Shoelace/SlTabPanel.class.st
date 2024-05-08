Class {
	#name : 'SlTabPanel',
	#superclass : 'SlElement',
	#category : 'CodeParadise-WebApplication-Shoelace-Elements',
	#package : 'CodeParadise-WebApplication-Shoelace',
	#tag : 'Elements'
}

{ #category : 'accessing' }
SlTabPanel >> content [

	"Answer the content HTML element of the receiver.
	For a simple String value use #contentText instead."

	^ self firstChildAtSlotNamed: nil
]

{ #category : 'accessing' }
SlTabPanel >> content: aStringOrElement [

	"Set the content to the specified Element.
	For a simple String value use #contentText: instead."

	self replaceAllChildrenWith: aStringOrElement asHtmlElement atSlotNamed: nil
]

{ #category : 'accessing' }
SlTabPanel >> contentText [

	"Answer the content text (a String) of the receiver.
	For richer HTML element use #content instead."

	^ self textContent
]

{ #category : 'accessing' }
SlTabPanel >> contentText: aString [

	"Set the content text to the specified String value.
	For richer HTML element use #content: instead."

	self textContent: aString
]

{ #category : 'accessing' }
SlTabPanel >> name [

	^ self propertyAt: #name
]

{ #category : 'accessing' }
SlTabPanel >> name: aString [

	self propertyAt: #name put: aString
]
