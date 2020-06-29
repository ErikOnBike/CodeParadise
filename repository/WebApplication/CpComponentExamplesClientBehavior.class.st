Class {
	#name : #CpComponentExamplesClientBehavior,
	#superclass : #CpWebClientBehavior,
	#category : #'WebApplication-Examples'
}

{ #category : #accessing }
CpComponentExamplesClientBehavior class >> cpRequiredClasses [

	^ super cpRequiredClasses, {
		CpButton .
		CpLink .
		CpViewEventHandler }
]

{ #category : #examples }
CpComponentExamplesClientBehavior >> exampleButtons [

	<example: 'Buttons' order: 200>

	| outputElement |
	
	outputElement := self outputElement.

	outputElement appendChild: (CpButton label: 'My label').

	"Add separator"
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (CpButton label: #heart asRegularFontAwesomeIcon).

	"Add separator"
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (CpButton label: 'Suffixed' suffix: #star asSolidFontAwesomeIcon).

	"Add separator"
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (CpButton prefix: #backward asSolidFontAwesomeIcon label: 'Prefixed' ).

	"Add separator"
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (CpButton prefix: #'chevron-left' asSolidFontAwesomeIcon label: 'both' suffix: #'chevron-right' asSolidFontAwesomeIcon).
]

{ #category : #examples }
CpComponentExamplesClientBehavior >> exampleLinks [

	<example: 'Links' order: 100>

	| outputElement |
	
	outputElement := self outputElement.

	outputElement appendChild: (CpLink label: 'My link')
]

{ #category : #events }
CpComponentExamplesClientBehavior >> handleEvent: anEvent [

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
CpComponentExamplesClientBehavior >> initialize [

	super initialize.

	self showIndex
]

{ #category : #accessing }
CpComponentExamplesClientBehavior >> outputElement [

	^ CpHtmlElement documentBody firstDescendantMatching: '#output'
]

{ #category : #examples }
CpComponentExamplesClientBehavior >> showIndex [

	| body list items |

	CpHtmlElement documentHead appendChild: ((CpHtmlElement newWithTag: #style)
		textContent: '
			html { 
				--control-text-color: #333;
				--control-background-color: #ccd;
				--control-hover-text-color: var(--control-text-color);
				--control-hover-background-color: #ccf;
				--control-activated-text-color: #111;
				--control-activated-background-color: #99f;
				--link-text-color: #99f;
				--link-background-color: inherit;
				--link-hovered-text-color: #66f;
				--link-hovered-background-color: inherit;
				--link-activated-text-color: #33f;
				--link-activated-background-color: inherit;
			}
			*, *:before, *:after {
				-moz-box-sizing: border-box;
				-webkit-box-sizing: border-box;
				box-sizing: border-box;
			}
			html {
				font-size: 100%;
				-webkit-text-size-adjust: 100%;
				font-family: "SF Pro Text", "Helvetica Neue", Helvetica, Arial, sans-serif;
			}
			#menu {
				display: inline-block;
				width: 15em;
				height: calc(100vh - 6em);
				border-right: 1px solid #999;
			}
			#menu li { 
				cursor: pointer;
			}
			#result {
				position: absolute;
				display: inline-block;
				width: calc(100% - 19em);
				height: calc(100vh - 10em);
				padding: 2em;
			}
			#output {
				position: relative;
				width: 100%;
				height: 100%;
			}
		' ;
		yourself).
	CpHtmlElement documentHead appendChild: ((CpHtmlElement newWithTag: #link)
		attributeAt: #rel put: 'stylesheet' ;
		attributeAt: #href put: 'https://use.fontawesome.com/releases/v5.0.7/css/all.css' ;
		yourself).
	body := CpHtmlElement documentBody.
	body markupContent: '<h1>Component Examples</h1>
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
				
		example := (list appendChild: (CpHtmlElement newWithTag: 'li'))
			appendChild: ((CpLink label: item value first)	"ie titel"
				attributeAt: #id put: item key ;	"ie selector"
				yourself).

		"Register interest in events on the list item"
		CpBrowserEventHandler current registerInterestIn: example.
		example when: CpEventAnnouncement do: [ :announcement | self handleEvent: announcement event ] ]
]
