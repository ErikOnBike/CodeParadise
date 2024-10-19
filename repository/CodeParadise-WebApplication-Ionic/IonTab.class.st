Class {
	#name : #IonTab,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonTab >> active [

	"Type: boolean"

	^ self propertyAt: #active
]

{ #category : #api }
IonTab >> active: aBoolean [

	"Type: boolean"

	self propertyAt: #active put: aBoolean
]

{ #category : #api }
IonTab >> component [

	"The component to display inside of the tab.
	
	Type: ComponentRef"

	^ self propertyAt: #component
]

{ #category : #api }
IonTab >> component: anObject [

	"The component to display inside of the tab.
	
	Type: ComponentRef"

	self propertyAt: #component put: anObject
]

{ #category : #api }
IonTab >> delegate [

	"Type: FrameworkDelegate"

	^ self propertyAt: #delegate
]

{ #category : #api }
IonTab >> delegate: anObject [

	"Type: FrameworkDelegate"

	self propertyAt: #delegate put: anObject
]

{ #category : #api }
IonTab >> setActive [

	"Set the active component for the tab
	
	Type: Promise<void>"

	^ self apply: #setActive resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonTab >> tab [

	"A tab id must be provided for each 'ion-tab'. It's used internally to reference the selected tab or by the router to switch between them.
	
	Type: string"

	^ self propertyAt: #tab
]

{ #category : #api }
IonTab >> tab: aString [

	"A tab id must be provided for each 'ion-tab'. It's used internally to reference the selected tab or by the router to switch between them.
	
	Type: string"

	self propertyAt: #tab put: aString
]
