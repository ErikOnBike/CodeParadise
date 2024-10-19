Class {
	#name : #IonImg,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonImg >> alt [

	"This attribute defines the alternative text describing the image. Users will see this text displayed if the image URL is wrong, the image is not in one of the supported formats, or if the image is not yet downloaded.
	
	Type: string"

	^ self propertyAt: #alt
]

{ #category : #api }
IonImg >> alt: aString [

	"This attribute defines the alternative text describing the image. Users will see this text displayed if the image URL is wrong, the image is not in one of the supported formats, or if the image is not yet downloaded.
	
	Type: string"

	self propertyAt: #alt put: aString
]

{ #category : #api }
IonImg >> src [

	"The image URL. This attribute is mandatory for the '<img>' element.
	
	Type: string"

	^ self propertyAt: #src
]

{ #category : #api }
IonImg >> src: aString [

	"The image URL. This attribute is mandatory for the '<img>' element.
	
	Type: string"

	self propertyAt: #src put: aString
]
