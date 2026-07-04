Class {
	#name : #CpWaInterfaceSlot,
	#superclass : #Object,
	#instVars : [
		'name',
		'description'
	],
	#category : #'CodeParadise-WebApplication-WebAwesome-Support'
}

{ #category : #'instance creation' }
CpWaInterfaceSlot class >> name: nameString description: descriptionString [

	^ self basicNew
		initializeWithName: nameString description: descriptionString ;
		yourself
]

{ #category : #accessing }
CpWaInterfaceSlot >> description [

	^ description
]

{ #category : #accessing }
CpWaInterfaceSlot >> description: aString [

	description := aString
]

{ #category : #accessing }
CpWaInterfaceSlot >> getterSource [

	"Answer the source code for the getter"

	^ String streamContents: [ :stream |
		stream
			nextPutAll: (CpWaInterfaceInstaller unkebabCase: name initialUppercase: false) ; nextPutAll: 'Element' ; cr ;
			cr.
		self description ifNotEmpty: [ :comment |
			stream
				nextPutAll: (CpWaInterfaceInstaller generateComment: comment indent: 1) ; cr ;
				cr ].
		stream tab ; nextPutAll: '^ self firstChildAtSlotNamed: ' ; print: name ]
]

{ #category : #initialization }
CpWaInterfaceSlot >> initializeWithName: nameString description: descriptionString [

	self initialize.

	name := nameString.
	description := descriptionString
]

{ #category : #actions }
CpWaInterfaceSlot >> installMethodsIn: aClass [

	self name isEmptyOrNil
		ifTrue: [ ^ self ].

	CpWaInterfaceInstaller
		installMethodSource:  self getterSource
		selector: (self name, 'Slot') asSymbol
		protocol: 'accessing - slots'
		in: aClass.

	CpWaInterfaceInstaller
		installMethodSource:  self setterSource
		selector: (self name, 'Slot:') asSymbol
		protocol: 'accessing - slots'
		in: aClass
]

{ #category : #accessing }
CpWaInterfaceSlot >> name [

	^ name
]

{ #category : #accessing }
CpWaInterfaceSlot >> name: aString [

	name := aString
]

{ #category : #accessing }
CpWaInterfaceSlot >> setterSource [

	"Answer the source code for the setter"

	^ String streamContents: [ :stream |
		stream
			nextPutAll: (CpWaInterfaceInstaller unkebabCase: name initialUppercase: false) ; nextPutAll: 'Element: anElement' ; cr ;
			cr ;
			nextPutAll: (CpWaInterfaceInstaller generateComment: self description indent: 1) ; cr ;
			cr ;
			tab ; nextPutAll: 'self replaceAllChildrenWith: anElement atSlotNamed: ' ; print: name ]
]
