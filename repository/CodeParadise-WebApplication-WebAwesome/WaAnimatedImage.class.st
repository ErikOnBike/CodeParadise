Class {
	#name : #WaAnimatedImage,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaAnimatedImage >> alt [

	"A description of the image used by assistive devices.
	
	Type: String"

	^ self propertyAt: #alt
]

{ #category : #accessing }
WaAnimatedImage >> alt: aString [

	"A description of the image used by assistive devices.
	
	Type: String"

	self propertyAt: #alt put: aString
]

{ #category : #convenience }
WaAnimatedImage >> beNotPlay [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self play: false
]

{ #category : #convenience }
WaAnimatedImage >> bePlay [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self play: true
]

{ #category : #accessing }
WaAnimatedImage >> play [

	"Plays the animation. When this attribute is remove, the animation will pause.
	
	Type: Boolean"

	^ self propertyAt: #play
]

{ #category : #accessing }
WaAnimatedImage >> play: aBoolean [

	"Plays the animation. When this attribute is remove, the animation will pause.
	
	Type: Boolean"

	self propertyAt: #play put: aBoolean
]

{ #category : #accessing }
WaAnimatedImage >> src [

	"The path to the image to load.
	
	Type: String"

	^ self propertyAt: #src
]

{ #category : #accessing }
WaAnimatedImage >> src: aString [

	"The path to the image to load.
	
	Type: String"

	self propertyAt: #src put: aString
]
