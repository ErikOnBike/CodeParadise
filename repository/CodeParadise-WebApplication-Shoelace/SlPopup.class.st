Class {
	#name : #SlPopup,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlPopup >> active: aBoolean [

	self propertyAt: #active put: aBoolean
]

{ #category : #accessing }
SlPopup >> anchor [

	^ self propertyAt: #anchor
]

{ #category : #accessing }
SlPopup >> beActive [

	self active: true
]

{ #category : #accessing }
SlPopup >> beNotActive [

	self active: false
]

{ #category : #accessing }
SlPopup >> distance [

	^ self propertyAt: #distance
]

{ #category : #accessing }
SlPopup >> distance: anInteger [

	self propertyAt: #distance put: anInteger
]

{ #category : #accessing }
SlPopup >> isActive [

	^ self propertyAt: #active
]

{ #category : #accessing }
SlPopup >> placement [

	^ self propertyAt: #placement
]

{ #category : #accessing }
SlPopup >> placement: aString [

	self propertyAt: #placement put: aString
]

{ #category : #accessing }
SlPopup >> placementBottom [

	self placement: #bottom
]

{ #category : #accessing }
SlPopup >> placementLeft [

	self placement: #left
]

{ #category : #accessing }
SlPopup >> placementRight [

	self placement: #right
]

{ #category : #accessing }
SlPopup >> placementTop [

	self placement: #top
]

{ #category : #accessing }
SlPopup >> popup [

	^ self propertyAt: #popup
]
