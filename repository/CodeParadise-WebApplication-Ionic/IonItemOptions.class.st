Class {
	#name : #IonItemOptions,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonItemOptions >> fireSwipeEvent [

	"Type: Promise<void>"

	^ self apply: #fireSwipeEvent resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonItemOptions >> side [

	"The side the option button should be on. Possible values: ''start'' and ''end''. If you have multiple 'ion-item-options', a side must be provided for each.
	
	Type: Side"

	^ self propertyAt: #side
]

{ #category : #api }
IonItemOptions >> side: anObject [

	"The side the option button should be on. Possible values: ''start'' and ''end''. If you have multiple 'ion-item-options', a side must be provided for each.
	
	Type: Side"

	self propertyAt: #side put: anObject
]
