Class {
	#name : #CpComponentExamplesWebApplication,
	#superclass : #CpWebApplication,
	#category : #'CodeParadise-Beach-Examples'
}

{ #category : #accessing }
CpComponentExamplesWebApplication class >> app [

	"Answer the unique identifier (a Symbol) for the receiver"

	^ #'Component-Examples'
]

{ #category : #installing }
CpComponentExamplesWebApplication >> extensionMethodCategories [

	"Answer the collection of extension method categories needed for the receiver"

	^ super extensionMethodCategories,
		#(webApplicationFontAwesomeExtension)
]
