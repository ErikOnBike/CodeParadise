Class {
	#name : #CynSpotlightHelpViewButton,
	#superclass : #CpTemplateComponent,
	#category : #'CodeParadise-Canyon-App-Help'
}

{ #category : #'web resources' }
CynSpotlightHelpViewButton class >> style [

	<webResource: #css>

	^ '*, *:before, *:after {
	box-sizing: border-box;
}
:host {
	display: inline;
}'
]

{ #category : #'web resources' }
CynSpotlightHelpViewButton class >> template [

	<webResource: #html>

	^ '<ion-button part="button" size="small" shape="round"><slot></slot></ion-button>'
]

{ #category : #'event hand' }
CynSpotlightHelpViewButton >> handleClick [

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
CynSpotlightHelpViewButton >> initialize [

	super initialize.

	self when: CpClickEvent deferSend: #handleClick to: self
]

{ #category : #view }
CynSpotlightHelpViewButton >> showFeatureForButton: aButton [

	aButton ifNil: [ ^ self ].

	aButton apply: #click
]

{ #category : #view }
CynSpotlightHelpViewButton >> showMenu [

	CynApp current menu open await
]

{ #category : #view }
CynSpotlightHelpViewButton >> showToolbarLeftFeature [

	self showFeatureForButton: self toolbarLeftButton
]

{ #category : #view }
CynSpotlightHelpViewButton >> showToolbarRightFeature [

	self showFeatureForButton: self toolbarRightButton
]

{ #category : #view }
CynSpotlightHelpViewButton >> toolbarLeftButton [

	^ CynApp current activeToolbar ifNotNil: [ :toolbar |
		(toolbar firstDescendantMatching: '[slot="start"] > ion-button:first-child') ]
]

{ #category : #view }
CynSpotlightHelpViewButton >> toolbarRightButton [

	^ CynApp current activeToolbar ifNotNil: [ :toolbar |
		(toolbar firstDescendantMatching: '[slot="end"] > ion-button:last-child') ]
]
