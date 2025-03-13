Class {
	#name : #CpPropertyModelPage,
	#superclass : #CpCanyonAppPage,
	#category : #'CodeParadise-Canyon-App-View'
}

{ #category : #'web resources' }
CpPropertyModelPage class >> style [

	<webResource: #css>

	^ '@import url("https://cdn.jsdelivr.net/npm/@ionic/core/css/ionic.bundle.css");
*, *:before, *:after {
	box-sizing: border-box;
}
:host {
	background-color: var(--ion-background-color);
}
#container {
	height: 100%;
}'

]

{ #category : #'web resources' }
CpPropertyModelPage class >> template [

	<webResource: #html>

	^ '<div id="container"><slot></slot></div>'
]

{ #category : #accessing }
CpPropertyModelPage >> hasModel [

	"Answer whether a model is present in the receiver"

	^ self model isNotNil
]

{ #category : #accessing }
CpPropertyModelPage >> model [

	"Answer the model of the receiver (or nil if none is present).

	Implementation:
	It is assumed the receiver has a single child view containing the actual model.
	This child view is typically a CpPropertyModelView or subclass."

	^ self firstChild
		ifNotNil: [ :firstChild | firstChild model ]
]

{ #category : #accessing }
CpPropertyModelPage >> model: aModel [

	"Replace the receiver's child view with a new ModelView on the specified model"

	"Remove the model from the existing child view"
	self firstChild ifNotNil: [ :firstChild |
		firstChild model: nil ].

	self replaceAllChildrenWith: aModel inModelView
]

{ #category : #accessing }
CpPropertyModelPage >> title [

	"Answer the title of the receiver, based on the model's title"

	^ self firstChild
		ifNotNil: [ :child | child title ]
]

{ #category : #'event handling' }
CpPropertyModelPage >> updateAfterNavigate [

	"Update the receiver after a navigation has been performed"

	super updateAfterNavigate.

	self firstChild
		ifNotNil: [ :firstChild | firstChild updateAfterNavigate ]
]
