"
Drawers slide in from a container to expose additional options and information.


"
Class {
	#name : #SlDrawer,
	#superclass : #SlAbstractPrompter,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlDrawer >> beBottom [

	self placement: #bottom
]

{ #category : #accessing }
SlDrawer >> beContained [

	self contained: true
]

{ #category : #accessing }
SlDrawer >> beEnd [

	self placement: #end
]

{ #category : #accessing }
SlDrawer >> beNotContained [

	self contained: false
]

{ #category : #accessing }
SlDrawer >> beStart [

	self placement: #start
]

{ #category : #accessing }
SlDrawer >> beTop [

	self placement: #top
]

{ #category : #accessing }
SlDrawer >> contained: aBoolean [

	"By default, the drawer slides out of its containing block (usually the viewport).
	To make the drawer slide out of its parent element, set this property and
	add 'position: relative' to the parent."

	self propertyAt: #contained put: aBoolean

]

{ #category : #testing }
SlDrawer >> isContained [

	^ self propertyAt: #contained
]

{ #category : #accessing }
SlDrawer >> placement [

	"Answer the direction from which the drawer will open"

	^ self propertyAt: #placement

]

{ #category : #accessing }
SlDrawer >> placement: aString [

	"The direction from which the drawer will open. 'top' | 'right' | 'bottom' | 'left'"

	self propertyAt: #placement put: aString

]
