Class {
	#name : #CpEvent,
	#superclass : #Object,
	#instVars : [
		'target',
		'elementId'
	],
	#category : #'WebApplication-Events'
}

{ #category : #'instance creation' }
CpEvent class >> buildFrom: aDictionary [

	| type |

	type := aDictionary at: #type ifAbsent: [ self error: 'DOM event should have a type' ].

	self allSubclassesDo: [ :each |
		(each canHandleType: type)
			ifTrue: [ ^ each newFrom: aDictionary ] ].

	self error: 'DOM event has unknown type: ', type asString
]

{ #category : #testing }
CpEvent class >> canHandleType: type [

	^ self type = type
]

{ #category : #'instance creation' }
CpEvent class >> newFrom: aDictionary [

	| target |

	target := aDictionary at: #target ifAbsent: [ self error: 'DOM event should have a target' ].

	^ self new
		target: target ;
		elementId: (aDictionary at: #elementId ifAbsent: [ nil ]) ;
		yourself
]

{ #category : #utilities }
CpEvent class >> offsetFrom: aDictionary [

	^ ((aDictionary at: #offsetX ifAbsent: [ 0 ]) ifNil: [ 0 ]) @ ((aDictionary at: #offsetY ifAbsent: [ 0 ]) ifNil: [ 0 ])
]

{ #category : #utilities }
CpEvent class >> pointFrom: aDictionary [

	^ (aDictionary at: #x ifAbsent: [ 0 ]) @ (aDictionary at: #y ifAbsent: [ 0 ])
]

{ #category : #accessing }
CpEvent class >> type [

	self subclassResponsibility
]

{ #category : #visiting }
CpEvent >> accept: aVisitor [

	self subclassResponsibility
]

{ #category : #accessing }
CpEvent >> elementId [

	"Answer the id of the DOM element which first received the event.
	This can be either the target of the event or a descendant. In case of a TemplateComponent
	this can also be the id of an element inside the shadow DOM."

	^ elementId
]

{ #category : #accessing }
CpEvent >> elementId: aString [

	elementId := aString
]

{ #category : #printing }
CpEvent >> printOn: aStream [

	self class name printOn: aStream.
	aStream nextPut: $(.
	self class type printOn: aStream.
	aStream nextPut: $,.
	self target printOn: aStream.
	self elementId ifNotNil: [
		aStream nextPut: $,.
		self elementId printOn: aStream ].
	aStream nextPut: $)
]

{ #category : #sending }
CpEvent >> sendTo: anObject [

	self subclassResponsibility
]

{ #category : #accessing }
CpEvent >> target [

	^ target
]

{ #category : #accessing }
CpEvent >> target: aDomElement [

	target := aDomElement
]

{ #category : #accessing }
CpEvent >> type [

	^ self class type
]
