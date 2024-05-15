"
I am a visual Chart based on ChartJS.

I am responsible for displaying datasets. I support many different chart types.

My current implementation is limited to a few update methods which update the
configuration (Dictionary) provided at instantiation. However, since ChartJS
uses a declarative approach, almost any property can be changed using #propertyAt:put:
allowing the (dynamic) update of my instances.

See for a thorough explanation https://www.chartjs.org
See for some examples CpChartJSExamplesWebApplication

"
Class {
	#name : 'CjsChart',
	#superclass : 'Object',
	#instVars : [
		'element'
	],
	#category : 'CodeParadise-WebApplication-ChartJS-Core',
	#package : 'CodeParadise-WebApplication-ChartJS',
	#tag : 'Core'
}

{ #category : 'class initialization' }
CjsChart class >> loadLibrary [

	"Load library from CDN"

	CpHtmlElement
		documentAddExternalScript: 'https://cdn.jsdelivr.net/npm/chart.js@3.9' ;
		documentAddScript: 'window.cjsCreateChart = function(element, config) {
				const chart = new Chart(element, config);
				element.__cjs_chart = chart;
			};
			window.cjsSetChartProperty = function(element, propertyNames, propertyValue) {
				// Extract last propertyName (remove it from propertyNames collection)
				const propertyName = propertyNames.splice(-1, 1)[0];

				// Find the last property (given the remaining propertyNames)
				const property = propertyNames.reduce(function(property, name, index) {
					if(property[name] === undefined) {

						// Validate if property is Array or Object type (based on next propertyName)
						const propertyIsArray = index + 1 < propertyNames.length && propertyNames[index + 1].substr === undefined;	// If it is a String it will not be an Array
						if(propertyIsArray) {
							return property[name] = [ /* Empty Array */ ];
						} else {
							return property[name] = { /* Empty Object */ };
						}
					}
					return property[name];
				}, element.__cjs_chart);
				property[propertyName] = propertyValue;
			};
			window.cjsUpdateChart = function(element) {
				element.__cjs_chart.update();
			};'
]

{ #category : 'instance creation' }
CjsChart class >> on: anElement config: aDictionary [

	^ self basicNew
		initializeWithElement: anElement config: aDictionary ;
		yourself
]

{ #category : 'class initialization' }
CjsChart class >> postInstallOnce [

	self loadLibrary
]

{ #category : 'accessing' }
CjsChart >> data: aCollection [

	"Replace the data of the datasets with the specified data (a Collection of Collection of values)"

	aCollection withIndexDo: [ :data :index |
		"Datasets are 0-based indexed because it runs in JavaScript environment"
		self propertyAt: { #data . #datasets . index - 1 . #data } put: data ]
]

{ #category : 'accessing' }
CjsChart >> datasets: aCollection [

	"Replace all datasets with the specified collection of datasets (each dataset is Dictionary with #label, #data, etc)"

	self propertyAt: #(data datasets) put: aCollection
]

{ #category : 'initialization' }
CjsChart >> initializeWithElement: anElement config: aDictionary [

	self initialize.

	element := anElement.

	CpDomElement globalApply: #cjsCreateChart withArguments: { element . aDictionary }
]

{ #category : 'accessing' }
CjsChart >> labels: aCollection [

	"Replace all labels with the specified labels (Collection of Strings)"

	self propertyAt: #(data labels) put: aCollection
]

{ #category : 'accessing' }
CjsChart >> propertyAt: anArray put: anObject [

	"Set the specified property (collection of property names/indices) to the specified value.

	The property reference anArray is an Array of Strings and/or Integers. Each String represents
	an accessor and each Integer represents an index.
	It refers to a property within the receiver's configuration. When a String or Integer is
	provided and a property for it does not exist, one is created as an empty Object or empty
	Array (which then gets filled by the remaining property reference entries or the property
	value, depending whether more elements remain in the reference).

	E.g.
		Setting individual setting:
		chart propertyAt: #(options scales y beginAtZero) put: true.

		Setting the full options object (will overwrite )
		chart propertyAt: #(options) put: { #scales -> { #y -> { #beginAtZero -> true } asDictionary } asDictionary } asDictionary.

		Setting the labels for the first dataset (remember JavaScript is 0-based)
		chart propertyAt: #(data datasets 0 labels) put: labels.
	"

	CpDomElement globalApply: #cjsSetChartProperty withArguments: { element . anArray . anObject }
]

{ #category : 'accessing' }
CjsChart >> type: aString [

	"Set the type of chart"

	self propertyAt: #(config type) put: aString
]

{ #category : 'updating' }
CjsChart >> update [

	"Update the Chart (visually)"

	CpDomElement globalApply: #cjsUpdateChart withArguments: { element }
]

{ #category : 'updating' }
CjsChart >> updateData: aCollection [

	"Update all datasets by replacing their data collection with the specified collection of data (aCollection contains collections of values)"

	self data: aCollection.

	self update
]

{ #category : 'updating' }
CjsChart >> updateData: dataCollection labels: labelCollection [

	self labels: labelCollection.
	self updateData: dataCollection
]

{ #category : 'updating' }
CjsChart >> updateDataset: aDictionary [

	"Update receiver by replacing all datasets with the specified dataset (Dictionary)"

	self updateDatasets: { aDictionary }
]

{ #category : 'updating' }
CjsChart >> updateDataset: aDictionary labels: aCollection [

	self labels: aCollection.
	self updateDataset: aDictionary
]

{ #category : 'updating' }
CjsChart >> updateDatasets: aCollection [

	"Update all datasets"

	self datasets: aCollection.

	self update
]

{ #category : 'updating' }
CjsChart >> updateDatasets: datasetCollection labels: labelCollection [

	self labels: labelCollection.
	self updateDatasets: datasetCollection
]

{ #category : 'updating' }
CjsChart >> updateLabels: aCollection [

	"Update all labels by replacing them with the specified labels (Collection of Strings)"

	self labels: aCollection.

	self update
]
