Class {
	#name : #SlTag,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #'accessing style' }
SlTag >> beDanger [

	self type: #danger
]

{ #category : #'accessing size' }
SlTag >> beLarge [

	self size: #large
]

{ #category : #'accessing size' }
SlTag >> beMedium [

	self size: #medium
]

{ #category : #'accessing style' }
SlTag >> beNeutral [

	self type: #neutral
]

{ #category : #'accessing style' }
SlTag >> beNotPill [

	self pill: false
]

{ #category : #'accessing style' }
SlTag >> beNotRemovable [

	self removable: false
]

{ #category : #'accessing style' }
SlTag >> bePill [

	self pill: true
]

{ #category : #'accessing style' }
SlTag >> bePrimary [

	self type: #primary
]

{ #category : #'accessing style' }
SlTag >> beRemovable [

	self removable: true
]

{ #category : #'accessing size' }
SlTag >> beSmall [

	self size: #small
]

{ #category : #'accessing style' }
SlTag >> beSuccess [

	self type: #success
]

{ #category : #'accessing style' }
SlTag >> beText [

	self type: #text
]

{ #category : #'accessing style' }
SlTag >> beWarning [

	self type: #warning
]

{ #category : #testing }
SlTag >> isPill [

	^ self propertyAt: #pill
]

{ #category : #testing }
SlTag >> isRemovable [

	^ self propertyAt: #removable
]

{ #category : #accessing }
SlTag >> pill: aBoolean [

	self propertyAt: #pill put: aBoolean
]

{ #category : #accessing }
SlTag >> removable: aBoolean [

	self propertyAt: #removable put: aBoolean
]

{ #category : #accessing }
SlTag >> size [

	^ self propertyAt: #size
]

{ #category : #accessing }
SlTag >> size: aString [

	self propertyAt: #size put: aString
]

{ #category : #accessing }
SlTag >> type [

	^ self propertyAt: #type
]

{ #category : #accessing }
SlTag >> type: aString [

	self propertyAt: #type put: aString
]
