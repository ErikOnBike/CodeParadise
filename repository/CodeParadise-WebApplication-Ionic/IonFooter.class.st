Class {
	#name : #IonFooter,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonFooter >> collapse [

	"Describes the scroll effect that will be applied to the footer. Only applies in iOS mode.
	
	Type: 'fade'"

	^ self propertyAt: #collapse
]

{ #category : #api }
IonFooter >> collapse: aString [

	"Describes the scroll effect that will be applied to the footer. Only applies in iOS mode.
	
	Type: 'fade'"

	self propertyAt: #collapse put: aString
]

{ #category : #api }
IonFooter >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonFooter >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonFooter >> translucent [

	"If 'true', the footer will be translucent. Only applies when the mode is ''ios'' and the device supports ['backdrop-filter'](https://developer.mozilla.org/en-US/docs/Web/CSS/backdrop-filter#Browser_compatibility).  Note: In order to scroll content behind the footer, the 'fullscreen' attribute needs to be set on the content.
	
	Type: boolean"

	^ self propertyAt: #translucent
]

{ #category : #api }
IonFooter >> translucent: aBoolean [

	"If 'true', the footer will be translucent. Only applies when the mode is ''ios'' and the device supports ['backdrop-filter'](https://developer.mozilla.org/en-US/docs/Web/CSS/backdrop-filter#Browser_compatibility).  Note: In order to scroll content behind the footer, the 'fullscreen' attribute needs to be set on the content.
	
	Type: boolean"

	self propertyAt: #translucent put: aBoolean
]
