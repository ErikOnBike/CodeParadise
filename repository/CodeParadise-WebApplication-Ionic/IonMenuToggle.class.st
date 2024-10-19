Class {
	#name : #IonMenuToggle,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonMenuToggle >> autoHide [

	"Automatically hides the content when the corresponding menu is not active.  By default, it's 'true'. Change it to 'false' in order to keep 'ion-menu-toggle' always visible regardless the state of the menu.
	
	Type: boolean"

	^ self propertyAt: #autoHide
]

{ #category : #api }
IonMenuToggle >> autoHide: aBoolean [

	"Automatically hides the content when the corresponding menu is not active.  By default, it's 'true'. Change it to 'false' in order to keep 'ion-menu-toggle' always visible regardless the state of the menu.
	
	Type: boolean"

	self propertyAt: #autoHide put: aBoolean
]

{ #category : #api }
IonMenuToggle >> menu [

	"Optional property that maps to a Menu's 'menuId' prop. Can also be 'start' or 'end' for the menu side. This is used to find the correct menu to toggle.  If this property is not used, 'ion-menu-toggle' will toggle the first menu that is active.
	
	Type: string"

	^ self propertyAt: #menu
]

{ #category : #api }
IonMenuToggle >> menu: aString [

	"Optional property that maps to a Menu's 'menuId' prop. Can also be 'start' or 'end' for the menu side. This is used to find the correct menu to toggle.  If this property is not used, 'ion-menu-toggle' will toggle the first menu that is active.
	
	Type: string"

	self propertyAt: #menu put: aString
]
