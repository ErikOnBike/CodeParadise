Class {
	#name : #CpChartJSExamplesWebClientBehavior,
	#superclass : #CpWebClientBehavior,
	#category : #'CodeParadise-WebApplication-ChartJS-Examples'
}

{ #category : #'class initialization' }
CpChartJSExamplesWebClientBehavior class >> beLoaded [

	CpTransition beLoaded
]

{ #category : #examples }
CpChartJSExamplesWebClientBehavior >> exampleBarChartRandom [

	<example: 'Bar chart random' order: 30>

	| outputElement chartElement chart dataBlock labelsBlock repeatBlock animationBlock |

	"Clear content"
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: (chartElement := CpHtmlElement newWithTag: #canvas).

	dataBlock := [ :size |
		| data |
		data := Array new: size.
		1 to: size do: [ :index | data at: index put: 50 atRandom - 25 ].
		data
	].
	labelsBlock := [ :size |
		#('January' 'February' 'March' 'April' 'May' 'June' 'July' 'August' 'September' 'October' 'November' 'December') first: size ].
 
	chart := CjsChart on: chartElement config: {
		#type -> #bar.
		#data -> {
			#labels -> { }.
			#datasets -> {
				{
					#label -> 'Dataset 1'.
					#backgroundColor -> '#f28e2c'.
					#data -> { }
				} asDictionary.
				{
					#label -> 'Dataset 2'.
					#backgroundColor -> '#4e79a7'.
					#data -> { }
				} asDictionary.
				{
					#label -> 'Dataset 3'.
					#backgroundColor -> '#59a14f'.
					#data -> { }
				} asDictionary
			}
		} asDictionary.
		#options -> {  } asDictionary
	} asDictionary.

	animationBlock := [
		"Check whether the chart is still visible (still attached to the output area)"
		chartElement parent ifNotNil: [

			| data count |
			count := 5 atRandom + 5.

			"Create 3 datasets"
			data := {
				dataBlock value: count.
				dataBlock value: count.
				dataBlock value: count
			}.
			chart updateData: data labels: (labelsBlock value: count).

			"Repeat the operation"
			repeatBlock value ]
	].

	repeatBlock := [
		(CpTransition onBlock: animationBlock)
			duration: 0 ;	"Execute once"
			startDelayedBy: 2000 ].

	"Start repetition"
	self showProgressBar: 2000.
	repeatBlock value
]

{ #category : #examples }
CpChartJSExamplesWebClientBehavior >> exampleDoughnutChartRandom [

	<example: 'Doughnut chart random' order: 50>

	| outputElement chartElement chart dataBlock labelsBlock repeatBlock animationBlock |

	"Clear content"
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: (chartElement := CpHtmlElement newWithTag: #canvas).

	dataBlock := [
		| count data |
		count := 5 atRandom + 5.
		data := Array new: count.
		1 to: count do: [ :index | data at: index put: 50 atRandom ].
		data
	].
	labelsBlock := [ :size |
		#('January' 'February' 'March' 'April' 'May' 'June' 'July' 'August' 'September' 'October' 'November' 'December') first: size ].
 
	chart := CjsChart on: chartElement config: {
		#type -> #doughnut.
		#data -> {
			#datasets -> {
				{
					#label -> 'Doughnut chart'.
					#backgroundColor -> { '#4e79a7' . '#f28e2c' . '#e15759' . '#76b7b2' . '#59a14f' . '#edc949' . '#af7aa1' . '#ff9da7' . '#9c755f' . 'bab0ab' }.
					#hoverOffset -> 4.
					#data -> { }
				} asDictionary
			}.
			#labels -> { }
		} asDictionary.
		#options -> {
			#responsive -> true
		} asDictionary
	} asDictionary.

	animationBlock := [
		"Check whether the chart is still visible (still attached to the output area)"
		chartElement parent ifNotNil: [

			| data |

			data := dataBlock value.
			chart updateData: { data } labels: (labelsBlock value: data size).

			"Repeat the operation"
			repeatBlock value ]
	].

	repeatBlock := [
		(CpTransition onBlock: animationBlock)
			duration: 0 ;	"Execute once"
			startDelayedBy: 2000 ].

	"Start repetition"
	self showProgressBar: 2000.
	repeatBlock value
]

{ #category : #examples }
CpChartJSExamplesWebClientBehavior >> exampleLineChart [

	<example: 'Line chart' order: 10>

	| outputElement chartElement chart |

	"Clear content"
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: ('Use the range selector below to set the line tension' inHtmlTag: #p).

	outputElement appendChild: ((CpHtmlElement newWithTag: #input)
		attributeAt: #type put: #range ;
		attributeAt: #min put: '0' ;
		attributeAt: #value put: '0' ;
		attributeAt: #max put: '4' ;
		attributeAt: #step put: '0.1' ;
		styleAt: #width put: '30em' ;
		when: CpChangeEvent do: [ :changeEvent |
			chart ifNotNil: [
				chart
					propertyAt: #(data datasets 0 tension) put: (changeEvent currentTarget propertyAt: #value) ;
					update ] ] for: self ;
		yourself).

	outputElement appendChild: (chartElement := CpHtmlElement newWithTag: #canvas).
 
	chart := CjsChart on: chartElement config: {
		#type -> #line.
		#data -> {
			#labels -> { 'January' . 'February' . 'March' . 'April' . 'May' . 'June' }.
			#datasets -> {
				{
					#label -> 'Line chart'.
					#backgroundColor -> 'rgb(255, 99, 132)'.
					#borderColor -> 'rgb(255, 99, 132)'.
					#data -> { 0 . 10 . 5 . 2 . 20 . 30 . 45 }
				} asDictionary
			}
		} asDictionary.
		#options -> {
			#responsive -> true
		} asDictionary
	} asDictionary
]

{ #category : #examples }
CpChartJSExamplesWebClientBehavior >> exampleLineChartRandom [

	<example: 'Line chart random' order: 20>

	| outputElement chartElement chart dataBlock labelsBlock repeatBlock animationBlock |

	"Clear content"
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: (chartElement := CpHtmlElement newWithTag: #canvas).

	dataBlock := [
		| count data |
		count := 5 atRandom + 5.
		data := Array new: count.
		1 to: count do: [ :index | data at: index put: 50 atRandom ].
		data
	].
	labelsBlock := [ :size |
		#('January' 'February' 'March' 'April' 'May' 'June' 'July' 'August' 'September' 'October' 'November' 'December') first: size ].
 
	chart := CjsChart on: chartElement config: {
		#type -> #line.
		#data -> {
			#datasets -> {
				{
					#label -> 'Line chart'.
					#backgroundColor -> 'rgb(255, 99, 132)'.
					#borderColor -> 'rgb(255, 99, 132)'.
					#data -> { }
				} asDictionary
			}.
			#labels -> { }
		} asDictionary.
		#options -> {
			#responsive -> true
		} asDictionary
	} asDictionary.

	animationBlock := [
		"Check whether the chart is still visible (still attached to the output area)"
		chartElement parent ifNotNil: [

			| data |

			data := dataBlock value.
			chart updateData: { data } labels: (labelsBlock value: data size).

			"Repeat the operation"
			repeatBlock value ]
	].

	repeatBlock := [
		(CpTransition onBlock: animationBlock)
			duration: 0 ;	"Execute once"
			startDelayedBy: 2000 ].

	"Start repetition"
	self showProgressBar: 2000.
	repeatBlock value
]

{ #category : #examples }
CpChartJSExamplesWebClientBehavior >> exampleMultiRandom [

	<example: 'Multi chart random' order: 0>

	| outputElement chartElement chart dataBlock labelsBlock repeatBlock animationBlock |

	"Clear content"
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: ((CpHtmlElement newWithTag: #div)
		addClass: #buttons ;
		appendChild: ((CpHtmlElement newWithTag: #button) textContent: 'Line' ; when: CpPrimaryClickEvent do: [ chart ifNotNil: [ chart type: #line ] ] for: self ; yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #button) textContent: 'Bar' ; when: CpPrimaryClickEvent do: [ chart ifNotNil: [ chart type: #bar ] ] for: self ; yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #button) textContent: 'Pie' ; when: CpPrimaryClickEvent do: [ chart ifNotNil: [ chart type: #pie ] ] for: self ; yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #button) textContent: 'Doughnut' ; when: CpPrimaryClickEvent do: [ chart ifNotNil: [ chart type: #doughnut ] ] for: self ; yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #button) textContent: 'Polar area' ; when: CpPrimaryClickEvent do: [ chart ifNotNil: [ chart type: #polarArea ] ] for: self ; yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #button) textContent: 'Radar' ; when: CpPrimaryClickEvent do: [ chart ifNotNil: [ chart type: #radar ] ] for: self ; yourself) ;
		yourself).

	outputElement appendChild: (chartElement := CpHtmlElement newWithTag: #canvas).

	outputElement appendChild: ('Switching between types (using the buttons at the top of the page) might leave some traces of other charts. The rings of the polar area and the radar for example remain visible in other charts once shown (in ChartJS v3.9.1)' inHtmlTag: #p).

	dataBlock := [
		| count data |
		count := 9 atRandom + 3.	"Max 12 datapoints, because we use months as labels in our examples"
		data := Array new: count.
		1 to: count do: [ :index | data at: index put: 50 atRandom ].
		data
	].
	labelsBlock := [ :size |
		#('January' 'February' 'March' 'April' 'May' 'June' 'July' 'August' 'September' 'October' 'November' 'December') first: size ].
 
	chart := CjsChart on: chartElement config: {
		#type -> #doughnut.
		#data -> {
			#datasets -> {
				{
					#label -> 'Chart'.
					#backgroundColor -> { '#8dd3c7' . '#ffffb3' . '#bebada' . '#fb8072' . '#80b1d3' . '#fdb462' . '#b3de69' . '#fccde5' . '#d9d9d9' . '#bc80bd' . '#ccebc5' . '#ffed6f' }.
					#data -> { }
				} asDictionary
			}.
			#labels -> { }
		} asDictionary.
		#options -> {
			#responsive -> true
		} asDictionary
	} asDictionary.

	animationBlock := [
		"Check whether the chart is still visible (still attached to the output area)"
		chartElement parent ifNotNil: [

			| data |

			data := dataBlock value.
			chart updateData: { data } labels: (labelsBlock value: data size).

			"Repeat the operation"
			repeatBlock value ]
	].

	repeatBlock := [
		(CpTransition onBlock: animationBlock)
			duration: 0 ;	"Execute once"
			startDelayedBy: 2000 ].

	"Start repetition"
	self showProgressBar: 2000.
	repeatBlock value
]

{ #category : #examples }
CpChartJSExamplesWebClientBehavior >> exampleStackedBarChartRandom [

	<example: 'Bar chart stacked random' order: 40>

	| outputElement chartElement chart dataBlock labelsBlock repeatBlock animationBlock |

	"Clear content"
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: (chartElement := CpHtmlElement newWithTag: #canvas).

	dataBlock := [ :size |
		| data |
		data := Array new: size.
		1 to: size do: [ :index | data at: index put: 50 atRandom - 25 ].
		data
	].
	labelsBlock := [ :size |
		#('January' 'February' 'March' 'April' 'May' 'June' 'July' 'August' 'September' 'October' 'November' 'December') first: size ].
 
	chart := CjsChart on: chartElement config: {
		#type -> #bar.
		#data -> {
			#labels -> { }.
			#datasets -> {
				{
					#label -> 'Dataset 1'.
					#backgroundColor -> '#f28e2c'.
					#data -> { }
				} asDictionary.
				{
					#label -> 'Dataset 2'.
					#backgroundColor -> '#4e79a7'.
					#data -> { }
				} asDictionary.
				{
					#label -> 'Dataset 3'.
					#backgroundColor -> '#59a14f'.
					#data -> { }
				} asDictionary
			}
		} asDictionary.
		#options -> {
			#responsive -> true.
			#scales -> {
				#x -> { #stacked -> true } asDictionary.
				#y -> { #stacked -> true } asDictionary.
			} asDictionary
		} asDictionary
	} asDictionary.

	animationBlock := [
		"Check whether the chart is still visible (still attached to the output area)"
		chartElement parent ifNotNil: [

			| data count |
			count := 5 atRandom + 5.

			"Create 3 datasets"
			data := {
				dataBlock value: count.
				dataBlock value: count.
				dataBlock value: count
			}.
			chart updateData: data labels: (labelsBlock value: count).

			"Repeat the operation"
			repeatBlock value ]
	].

	repeatBlock := [
		(CpTransition onBlock: animationBlock)
			duration: 0 ;	"Execute once"
			startDelayedBy: 2000 ].

	"Start repetition"
	self showProgressBar: 2000.
	repeatBlock value
]

{ #category : #initialization }
CpChartJSExamplesWebClientBehavior >> initialize [

	super initialize.

	self showIndex
]

{ #category : #accessing }
CpChartJSExamplesWebClientBehavior >> outputElement [

	^ CpHtmlElement documentBody firstDescendantMatching: '#output'
]

{ #category : #progress }
CpChartJSExamplesWebClientBehavior >> removeProgressBar [

	(self outputElement firstDescendantMatching: #progress)
		ifNotNil: [ :progressBar | progressBar destroy ]
]

{ #category : #examples }
CpChartJSExamplesWebClientBehavior >> showIndex [

	"Beware: this method is NOT to be taken as exemplar for creating a UI.
	This class is just a collection of examples of UI possibilities."

	| body list items |

	CpHtmlElement documentAddStyle:'
		html {
			height: 100%;
		}
		body {
			width: 100%;
			height: 100%;
			padding: 0;
			margin: 0;
			overflow: hidden;
		}
		h1 {
			margin-left: 1em;
		}
		#screen {
			width: 100%;
			height: calc(100% - 6em);
		}
		#menu {
			display: inline-block;
			width: 20em;
			height: 100%;
			border-right: 1px solid #999;
		}
		#menu ul {
			list-style: none;
		}
		#menu li { 
			cursor: pointer;
			margin-bottom: .6em;
		}
		#result {
			position: absolute;
			display: inline-block;
			width: calc(100% - 24em);
			height: calc(100% - 10em);
			padding: 2em;
		}
		#output {
			position: relative;
			width: 100%;
			height: 100%;
			overflow: hidden;
		}
		#output canvas {
			max-width: 40em;
			max-height: 45em;
		}
		#output progress {
			position: absolute;
			left: 12em;
			top: 12em;
			width: 300px;
			height: 8px;
		}
		#output p {
			margin-top: 2em;
		}
		div.separator {
			height: 1em;
		}
		button {
			display: inline-block;
			height: 32px;
			padding: 8px;
			border: 0;
			border-radius: 0;
			box-shadow: none;
			font-size: 14px;
			margin-right: 1px;
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
		}
		button:hover {
			background-color: rgba(0, 0, 255, .1);
			cursor: pointer;
		}
		.buttons > button:first-child {
			border-top-left-radius: 4px;
			border-bottom-left-radius: 4px;
		}
		.buttons > button:last-child {
			border-top-right-radius: 4px;
			border-bottom-right-radius: 4px;
		}
	'.
	body := CpHtmlElement documentBody.
	body markupContent: '<h1>ChartJS Examples</h1>
		<div id="screen">
			<div id="menu"><ul id="list"></ul></div><div id="result"><div id="output"></div></div>
		</div>
	'.

	list := body firstDescendantMatching: '#list'.

	"Collect items from example methods"

	items := 	OrderedCollection new.
	(self class selectors select: [ :each | each beginsWith: #example ]) do: [ :selector |
		(self class >> selector) properties ifNotNil: [ :properties |
			(properties at: #example:order:) ifNotNil: [ :pragma |
				items add: selector -> pragma arguments ] ] ].

	"Sort items (a and b are associations where the value contains the pragma arguments #title and #order)"
	items sort: [ :a :b |
		"Either the order of a is lower than order of b"
		(a value second < b value second) or: [
			"or the have the same order and a comes before b alphabetically" 
			(a value second = b value second) and: [ a value first < b value first ] ] ].

	"Render items onto DOM"
	items do: [ :item |
		| example |

		example := (CpHtmlElement newWithTag: #button)
			textContent: item value first ;		"ie title"
			yourself.

		list appendChild: ((CpHtmlElement newWithTag: #li)
			appendChild: example ;
			yourself).

		"Register interest in events on the list item"
		example when: CpPrimaryClickEvent send: item key to: self ]
]

{ #category : #progress }
CpChartJSExamplesWebClientBehavior >> showProgressBar: aDuration [

	| progressBar |

	self outputElement appendChild: (progressBar := CpHtmlElement newWithTag: #progress).

	"Start animation to fill progress ring"
	(CpTransition onBlock: [ :p | progressBar attributeAt: #value put: p printString ; textContent: (p * 100) floor printString, '%' ])
		duration: aDuration ;
		when: CpTransitionEnded send: #removeProgressBar to: self ;
		start
]
