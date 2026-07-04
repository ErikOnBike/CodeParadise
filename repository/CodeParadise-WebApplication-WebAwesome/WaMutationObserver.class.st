Class {
	#name : #WaMutationObserver,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaMutationObserver >> attr [

	"Watches for changes to attributes. To watch only specific attributes, separate them by a space, e.g.
	`attr=""class id title""`. To watch all attributes, use `*`.
	
	Type: String"

	^ self propertyAt: #attr
]

{ #category : #accessing }
WaMutationObserver >> attr: aString [

	"Watches for changes to attributes. To watch only specific attributes, separate them by a space, e.g.
	`attr=""class id title""`. To watch all attributes, use `*`.
	
	Type: String"

	self propertyAt: #attr put: aString
]

{ #category : #accessing }
WaMutationObserver >> attrOldValue [

	"Indicates whether or not the attribute's previous value should be recorded when monitoring changes.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #attrOldValue
]

{ #category : #accessing }
WaMutationObserver >> attrOldValue: aBoolean [

	"Indicates whether or not the attribute's previous value should be recorded when monitoring changes.
	
	Type: Boolean
	Default: false"

	self propertyAt: #attrOldValue put: aBoolean
]

{ #category : #'accessing - convenience' }
WaMutationObserver >> beAttrOldValue [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self attrOldValue: true
]

{ #category : #'accessing - convenience' }
WaMutationObserver >> beCharData [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self charData: true
]

{ #category : #'accessing - convenience' }
WaMutationObserver >> beCharDataOldValue [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self charDataOldValue: true
]

{ #category : #'accessing - convenience' }
WaMutationObserver >> beChildList [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self childList: true
]

{ #category : #'accessing - convenience' }
WaMutationObserver >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #'accessing - convenience' }
WaMutationObserver >> beNotAttrOldValue [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self attrOldValue: false
]

{ #category : #'accessing - convenience' }
WaMutationObserver >> beNotCharData [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self charData: false
]

{ #category : #'accessing - convenience' }
WaMutationObserver >> beNotCharDataOldValue [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self charDataOldValue: false
]

{ #category : #'accessing - convenience' }
WaMutationObserver >> beNotChildList [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self childList: false
]

{ #category : #'accessing - convenience' }
WaMutationObserver >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #accessing }
WaMutationObserver >> charData [

	"Watches for changes to the character data contained within the node.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #charData
]

{ #category : #accessing }
WaMutationObserver >> charData: aBoolean [

	"Watches for changes to the character data contained within the node.
	
	Type: Boolean
	Default: false"

	self propertyAt: #charData put: aBoolean
]

{ #category : #accessing }
WaMutationObserver >> charDataOldValue [

	"Indicates whether or not the previous value of the node's text should be recorded.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #charDataOldValue
]

{ #category : #accessing }
WaMutationObserver >> charDataOldValue: aBoolean [

	"Indicates whether or not the previous value of the node's text should be recorded.
	
	Type: Boolean
	Default: false"

	self propertyAt: #charDataOldValue put: aBoolean
]

{ #category : #accessing }
WaMutationObserver >> childList [

	"Watches for the addition or removal of new child nodes.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #childList
]

{ #category : #accessing }
WaMutationObserver >> childList: aBoolean [

	"Watches for the addition or removal of new child nodes.
	
	Type: Boolean
	Default: false"

	self propertyAt: #childList put: aBoolean
]

{ #category : #accessing }
WaMutationObserver >> disabled [

	"Disables the observer.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaMutationObserver >> disabled: aBoolean [

	"Disables the observer.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]
