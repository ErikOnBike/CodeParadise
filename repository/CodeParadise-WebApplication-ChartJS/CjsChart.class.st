Class {
	#name : #CjsChart,
	#superclass : #Object,
	#instVars : [
		'element'
	],
	#category : #'CodeParadise-WebApplication-ChartJS-Core'
}

{ #category : #'class initialization' }
CjsChart class >> loadLibrary [

	"Load library from CDN"

	CpHtmlElement documentHead
		appendChild:
			((CpHtmlElement newWithTag: #script)
				attributeAt: #src put: 'https://cdn.jsdelivr.net/npm/chart.js' ;
				yourself) ;
		appendChild:
			((CpHtmlElement newWithTag: #script)
				textContent: 'window.cjsCreateChart = function(element, config) {
					const chart = new Chart(element, config);
					element.__cjs_chart = chart;
				};
				window.cjsSetChartLabels = function(element, labels) {
					element.__cjs_chart.data.labels = labels;
				};
				window.cjsSetChartDatasets = function(element, datasets) {
					element.__cjs_chart.data.datasets = datasets;
				};
				window.cjsSetChartData = function(element, data) {
					const datasets = element.__cjs_chart.data.datasets;
					if(datasets.length !== data.length) {
						console.error("Data size does not match dataset size");
					}
					for(let i = datasets.length - 1; i >= 0; i--) {
						datasets[i].data = data[i];
					}
				};
				window.cjsSetChartType = function(element, type) {
					element.__cjs_chart.config._config.type = type;
				};
				window.cjsUpdateChart = function(element) {
					element.__cjs_chart.update();
				};'
				yourself)
]

{ #category : #'instance creation' }
CjsChart class >> on: anElement config: aDictionary [

	^ self basicNew
		initializeWithElement: anElement config: aDictionary ;
		yourself
]

{ #category : #'class initialization' }
CjsChart class >> postInstallOnce [

	self loadLibrary
]

{ #category : #accessing }
CjsChart >> data: aCollection [

	"Replace (the first) dataset's data with the specified data (Collection of values)"

	CpDomElement globalApply: #cjsSetChartData withArguments: { element . aCollection }
]

{ #category : #accessing }
CjsChart >> datasets: aCollection [

	"Replace all datasets with the specified collection of datasets (each dataset is Dictionary with #label, #data, etc)"

	CpDomElement globalApply: #cjsSetChartDatasets withArguments: { element . aCollection }
]

{ #category : #initialization }
CjsChart >> initializeWithElement: anElement config: aDictionary [

	self initialize.

	element := anElement.

	CpDomElement globalApply: #cjsCreateChart withArguments: { element . aDictionary }
]

{ #category : #accessing }
CjsChart >> labels: aCollection [

	"Replace all labels with the specified labels (Collection of Strings)"

	CpDomElement globalApply: #cjsSetChartLabels withArguments: { element . aCollection }
]

{ #category : #accessing }
CjsChart >> type: aString [

	"Set the type of chart"

	CpDomElement globalApply: #cjsSetChartType withArguments: { element . aString }
]

{ #category : #updating }
CjsChart >> update [

	"Update the Chart (visually)"

	CpDomElement globalApply: #cjsUpdateChart withArguments: { element }
]

{ #category : #updating }
CjsChart >> updateData: aCollection [

	"Update all datasets by replacing their data collection with the specified collection of data (aCollection contains collections of values)"

	self data: aCollection.

	self update
]

{ #category : #updating }
CjsChart >> updateData: dataCollection labels: labelCollection [

	self labels: labelCollection.
	self updateData: dataCollection
]

{ #category : #updating }
CjsChart >> updateDataset: aDictionary [

	"Update receiver by replacing all datasets with the specified dataset (Dictionary)"

	self updateDatasets: { aDictionary }
]

{ #category : #updating }
CjsChart >> updateDataset: aDictionary labels: aCollection [

	self labels: aCollection.
	self updateDataset: aDictionary
]

{ #category : #updating }
CjsChart >> updateDatasets: aCollection [

	"Update all datasets"

	self datasets: aCollection.

	self update
]

{ #category : #updating }
CjsChart >> updateDatasets: datasetCollection labels: labelCollection [

	self labels: labelCollection.
	self updateDatasets: datasetCollection
]

{ #category : #updating }
CjsChart >> updateLabels: aCollection [

	"Update all labels by replacing them with the specified labels (Collection of Strings)"

	self labels: aCollection.

	self update
]
