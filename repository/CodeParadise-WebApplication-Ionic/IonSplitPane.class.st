Class {
	#name : #IonSplitPane,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonSplitPane >> contentId [

	"The 'id' of the main content. When using a router this is typically 'ion-router-outlet'. When not using a router, this is typically your main view's 'ion-content'. This is not the id of the 'ion-content' inside of your 'ion-menu'.
	
	Type: string"

	^ self propertyAt: #contentId
]

{ #category : #api }
IonSplitPane >> contentId: aString [

	"The 'id' of the main content. When using a router this is typically 'ion-router-outlet'. When not using a router, this is typically your main view's 'ion-content'. This is not the id of the 'ion-content' inside of your 'ion-menu'.
	
	Type: string"

	self propertyAt: #contentId put: aString
]

{ #category : #api }
IonSplitPane >> disabled [

	"If 'true', the split pane will be hidden.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonSplitPane >> disabled: aBoolean [

	"If 'true', the split pane will be hidden.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonSplitPane >> isVisible [

	"Type: Promise<boolean>"

	^ self apply: #isVisible resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonSplitPane >> when [

	"When the split-pane should be shown. Can be a CSS media query expression, or a shortcut expression. Can also be a boolean expression.
	
	Type: string | boolean"

	^ self propertyAt: #when
]

{ #category : #api }
IonSplitPane >> when: anObject [

	"When the split-pane should be shown. Can be a CSS media query expression, or a shortcut expression. Can also be a boolean expression.
	
	Type: string | boolean"

	self propertyAt: #when put: anObject
]
