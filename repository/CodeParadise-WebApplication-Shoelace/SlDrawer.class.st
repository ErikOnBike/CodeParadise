"
Drawers slide in from a container to expose additional options and information.


"
Class {
	#name : #SlDrawer,
	#superclass : #SlAbstractPrompter,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlDrawer class >> label: aString [

	^ self new
		label: aString ;
		yourself
]

{ #category : #accessing }
SlDrawer >> beBottom [

	self placement: #bottom
]

{ #category : #accessing }
SlDrawer >> beLeft [

	self placement: #left
]

{ #category : #accessing }
SlDrawer >> beRight [

	self placement: #right
]

{ #category : #accessing }
SlDrawer >> beTop [

	self placement: #top
]

{ #category : #accessing }
SlDrawer >> contained: aBoolean [
	"By default, the drawer slides out of its containing block (usually the viewport). To make the drawer slide out of its parent element, set this prop and add 'position: relative' to the parent."

	^self attributeAt: #contained put: aBoolean
]

{ #category : #accessing }
SlDrawer >> placement [
	"Answer the direction from which the drawer will open"

	^self attributeAt: #placement
]

{ #category : #accessing }
SlDrawer >> placement: symbolDirection [
	"The direction from which the drawer will open.	#top | #right | #bottom | #left"

	self attributeAt: #placement put: symbolDirection
]
