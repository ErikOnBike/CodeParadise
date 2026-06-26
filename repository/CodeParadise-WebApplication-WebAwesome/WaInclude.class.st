Class {
	#name : #WaInclude,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaInclude >> allowScripts [

	"Allows included scripts to be executed. Be sure you trust the content you are including as it will be executed as
	code and can result in XSS attacks.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #allowScripts
]

{ #category : #accessing }
WaInclude >> allowScripts: aBoolean [

	"Allows included scripts to be executed. Be sure you trust the content you are including as it will be executed as
	code and can result in XSS attacks.
	
	Type: Boolean
	Default: false"

	self propertyAt: #allowScripts put: aBoolean
]

{ #category : #convenience }
WaInclude >> beAllowScripts [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self allowScripts: true
]

{ #category : #convenience }
WaInclude >> beNotAllowScripts [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self allowScripts: false
]

{ #category : #accessing }
WaInclude >> mode [

	"The fetch mode to use.
	
	Type: String
	Default: 'cors'
	Allowed: 'cors' | 'no-cors' | 'same-origin'"

	^ self propertyAt: #mode
]

{ #category : #accessing }
WaInclude >> mode: aString [

	"The fetch mode to use.
	
	Type: String
	Default: 'cors'
	Allowed: 'cors' | 'no-cors' | 'same-origin'"

	self propertyAt: #mode put: aString
]

{ #category : #accessing }
WaInclude >> src [

	"The location of the HTML file to include. Be sure you trust the content you are including as it will be executed as
	code and can result in XSS attacks.
	
	Type: String"

	^ self propertyAt: #src
]

{ #category : #accessing }
WaInclude >> src: aString [

	"The location of the HTML file to include. Be sure you trust the content you are including as it will be executed as
	code and can result in XSS attacks.
	
	Type: String"

	self propertyAt: #src put: aString
]
