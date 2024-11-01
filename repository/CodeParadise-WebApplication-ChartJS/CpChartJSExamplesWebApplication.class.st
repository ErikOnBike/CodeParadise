Class {
	#name : #CpChartJSExamplesWebApplication,
	#superclass : #CpWebApplication,
	#category : #'CodeParadise-WebApplication-ChartJS-Examples'
}

{ #category : #accessing }
CpChartJSExamplesWebApplication class >> app [

	"Answer the unique identifier (a Symbol) for the receiver"

	^ #'ChartJS-Examples'
]

{ #category : #installing }
CpChartJSExamplesWebApplication >> extensionMethodCategories [

	"Answer the collection of extension method categories needed for the receiver"

	^ super extensionMethodCategories,
		#(webApplicationShoelaceExtension)
]
