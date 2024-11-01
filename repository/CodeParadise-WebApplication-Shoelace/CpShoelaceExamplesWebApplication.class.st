Class {
	#name : #CpShoelaceExamplesWebApplication,
	#superclass : #CpWebApplication,
	#category : #'CodeParadise-WebApplication-Shoelace-Examples'
}

{ #category : #accessing }
CpShoelaceExamplesWebApplication class >> app [

	"Answer the unique identifier (a Symbol) for the receiver"

	^ #'Shoelace-Examples'
]

{ #category : #installing }
CpShoelaceExamplesWebApplication >> extensionMethodCategories [

	"Answer the collection of extension method categories needed for the receiver"

	^ super extensionMethodCategories,
		#(webApplicationShoelaceExtension)
]
