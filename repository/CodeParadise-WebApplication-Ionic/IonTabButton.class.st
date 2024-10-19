Class {
	#name : #IonTabButton,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonTabButton >> disabled [

	"If 'true', the user cannot interact with the tab button.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonTabButton >> disabled: aBoolean [

	"If 'true', the user cannot interact with the tab button.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonTabButton >> download [

	"This attribute instructs browsers to download a URL instead of navigating to it, so the user will be prompted to save it as a local file. If the attribute has a value, it is used as the pre-filled file name in the Save prompt (the user can still change the file name if they want).
	
	Type: string | undefined"

	^ self propertyAt: #download
]

{ #category : #api }
IonTabButton >> download: aString [

	"This attribute instructs browsers to download a URL instead of navigating to it, so the user will be prompted to save it as a local file. If the attribute has a value, it is used as the pre-filled file name in the Save prompt (the user can still change the file name if they want).
	
	Type: string | undefined"

	self propertyAt: #download put: aString
]

{ #category : #api }
IonTabButton >> href [

	"Contains a URL or a URL fragment that the hyperlink points to. If this property is set, an anchor tag will be rendered.
	
	Type: string | undefined"

	^ self propertyAt: #href
]

{ #category : #api }
IonTabButton >> href: aString [

	"Contains a URL or a URL fragment that the hyperlink points to. If this property is set, an anchor tag will be rendered.
	
	Type: string | undefined"

	self propertyAt: #href put: aString
]

{ #category : #api }
IonTabButton >> layout [

	"Set the layout of the text and icon in the tab bar. It defaults to ''icon-top''.
	
	Type: TabButtonLayout"

	^ self propertyAt: #layout
]

{ #category : #api }
IonTabButton >> layout: anObject [

	"Set the layout of the text and icon in the tab bar. It defaults to ''icon-top''.
	
	Type: TabButtonLayout"

	self propertyAt: #layout put: anObject
]

{ #category : #api }
IonTabButton >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonTabButton >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonTabButton >> rel [

	"Specifies the relationship of the target object to the link object. The value is a space-separated list of [link types](https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types).
	
	Type: string | undefined"

	^ self propertyAt: #rel
]

{ #category : #api }
IonTabButton >> rel: aString [

	"Specifies the relationship of the target object to the link object. The value is a space-separated list of [link types](https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types).
	
	Type: string | undefined"

	self propertyAt: #rel put: aString
]

{ #category : #api }
IonTabButton >> selected [

	"The selected tab component
	
	Type: boolean"

	^ self propertyAt: #selected
]

{ #category : #api }
IonTabButton >> selected: aBoolean [

	"The selected tab component
	
	Type: boolean"

	self propertyAt: #selected put: aBoolean
]

{ #category : #api }
IonTabButton >> tab [

	"A tab id must be provided for each 'ion-tab'. It's used internally to reference the selected tab or by the router to switch between them.
	
	Type: string"

	^ self propertyAt: #tab
]

{ #category : #api }
IonTabButton >> tab: aString [

	"A tab id must be provided for each 'ion-tab'. It's used internally to reference the selected tab or by the router to switch between them.
	
	Type: string"

	self propertyAt: #tab put: aString
]

{ #category : #api }
IonTabButton >> target [

	"Specifies where to display the linked URL. Only applies when an 'href' is provided. Special keywords: ''_blank'', ''_self'', ''_parent'', ''_top''.
	
	Type: string | undefined"

	^ self propertyAt: #target
]

{ #category : #api }
IonTabButton >> target: aString [

	"Specifies where to display the linked URL. Only applies when an 'href' is provided. Special keywords: ''_blank'', ''_self'', ''_parent'', ''_top''.
	
	Type: string | undefined"

	self propertyAt: #target put: aString
]
