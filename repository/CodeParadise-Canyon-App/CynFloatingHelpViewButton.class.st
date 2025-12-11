Class {
	#name : #CynFloatingHelpViewButton,
	#superclass : #CpTemplateComponent,
	#category : #'CodeParadise-Canyon-App-View'
}

{ #category : #'web resources' }
CynFloatingHelpViewButton class >> style [

	<webResource: #css>

	^ '*, *:before, *:after {
	box-sizing: border-box;
}
:host {
	display: inline;
}'
]

{ #category : #'web resources' }
CynFloatingHelpViewButton class >> template [

	<webResource: #html>

	^ '<ion-button part="button" size="small" shape="round"><slot></slot></ion-button>'
]

{ #category : #'event hand' }
CynFloatingHelpViewButton >> handleClick [

	(self attributeAt: #button) ifNotNil: [ :button |
		button = #'menu'
			ifTrue: [ self showMenu ]
			ifFalse: [
				button = #'toolbar-right'
					ifTrue: [ self showToolbarRightFeature ]
					ifFalse: [
						button = #'toolbar-left'
							ifTrue: [ self showToolbarLeftFeature ] ] ] ]
]

{ #category : #initialization }
CynFloatingHelpViewButton >> initialize [

	super initialize.

	self when: CpClickEvent deferSend: #handleClick to: self
]

{ #category : #view }
CynFloatingHelpViewButton >> showFeatureForButton: aButton [

	aButton ifNil: [ ^ self ].

	aButton apply: #click
]

{ #category : #view }
CynFloatingHelpViewButton >> showMenu [

	CynApp current menu open await
]

{ #category : #view }
CynFloatingHelpViewButton >> showToolbarLeftFeature [

	self showFeatureForButton: self toolbarLeftButton
]

{ #category : #view }
CynFloatingHelpViewButton >> showToolbarRightFeature [

	self showFeatureForButton: self toolbarRightButton
]

{ #category : #view }
CynFloatingHelpViewButton >> toolbarLeftButton [

	^ CynApp current activeToolbar ifNotNil: [ :toolbar |
		(toolbar firstDescendantMatching: '[slot="start"] > ion-button:first-child') ]
]

{ #category : #view }
CynFloatingHelpViewButton >> toolbarRightButton [

	^ CynApp current activeToolbar ifNotNil: [ :toolbar |
		(toolbar firstDescendantMatching: '[slot="end"] > ion-button:last-child') ]
]
