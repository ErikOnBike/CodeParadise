Class {
	#name : #IonHeader,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonHeader >> collapse [

	"Describes the scroll effect that will be applied to the header. Only applies in iOS mode.  Typically used for [Collapsible Large Titles](https://ionicframework.com/docs/api/title#collapsible-large-titles)
	
	Type: 'condense' | 'fade'"

	^ self propertyAt: #collapse
]

{ #category : #api }
IonHeader >> collapse: aString [

	"Describes the scroll effect that will be applied to the header. Only applies in iOS mode.  Typically used for [Collapsible Large Titles](https://ionicframework.com/docs/api/title#collapsible-large-titles)
	
	Type: 'condense' | 'fade'"

	self propertyAt: #collapse put: aString
]

{ #category : #api }
IonHeader >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonHeader >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonHeader >> translucent [

	"If 'true', the header will be translucent. Only applies when the mode is ''ios'' and the device supports ['backdrop-filter'](https://developer.mozilla.org/en-US/docs/Web/CSS/backdrop-filter#Browser_compatibility).  Note: In order to scroll content behind the header, the 'fullscreen' attribute needs to be set on the content.
	
	Type: boolean"

	^ self propertyAt: #translucent
]

{ #category : #api }
IonHeader >> translucent: aBoolean [

	"If 'true', the header will be translucent. Only applies when the mode is ''ios'' and the device supports ['backdrop-filter'](https://developer.mozilla.org/en-US/docs/Web/CSS/backdrop-filter#Browser_compatibility).  Note: In order to scroll content behind the header, the 'fullscreen' attribute needs to be set on the content.
	
	Type: boolean"

	self propertyAt: #translucent put: aBoolean
]
