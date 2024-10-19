Class {
	#name : #IonFab,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonFab >> activated [

	"If 'true', both the 'ion-fab-button' and all 'ion-fab-list' inside 'ion-fab' will become active. That means 'ion-fab-button' will become a 'close' icon and 'ion-fab-list' will become visible.
	
	Type: boolean"

	^ self propertyAt: #activated
]

{ #category : #api }
IonFab >> activated: aBoolean [

	"If 'true', both the 'ion-fab-button' and all 'ion-fab-list' inside 'ion-fab' will become active. That means 'ion-fab-button' will become a 'close' icon and 'ion-fab-list' will become visible.
	
	Type: boolean"

	self propertyAt: #activated put: aBoolean
]

{ #category : #api }
IonFab >> close [

	"Close an active FAB list container.
	
	Type: Promise<void>"

	^ self apply: #close resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonFab >> edge [

	"If 'true', the fab will display on the edge of the header if 'vertical' is ''top'', and on the edge of the footer if it is ''bottom''. Should be used with a 'fixed' slot.
	
	Type: boolean"

	^ self propertyAt: #edge
]

{ #category : #api }
IonFab >> edge: aBoolean [

	"If 'true', the fab will display on the edge of the header if 'vertical' is ''top'', and on the edge of the footer if it is ''bottom''. Should be used with a 'fixed' slot.
	
	Type: boolean"

	self propertyAt: #edge put: aBoolean
]

{ #category : #api }
IonFab >> horizontal [

	"Where to align the fab horizontally in the viewport.
	
	Type: 'start' | 'end' | 'center'"

	^ self propertyAt: #horizontal
]

{ #category : #api }
IonFab >> horizontal: aString [

	"Where to align the fab horizontally in the viewport.
	
	Type: 'start' | 'end' | 'center'"

	self propertyAt: #horizontal put: aString
]

{ #category : #api }
IonFab >> toggle [

	"Opens/Closes the FAB list container.
	
	Type: Promise<void>"

	^ self apply: #toggle resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonFab >> vertical [

	"Where to align the fab vertically in the viewport.
	
	Type: 'top' | 'bottom' | 'center'"

	^ self propertyAt: #vertical
]

{ #category : #api }
IonFab >> vertical: aString [

	"Where to align the fab vertically in the viewport.
	
	Type: 'top' | 'bottom' | 'center'"

	self propertyAt: #vertical put: aString
]
