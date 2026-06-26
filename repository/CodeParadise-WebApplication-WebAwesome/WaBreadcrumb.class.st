Class {
	#name : #WaBreadcrumb,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaBreadcrumb >> label [

	"The label to use for the breadcrumb control. This will not be shown on the screen, but it will be announced by
	screen readers and other assistive devices to provide more context for users.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaBreadcrumb >> label: aString [

	"The label to use for the breadcrumb control. This will not be shown on the screen, but it will be announced by
	screen readers and other assistive devices to provide more context for users.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]
