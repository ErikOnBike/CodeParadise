Class {
	#name : #IonButtons,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonButtons >> collapse [

	"If true, buttons will disappear when its parent toolbar has fully collapsed if the toolbar is not the first toolbar. If the toolbar is the first toolbar, the buttons will be hidden and will only be shown once all toolbars have fully collapsed.  Only applies in 'ios' mode with 'collapse' set to 'true' on 'ion-header'.  Typically used for [Collapsible Large Titles](https://ionicframework.com/docs/api/title#collapsible-large-titles)
	
	Type: boolean"

	^ self propertyAt: #collapse
]

{ #category : #api }
IonButtons >> collapse: aBoolean [

	"If true, buttons will disappear when its parent toolbar has fully collapsed if the toolbar is not the first toolbar. If the toolbar is the first toolbar, the buttons will be hidden and will only be shown once all toolbars have fully collapsed.  Only applies in 'ios' mode with 'collapse' set to 'true' on 'ion-header'.  Typically used for [Collapsible Large Titles](https://ionicframework.com/docs/api/title#collapsible-large-titles)
	
	Type: boolean"

	self propertyAt: #collapse put: aBoolean
]
