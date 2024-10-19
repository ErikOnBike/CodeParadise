Class {
	#name : #IonList,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonList >> closeSlidingItems [

	"If 'ion-item-sliding' are used inside the list, this method closes any open sliding item.  Returns 'true' if an actual 'ion-item-sliding' is closed.
	
	Type: Promise<boolean>"

	^ self apply: #closeSlidingItems resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonList >> inset [

	"If 'true', the list will have margin around it and rounded corners.
	
	Type: boolean"

	^ self propertyAt: #inset
]

{ #category : #api }
IonList >> inset: aBoolean [

	"If 'true', the list will have margin around it and rounded corners.
	
	Type: boolean"

	self propertyAt: #inset put: aBoolean
]

{ #category : #api }
IonList >> lines [

	"How the bottom border should be displayed on all items.
	
	Type: 'full' | 'inset' | 'none'"

	^ self propertyAt: #lines
]

{ #category : #api }
IonList >> lines: aString [

	"How the bottom border should be displayed on all items.
	
	Type: 'full' | 'inset' | 'none'"

	self propertyAt: #lines put: aString
]

{ #category : #api }
IonList >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonList >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]
