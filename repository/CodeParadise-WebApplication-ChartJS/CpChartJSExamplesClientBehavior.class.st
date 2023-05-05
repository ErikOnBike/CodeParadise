Class {
	#name : #CpChartJSExamplesClientBehavior,
	#superclass : #CpWebClientBehavior,
	#category : #'CodeParadise-WebApplication-ChartJS-Examples'
}

{ #category : #examples }
CpChartJSExamplesClientBehavior >> exampleBarChartRandom [

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
	self showProgressRing: 2000.
	repeatBlock value
]

{ #category : #examples }
CpChartJSExamplesClientBehavior >> exampleDoughnutChartRandom [

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
	self showProgressRing: 2000.
	repeatBlock value
]

{ #category : #examples }
CpChartJSExamplesClientBehavior >> exampleLineChart [

	<example: 'Line chart' order: 10>

	| outputElement chartElement chart |

	"Clear content"
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: ('Use the range selector below to set the line tension' inHtmlTag: #p).

	outputElement appendChild: (SlRange new
		styleAt: #width put: '30em' ;
		min: 0 ;
		max: 4 ;
		step: 0.1 ;
		when: SlChangeEvent do: [ :changeEvent |
			chart ifNotNil: [
				chart
					propertyAt: #(data datasets 0 tension) put: (changeEvent target value) ;
					update ] ] ;
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
CpChartJSExamplesClientBehavior >> exampleLineChartRandom [

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
	self showProgressRing: 2000.
	repeatBlock value
]

{ #category : #examples }
CpChartJSExamplesClientBehavior >> exampleMultiRandom [

	<example: 'Multi chart random' order: 0>

	| outputElement chartElement chart dataBlock labelsBlock repeatBlock animationBlock |

	"Clear content"
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: (SlButtonGroup new
		appendChild: ((SlButton label: 'Line') when: CpPrimaryClickEvent do: [ chart ifNotNil: [ chart type: #line ] ] ; yourself) ;
		appendChild: ((SlButton label: 'Bar') when: CpPrimaryClickEvent do: [ chart ifNotNil: [ chart type: #bar ] ] ; yourself) ;
		appendChild: ((SlButton label: 'Pie') when: CpPrimaryClickEvent do: [ chart ifNotNil: [ chart type: #pie ] ] ; yourself) ;
		appendChild: ((SlButton label: 'Doughnut') when: CpPrimaryClickEvent do: [ chart ifNotNil: [ chart type: #doughnut ] ] ; yourself) ;
		appendChild: ((SlButton label: 'Polar area') when: CpPrimaryClickEvent do: [ chart ifNotNil: [ chart type: #polarArea ] ] ; yourself) ;
		appendChild: ((SlButton label: 'Radar') when: CpPrimaryClickEvent do: [ chart ifNotNil: [ chart type: #radar ] ] ; yourself) ;
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
	self showProgressRing: 2000.
	repeatBlock value
]

{ #category : #examples }
CpChartJSExamplesClientBehavior >> exampleStackedBarChartRandom [

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
	self showProgressRing: 2000.
	repeatBlock value
]

{ #category : #initialization }
CpChartJSExamplesClientBehavior >> initialize [

	super initialize.

	SlButton beLoaded.
	SlIcon beLoaded.
	CpTransition beLoaded.

	self showIndex
]

{ #category : #accessing }
CpChartJSExamplesClientBehavior >> outputElement [

	^ CpHtmlElement documentBody firstDescendantMatching: '#output'
]

{ #category : #progress }
CpChartJSExamplesClientBehavior >> removeProgressRing [

	(self outputElement firstDescendantMatching: SlProgressRing asCssSelector)
		ifNotNil: [ :progressRing | progressRing destroy ]
]

{ #category : #examples }
CpChartJSExamplesClientBehavior >> showIndex [

	"Beware: this method is NOT to be taken as exemplar for creating a UI.
	This class is just a collection of examples of UI possibilities."

	| body list items |

	CpHtmlElement documentHead appendChild: ((CpHtmlElement newWithTag: #style)
		textContent: '
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
			#output sl-progress-ring {
				position: absolute;
				left: 12em;
				top: 12em;
				width: 24em;
				height: 24em;
				--size: 24em;
				--indicator-transition-duration: 0s;
			}
			#output p {
				margin-top: 2em;
			}
			div.separator {
				height: 1em;
			}
		' ;
		yourself).
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

		example := SlButton
			label: item value first		"ie title"
			suffix: 'arrow-right' asShoelaceIcon.

		list appendChild: ((CpHtmlElement newWithTag: #li)
			appendChild: example ;
			yourself).

		"Register interest in events on the list item"
		example when: CpPrimaryClickEvent send: item key to: self ]
]

{ #category : #progress }
CpChartJSExamplesClientBehavior >> showProgressRing: aDuration [

	| progressRing |

	self outputElement appendChild: (progressRing := SlProgressRing new).

	"Start animation to fill progress ring"
	(CpTransition onBlock: [ :p | progressRing value: (p * 100) floor ; labelText: (p * 100) floor printString, '%' ])
		duration: aDuration ;
		when: CpTransitionEnded send: #removeProgressRing to: self ;
		start
]
