Class {
	#name : #CpFomanticExamplesClientBehavior,
	#superclass : #CpWebClientBehavior,
	#category : #'CodeParadise-WebApplication-Fomantic-Examples'
}

{ #category : #accessing }
CpFomanticExamplesClientBehavior class >> eventHandlerClass [

	^ FuiEventHandler
]

{ #category : #examples }
CpFomanticExamplesClientBehavior >> exampleButton [

	<example: 'Button' order: 100>

	| outputElement loadTargetButton loadButton loadingButton |

	outputElement := self outputElement.

	outputElement appendChild: ((CpHtmlElement newWithTag: #span)
		textContent: 'Buttons have enabled state ' ;
		yourself).
	outputElement appendChild: (FuiButton new
		textContent: 'Enabled' ;
		yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: ' ' ; yourself).

	outputElement appendChild: (FuiButton new
		textContent: 'Disabled' ;
		disable ;
		yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #div) addClass: #separator ; yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: 'Buttons have loading state ' ; yourself).
	loadTargetButton := outputElement appendChild: (FuiButton new
		textContent: 'Loaded' ;
		beLoading ;
		yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: ' ' ; yourself).

	loadButton := outputElement appendChild: (FuiButton new
		textContent: 'Make loaded' ;
		yourself).
	CpBrowserEventHandler current registerInterestIn: loadButton.
	loadButton when: CpEventAnnouncement do: [
		loadTargetButton beLoaded.
		loadButton disable.
		loadingButton enable ].

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: ' ' ; yourself).

	loadingButton := outputElement appendChild: (FuiButton new
		textContent: 'Make loading' ;
		disable ;
		yourself).
	CpBrowserEventHandler current registerInterestIn: loadingButton.
	loadingButton when: CpEventAnnouncement do: [
		loadTargetButton beLoading.
		loadButton enable.
		loadingButton disable ].

	outputElement appendChild: ((CpHtmlElement newWithTag: #div) addClass: #separator ; yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: 'Buttons have colors ' ; yourself).
	FuiButton allColors do: [ :each |
		outputElement appendChild: (FuiButton new
			textContent: each ;
			beColor: each ;
			yourself) ]
]

{ #category : #examples }
CpFomanticExamplesClientBehavior >> exampleCheckbox [

	<example: 'Checkbox' order: 100>

	| outputElement checkbox checkButton uncheckButton isCheckedButton isCheckedLabel |

	outputElement := self outputElement.

	outputElement appendChild: ((CpHtmlElement newWithTag: #span)
		textContent: 'Checkboxes have enabled state ' ;
		yourself).
	outputElement appendChild: (FuiCheckbox new
		textContent: 'Enabled' ;
		yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: ' ' ; yourself).

	outputElement appendChild: (FuiCheckbox new
		textContent: 'Disabled' ;
		disable ;
		yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #div) addClass: #separator ; yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: 'Checkboxes have checked state ' ; yourself).
	outputElement appendChild: (FuiCheckbox new
		textContent: 'Checked' ;
		check ;
		yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: ' ' ; yourself).

	checkbox := outputElement appendChild: (FuiCheckbox new
		textContent: 'Unchecked' ;
		uncheck ;
		yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: ' ' ; yourself).

	checkButton := outputElement appendChild: (FuiButton new
		textContent: 'Check' ;
		yourself).
	CpBrowserEventHandler current registerInterestIn: checkButton.
	checkButton when: CpEventAnnouncement do: [
		checkbox check.
		checkButton disable.
		uncheckButton enable. ].

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: ' ' ; yourself).

	uncheckButton := outputElement appendChild: (FuiButton new
		textContent: 'Uncheck' ;
		yourself).
	CpBrowserEventHandler current registerInterestIn: uncheckButton.
	uncheckButton when: CpEventAnnouncement do: [
		checkbox uncheck.
		checkButton enable.
		uncheckButton disable ].

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: ' ' ; yourself).

	isCheckedButton := outputElement appendChild: (FuiButton new
		textContent: 'Is checked' ;
		yourself).
	isCheckedLabel := outputElement appendChild: (CpHtmlElement newWithTag: #span).
	CpBrowserEventHandler current registerInterestIn: isCheckedButton.
	isCheckedButton when: CpEventAnnouncement do: [ isCheckedLabel textContent: ' ', checkbox isChecked printString ].
	isCheckedButton announce: CpEventAnnouncement new "trigger first update"
]

{ #category : #events }
CpFomanticExamplesClientBehavior >> handleEvent: anEvent [

	| selector output |

	anEvent class = CpClickEvent
		ifFalse: [ ^ self ].

	"Find example selector"
	selector := anEvent target
		ifNotNil: [ :target | target id ]
		ifNil: [ ^ self ].

	"Wipe out existing output"
	output := self outputElement.
	output ifNil: [ ^ self ].
	output textContent: ''.

	"Create new output by performing selector"
	[ self perform: selector asSymbol ] on: Error do: [ :error | output textContent: 'Error: ', error description ]
]

{ #category : #initialization }
CpFomanticExamplesClientBehavior >> initialize [

	super initialize.

	self showIndex
]

{ #category : #initialization }
CpFomanticExamplesClientBehavior >> loadFomantic [

	"Load Fomantic UI from jsDelivr CDN"

	CpHtmlElement documentHead
		appendChild: ((CpHtmlElement newWithTag: #script)
			attributeAt: #src put: 'https://cdn.jsdelivr.net/npm/jquery@3.3.1/dist/jquery.min.js' ;
			attributeAt: #async put: 'false' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #link)
			attributeAt: #rel put: 'stylesheet' ;
			attributeAt: #type put: 'text/css' ;
			attributeAt: #href put: 'https://cdn.jsdelivr.net/npm/fomantic-ui@2.8.6/dist/semantic.min.css' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #script)
			attributeAt: #src put: 'https://cdn.jsdelivr.net/npm/fomantic-ui@2.8.6/dist/semantic.min.js' ;
			yourself)
]

{ #category : #accessing }
CpFomanticExamplesClientBehavior >> outputElement [

	^ CpHtmlElement documentBody firstDescendantMatching: '#output'
]

{ #category : #examples }
CpFomanticExamplesClientBehavior >> showIndex [

	"Beware: this method is not to be taken as exemplar for creating a UI.
	This class is just a collection of examples of UI possibilities."

	| body list items |

	self loadFomantic.

	CpHtmlElement documentHead appendChild: ((CpHtmlElement newWithTag: #style)
		textContent: '
			#menu {
				display: inline-block;
				width: 20em;
				height: calc(100vh - 6em);
				border-right: 1px solid #999;
			}
			#menu li { 
				cursor: pointer;
				margin-bottom: .6em;
			}
			#result {
				position: absolute;
				display: inline-block;
				width: calc(100% - 24em);
				height: calc(100vh - 10em);
				padding: 2em;
			}
			#output {
				position: relative;
				width: 100%;
				height: 100%;
			}
			div.separator {
				height: 1em;
			}
		' ;
		yourself).
	body := CpHtmlElement documentBody.
	body markupContent: '<h1>Fomantic Examples</h1>
		<div style="width: 100%; margin: 0; padding: 0;">
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
				
		example := FuiButton new
			attributeAt: #id put: item key ;	"ie selector"
			textContent: item value first ;	"ie title"
			yourself.
			
		list appendChild: ((CpHtmlElement newWithTag: #li)
			appendChild: example ;
			yourself).

		"Register interest in events on the list item"
		CpBrowserEventHandler current registerInterestIn: example.
		example when: CpEventAnnouncement do: [ :announcement | self handleEvent: announcement event ] ]
]
