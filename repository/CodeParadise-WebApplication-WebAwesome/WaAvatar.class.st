Class {
	#name : #WaAvatar,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaAvatar >> image [

	"The image source to use for the avatar.
	
	Type: String
	Default: ''"

	^ self propertyAt: #image
]

{ #category : #accessing }
WaAvatar >> image: aString [

	"The image source to use for the avatar.
	
	Type: String
	Default: ''"

	self propertyAt: #image put: aString
]

{ #category : #accessing }
WaAvatar >> initials [

	"Initials to use as a fallback when no image is available (1-2 characters max recommended).
	
	Type: String
	Default: ''"

	^ self propertyAt: #initials
]

{ #category : #accessing }
WaAvatar >> initials: aString [

	"Initials to use as a fallback when no image is available (1-2 characters max recommended).
	
	Type: String
	Default: ''"

	self propertyAt: #initials put: aString
]

{ #category : #accessing }
WaAvatar >> label [

	"A label to use to describe the avatar to assistive devices.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaAvatar >> label: aString [

	"A label to use to describe the avatar to assistive devices.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #accessing }
WaAvatar >> loading [

	"Indicates how the browser should load the image.
	
	Type: String
	Default: 'eager'
	Allowed: 'eager' | 'lazy'"

	^ self propertyAt: #loading
]

{ #category : #accessing }
WaAvatar >> loading: aString [

	"Indicates how the browser should load the image.
	
	Type: String
	Default: 'eager'
	Allowed: 'eager' | 'lazy'"

	self propertyAt: #loading put: aString
]

{ #category : #accessing }
WaAvatar >> shape [

	"The shape of the avatar.
	
	Type: String
	Default: 'circle'
	Allowed: 'circle' | 'square' | 'rounded'"

	^ self propertyAt: #shape
]

{ #category : #accessing }
WaAvatar >> shape: aString [

	"The shape of the avatar.
	
	Type: String
	Default: 'circle'
	Allowed: 'circle' | 'square' | 'rounded'"

	self propertyAt: #shape put: aString
]
