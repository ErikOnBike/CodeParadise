Class {
	#name : 'CpFomanticExamplesClientBehavior',
	#superclass : 'CpWebClientBehavior',
	#category : 'CodeParadise-WebApplication-Fomantic-Examples',
	#package : 'CodeParadise-WebApplication-Fomantic',
	#tag : 'Examples'
}

{ #category : 'examples' }
CpFomanticExamplesClientBehavior >> exampleButton [

	<example: 'Button' order: 100>

	| outputElement loadTargetButton loadButton loadingButton |

	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: ((CpHtmlElement newWithTag: #span)
		textContent: 'Buttons have enabled state ' ;
		yourself).
	outputElement appendChild: (FuiButton newLabeled: 'Enabled').

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: ' ' ; yourself).

	outputElement appendChild: ((FuiButton newLabeled: 'Disabled')
		disable ;
		yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #div) addClass: #separator ; yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: 'Buttons have loading state ' ; yourself).
	loadTargetButton := outputElement appendChild: ((FuiButton newLabeled: 'Loaded')
		beLoading ;
		yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: ' ' ; yourself).

	loadButton := outputElement appendChild: (FuiButton newLabeled: 'Make loaded').
	loadButton when: CpPrimaryClickEvent do: [
		loadTargetButton beLoaded.
		loadButton disable.
		loadingButton enable ].

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: ' ' ; yourself).

	loadingButton := outputElement appendChild: ((FuiButton newLabeled: 'Make loading')
		disable ;
		yourself).
	loadingButton when: CpPrimaryClickEvent do: [
		loadTargetButton beLoading.
		loadButton enable.
		loadingButton disable ].

	outputElement appendChild: ((CpHtmlElement newWithTag: #div) addClass: #separator ; yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: 'Buttons have colors ' ; yourself).
	FuiButton allColors do: [ :each |
		outputElement appendChild: ((FuiButton newLabeled: each)
			beColor: each ;
			yourself) ]
]

{ #category : 'examples' }
CpFomanticExamplesClientBehavior >> exampleCheckbox [

	<example: 'Checkbox' order: 100>

	| outputElement checkbox |

	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement
		appendChild: ('Checkboxes can have 4 types: checkbox, slider, toggle, radio' inHtmlTag: #p) ;
		appendChild: ('' inHtmlTag: #p) ;
		appendChild: ('Chechbox (default):' inHtmlTag: #p) ;	
		appendChild: (checkbox := FuiCheckbox newNamed: #myCheck andLabeled: 'My checkbox').

	outputElement
		appendChild: ('' inHtmlTag: #p) ;
		appendChild: ((FuiButton newLabeled: 'Be toggle')
			when: CpPrimaryClickEvent do: [ :event | checkbox beToggle ] ;
			yourself) ;
		appendChild: ((FuiButton newLabeled: 'Be slider')
			when: CpPrimaryClickEvent do: [ :event | checkbox beSlider ] ;
			yourself) ;
		appendChild: ((FuiButton newLabeled: 'Be checkbox')
			when: CpPrimaryClickEvent do: [ :event | checkbox beRegular ] ;
			yourself).

	outputElement
		appendChild: ('' inHtmlTag: #p) ;
		appendChild: ('Slider (readonly and disabled):' inHtmlTag: #p) ;
		appendChild: ((FuiCheckbox newNamed: #myOtherCheck andLabeled: 'My slider')
			beSlider ;
			beReadOnly ;
			disable ;
			yourself).

	outputElement
		appendChild: ('' inHtmlTag: #p) ;
		appendChild: ('Toggle:' inHtmlTag: #p) ;
		appendChild: ((FuiCheckbox newNamed: #myThirdCheck andLabeled: 'My toggle')
			beToggle ;
			yourself).

	outputElement
		appendChild: ('' inHtmlTag: #p) ;
		appendChild: ('Radio:' inHtmlTag: #p) ;
		appendChild: ((FuiCheckbox newNamed: #someCheck andLabeled: 'Apples')
			beRadio ;
			disable ;
			enable ;
			yourself).
	outputElement
		appendChild: ('' inHtmlTag: #p) ;
		appendChild: ((FuiCheckbox newNamed: #someCheck andLabeled: 'Pears')
			beRadio ;
			yourself).
	outputElement
		appendChild: ('' inHtmlTag: #p) ;
		appendChild: ((FuiCheckbox newNamed: #someCheck andLabeled: 'Bananas')
			beRadio ;
			yourself).

]

{ #category : 'examples' }
CpFomanticExamplesClientBehavior >> exampleHeader [

	<example: 'Header' order: 500>

	| outputElement |

	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: (FuiHeader newLabeled: 'Header').
	
	outputElement appendChild: ((FuiHeader newLabeled: 'Disabled Header')
		disable;
		yourself).

	outputElement appendChild: ((FuiHeader newLabeled: 'Huge Header')
		beSizeHuge;
		yourself).

	outputElement appendChild: ((FuiHeader newLabeled: 'Large Header')
		beSizeLarge;
		yourself).

	outputElement appendChild: ((FuiHeader newLabeled: 'Medium Header')
		beSizeMedium;
		yourself).

	outputElement appendChild: ((FuiHeader newLabeled: 'Small Header')
		beSizeSmall;
		yourself).

	outputElement appendChild: ((FuiHeader newLabeled: 'Tiny Header')
		beSizeTiny;
		yourself)
]

{ #category : 'examples' }
CpFomanticExamplesClientBehavior >> exampleInput [

	<example: 'Input' order: 200>

	| outputElement |

	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement
		appendChild: ('Basic input' inHtmlTag: #p) ;
		appendChild: (FuiInput newNamed: #myText).

	outputElement
		appendChild: ('Input with left icon' inHtmlTag: #p) ;
		appendChild: ((FuiInput newNamed: #leftIconedText)
			leftIcon: #heart ;
			yourself).

	outputElement
		appendChild: ('Input with right icon' inHtmlTag: #p) ;
		appendChild: ((FuiInput newNamed: #rightIconedText)
			rightIcon: #search ;
			yourself).

	outputElement
		appendChild: ('Input with left and right icon (only right will remain)' inHtmlTag: #p) ;
		appendChild: ((FuiInput newNamed: #leftAndRightIconedText)
			leftIcon: #'angle left' ;
			rightIcon: #'angle right' ;
			yourself).

	outputElement
		appendChild: ('Input with right and left icon (only left will remain)' inHtmlTag: #p) ;
		appendChild: ((FuiInput newNamed: #rightAndLeftIconedText)
			rightIcon: #'arrow right' ;
			leftIcon: #'arrow left' ;
			yourself).

	outputElement
		appendChild: ('Input is loading' inHtmlTag: #p) ;
		appendChild: ((FuiInput newNamed: #loading)
			leftIcon: #heart ;
			beLoading ;
			yourself).

	outputElement
		appendChild: ('Textarea input' inHtmlTag: #p) ;
		appendChild: (FuiInput newTextareaNamed: #bigText).

]

{ #category : 'examples' }
CpFomanticExamplesClientBehavior >> exampleMenu [

	<example: 'Menu' order: 300>

	| outputElement |

	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement
		appendChild: (FuiMenu new
			appendChild: (('First' inHtmlTag: #a) addClass: #item ; addClass: #active ; yourself) ;
			appendChild: (('Second' inHtmlTag: #a) addClass: #item ; yourself) ;
			appendChild: (('Third' inHtmlTag: #a) addClass: #item ; yourself) ;
			yourself).

	outputElement
		appendChild: (FuiMenu new
			beDivided: 3 ;
			appendChild: (('First' inHtmlTag: #a) addClass: #item ; addClass: #active ; yourself) ;
			appendChild: (('Second' inHtmlTag: #a) addClass: #item ; yourself) ;
			appendChild: (('Third' inHtmlTag: #a) addClass: #item ; yourself) ;
			yourself).

	outputElement
		appendChild: (FuiMenu new
			beText ;
			appendChild: (('First' inHtmlTag: #a) addClass: #item ; addClass: #active ; yourself) ;
			appendChild: (('Second' inHtmlTag: #a) addClass: #item ; yourself) ;
			appendChild: (('Third' inHtmlTag: #a) addClass: #item ; yourself) ;
			yourself).

	outputElement
		appendChild: (FuiMenu new
			bePointing ;
			appendChild: (('First' inHtmlTag: #a) addClass: #item ; addClass: #active ; yourself) ;
			appendChild: (('Second' inHtmlTag: #a) addClass: #item ; yourself) ;
			appendChild: (('Third' inHtmlTag: #a) addClass: #item ; yourself) ;
			yourself).

	outputElement
		appendChild: (FuiMenu new
			beTabular ;
			appendChild: (('First' inHtmlTag: #a) addClass: #item ; addClass: #active ; yourself) ;
			appendChild: (('Second' inHtmlTag: #a) addClass: #item ; yourself) ;
			appendChild: (('Third' inHtmlTag: #a) addClass: #item ; yourself) ;
			yourself).

	outputElement
		appendChild: (FuiMenu new
			beVertical ;
			appendChild: (('First' inHtmlTag: #a) addClass: #item ; addClass: #active ; yourself) ;
			appendChild: (('Second' inHtmlTag: #a) addClass: #item ; yourself) ;
			appendChild: (('Third' inHtmlTag: #a) addClass: #item ; yourself) ;
			yourself).

	outputElement
		appendChild: (FuiMenu new
			beVertical ; beSecondary ; bePointing ;
			appendChild: (('First' inHtmlTag: #a) addClass: #item ; addClass: #active ; yourself) ;
			appendChild: (('Second' inHtmlTag: #a) addClass: #item ; yourself) ;
			appendChild: (('Third' inHtmlTag: #a) addClass: #item ; yourself) ;
			yourself).

]

{ #category : 'examples' }
CpFomanticExamplesClientBehavior >> examplePopup [

	<example: 'Popup' order: 400>

	| outputElement activator |

	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement 
		appendChild: (activator := FuiButton newLabeled: 'Open me!').

	outputElement
		appendChild: ((FuiPopup new 
			activateOnElement: activator withOptions: { 
				#inline -> true.
				#hoverable -> true.
				#position -> 'bottom right'.
				#delay -> { #show -> 300. #hide -> 600 } asDictionary.
			 } asDictionary) 
			appendChild: (FuiMenu new 
				beSecondary ;
				beVertical ;
				appendChild: (('First' inHtmlTag: #a) addClass: #item ; yourself) ;
				appendChild: (('Second' inHtmlTag: #a) addClass: #item ; yourself) ;
				appendChild: (('Third' inHtmlTag: #a) addClass: #item ; yourself) ;
				yourself) ;
			yourself).

]

{ #category : 'initialization' }
CpFomanticExamplesClientBehavior >> initialize [

	super initialize.

	self showIndex
]

{ #category : 'accessing' }
CpFomanticExamplesClientBehavior >> outputElement [

	^ CpHtmlElement document elementWithId: #output
]

{ #category : 'examples' }
CpFomanticExamplesClientBehavior >> showIndex [

	"Beware: this method is NOT to be taken as exemplar for creating a UI.
	This class is just a collection of examples of UI possibilities."

	| body list items |

	CpHtmlElement documentAddStyle: '
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
		}'.
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
			textContent: item value first ;	"ie title"
			yourself.

		list appendChild: ((CpHtmlElement newWithTag: #li)
			appendChild: example ;
			yourself).

		"Register interest in events on the list item"
		example when: CpPrimaryClickEvent send: item key to: self ]
]
