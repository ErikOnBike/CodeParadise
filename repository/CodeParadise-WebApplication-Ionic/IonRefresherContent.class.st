Class {
	#name : #IonRefresherContent,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonRefresherContent >> pullingIcon [

	"A static icon or a spinner to display when you begin to pull down. A spinner name can be provided to gradually show tick marks when pulling down on iOS devices.
	
	Type: SpinnerTypes | string | null"

	^ self propertyAt: #pullingIcon
]

{ #category : #api }
IonRefresherContent >> pullingIcon: anObject [

	"A static icon or a spinner to display when you begin to pull down. A spinner name can be provided to gradually show tick marks when pulling down on iOS devices.
	
	Type: SpinnerTypes | string | null"

	self propertyAt: #pullingIcon put: anObject
]

{ #category : #api }
IonRefresherContent >> pullingText [

	"The text you want to display when you begin to pull down. 'pullingText' can accept either plaintext or HTML as a string. To display characters normally reserved for HTML, they must be escaped. For example '<Ionic>' would become '&lt;Ionic&gt;'  For more information: [Security Documentation](https://ionicframework.com/docs/faq/security)  Content is parsed as plaintext by default. 'innerHTMLTemplatesEnabled' must be set to 'true' in the Ionic config before custom HTML can be used.
	
	Type: string | IonicSafeString"

	^ self propertyAt: #pullingText
]

{ #category : #api }
IonRefresherContent >> pullingText: anObject [

	"The text you want to display when you begin to pull down. 'pullingText' can accept either plaintext or HTML as a string. To display characters normally reserved for HTML, they must be escaped. For example '<Ionic>' would become '&lt;Ionic&gt;'  For more information: [Security Documentation](https://ionicframework.com/docs/faq/security)  Content is parsed as plaintext by default. 'innerHTMLTemplatesEnabled' must be set to 'true' in the Ionic config before custom HTML can be used.
	
	Type: string | IonicSafeString"

	self propertyAt: #pullingText put: anObject
]

{ #category : #api }
IonRefresherContent >> refreshingSpinner [

	"An animated SVG spinner that shows when refreshing begins
	
	Type: SpinnerTypes | null"

	^ self propertyAt: #refreshingSpinner
]

{ #category : #api }
IonRefresherContent >> refreshingSpinner: anObject [

	"An animated SVG spinner that shows when refreshing begins
	
	Type: SpinnerTypes | null"

	self propertyAt: #refreshingSpinner put: anObject
]

{ #category : #api }
IonRefresherContent >> refreshingText [

	"The text you want to display when performing a refresh. 'refreshingText' can accept either plaintext or HTML as a string. To display characters normally reserved for HTML, they must be escaped. For example '<Ionic>' would become '&lt;Ionic&gt;'  For more information: [Security Documentation](https://ionicframework.com/docs/faq/security)  Content is parsed as plaintext by default. 'innerHTMLTemplatesEnabled' must be set to 'true' in the Ionic config before custom HTML can be used.
	
	Type: string | IonicSafeString"

	^ self propertyAt: #refreshingText
]

{ #category : #api }
IonRefresherContent >> refreshingText: anObject [

	"The text you want to display when performing a refresh. 'refreshingText' can accept either plaintext or HTML as a string. To display characters normally reserved for HTML, they must be escaped. For example '<Ionic>' would become '&lt;Ionic&gt;'  For more information: [Security Documentation](https://ionicframework.com/docs/faq/security)  Content is parsed as plaintext by default. 'innerHTMLTemplatesEnabled' must be set to 'true' in the Ionic config before custom HTML can be used.
	
	Type: string | IonicSafeString"

	self propertyAt: #refreshingText put: anObject
]
