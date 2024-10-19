Class {
	#name : #IonInfiniteScrollContent,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonInfiniteScrollContent >> loadingSpinner [

	"An animated SVG spinner that shows while loading.
	
	Type: SpinnerTypes | null"

	^ self propertyAt: #loadingSpinner
]

{ #category : #api }
IonInfiniteScrollContent >> loadingSpinner: anObject [

	"An animated SVG spinner that shows while loading.
	
	Type: SpinnerTypes | null"

	self propertyAt: #loadingSpinner put: anObject
]

{ #category : #api }
IonInfiniteScrollContent >> loadingText [

	"Optional text to display while loading. 'loadingText' can accept either plaintext or HTML as a string. To display characters normally reserved for HTML, they must be escaped. For example '<Ionic>' would become '&lt;Ionic&gt;'  For more information: [Security Documentation](https://ionicframework.com/docs/faq/security)  This property accepts custom HTML as a string. Content is parsed as plaintext by default. 'innerHTMLTemplatesEnabled' must be set to 'true' in the Ionic config before custom HTML can be used.
	
	Type: string | IonicSafeString"

	^ self propertyAt: #loadingText
]

{ #category : #api }
IonInfiniteScrollContent >> loadingText: anObject [

	"Optional text to display while loading. 'loadingText' can accept either plaintext or HTML as a string. To display characters normally reserved for HTML, they must be escaped. For example '<Ionic>' would become '&lt;Ionic&gt;'  For more information: [Security Documentation](https://ionicframework.com/docs/faq/security)  This property accepts custom HTML as a string. Content is parsed as plaintext by default. 'innerHTMLTemplatesEnabled' must be set to 'true' in the Ionic config before custom HTML can be used.
	
	Type: string | IonicSafeString"

	self propertyAt: #loadingText put: anObject
]
