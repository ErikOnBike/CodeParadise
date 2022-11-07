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

{ #category : #accessing }
CpChartJSExamplesWebApplication class >> clientBehaviorClass [

	^ CpChartJSExamplesClientBehavior
]

{ #category : #installing }
CpChartJSExamplesWebApplication >> installExtensionMethods [

	"Install the extension methods from known Classes (include Shoelace extensions)"

	super installExtensionMethods.

	self installExtensionMethodsFor: #webApplicationShoelaceExtension
]
