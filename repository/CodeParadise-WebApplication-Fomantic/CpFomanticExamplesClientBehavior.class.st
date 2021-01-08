Class {
	#name : #CpFomanticExamplesClientBehavior,
	#superclass : #CpWebClientBehavior,
	#category : #'CodeParadise-WebApplication-Fomantic-Examples'
}

{ #category : #examples }
CpFomanticExamplesClientBehavior >> exampleButton [

	<example: 'Button' order: 100>

	| outputElement loadTargetButton loadButton loadingButton |

	outputElement := self outputElement.
	outputElement textContent: ''.

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
	loadButton when: CpClickEvent do: [
		loadTargetButton beLoaded.
		loadButton disable.
		loadingButton enable ].

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: ' ' ; yourself).

	loadingButton := outputElement appendChild: (FuiButton new
		textContent: 'Make loading' ;
		disable ;
		yourself).
	loadingButton when: CpClickEvent do: [
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
CpFomanticExamplesClientBehavior >> exampleButton2 [

	<example: 'Button2' order: 100>

	| outputElement loadTargetButton loadButton loadingButton |

	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: ((CpHtmlElement newWithTag: #span)
		textContent: 'Buttons have enabled state ' ;
		yourself).
	outputElement appendChild: (Fui2Button newLabeled: 'Enabled').

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: ' ' ; yourself).

	outputElement appendChild: ((Fui2Button newLabeled: 'Disabled')
		disable ;
		yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #div) addClass: #separator ; yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: 'Buttons have loading state ' ; yourself).
	loadTargetButton := outputElement appendChild: ((Fui2Button newLabeled: 'Loaded')
		beLoading ;
		yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: ' ' ; yourself).

	loadButton := outputElement appendChild: (Fui2Button newLabeled: 'Make loaded').
	loadButton when: CpClickEvent do: [
		loadTargetButton beLoaded.
		loadButton disable.
		loadingButton enable ].

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: ' ' ; yourself).

	loadingButton := outputElement appendChild: ((Fui2Button newLabeled: 'Make loading')
		disable ;
		yourself).
	loadingButton when: CpClickEvent do: [
		loadTargetButton beLoading.
		loadButton enable.
		loadingButton disable ].

	outputElement appendChild: ((CpHtmlElement newWithTag: #div) addClass: #separator ; yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: 'Buttons have colors ' ; yourself).
	Fui2Button allColors do: [ :each |
		outputElement appendChild: ((Fui2Button newLabeled: each)
			beColor: each ;
			yourself) ]
]

{ #category : #examples }
CpFomanticExamplesClientBehavior >> exampleCheckbox [

	<example: 'Checkbox' order: 100>

	| outputElement checkbox checkButton uncheckButton isCheckedButton isCheckedLabel |

	outputElement := self outputElement.
	outputElement textContent: ''.

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
	checkButton when: CpClickEvent do: [
		checkbox check.
		checkButton disable.
		uncheckButton enable. ].

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: ' ' ; yourself).

	uncheckButton := outputElement appendChild: (FuiButton new
		textContent: 'Uncheck' ;
		yourself).
	uncheckButton when: CpClickEvent do: [
		checkbox uncheck.
		checkButton enable.
		uncheckButton disable ].

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: ' ' ; yourself).

	isCheckedButton := outputElement appendChild: (FuiButton new
		textContent: 'Is checked' ;
		yourself).
	isCheckedLabel := outputElement appendChild: (CpHtmlElement newWithTag: #span).
	isCheckedButton when: CpClickEvent do: [ isCheckedLabel textContent: ' ', checkbox isChecked printString ].
	isCheckedButton announce: CpClickEvent new. "trigger first update"

	outputElement appendChild: ((CpHtmlElement newWithTag: #div) addClass: #separator ; yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: 'Checkboxes can be radios, sliders or toggles ' ; yourself).
	outputElement appendChild: (FuiCheckbox new
		textContent: 'Radio' ;
		beRadio ;
		yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: ' ' ; yourself).

	outputElement appendChild: (FuiCheckbox new
		textContent: 'Slider' ;
		beSlider ;
		yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #span) textContent: ' ' ; yourself).

	outputElement appendChild: (FuiCheckbox new
		textContent: 'Toggle' ;
		beToggle ;
		yourself).

]

{ #category : #examples }
CpFomanticExamplesClientBehavior >> exampleCheckbox2 [

	<example: 'Checkbox2' order: 100>

	| outputElement |

	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement
		appendChild: ('Checkboxes can have 4 types: checkbox, slider, toggle, radio' inHtmlTag: #p) ;
		appendChild: ('' inHtmlTag: #p) ;
		appendChild: ('Chechbox (default):' inHtmlTag: #p) ;	
		appendChild: (Fui2Checkbox newNamed: #myCheck withLabel: 'My checkbox').

	outputElement
		appendChild: ('' inHtmlTag: #p) ;
		appendChild: ('Slider (readonly and disabled):' inHtmlTag: #p) ;
		appendChild: ((Fui2Checkbox newNamed: #myOtherCheck withLabel: 'My slider')
			beSlider ;
			beReadOnly ;
			disable ;
			yourself).

	outputElement
		appendChild: ('' inHtmlTag: #p) ;
		appendChild: ('Toggle:' inHtmlTag: #p) ;
		appendChild: ((Fui2Checkbox newNamed: #myThirdCheck withLabel: 'My toggle')
			beToggle ;
			yourself).

	outputElement
		appendChild: ('' inHtmlTag: #p) ;
		appendChild: ('Radio:' inHtmlTag: #p) ;
		appendChild: ((Fui2Checkbox newNamed: #someCheck withLabel: 'Apples')
			beRadio ;
			disable ;
			enable ;
			yourself).
	outputElement
		appendChild: ('' inHtmlTag: #p) ;
		appendChild: ((Fui2Checkbox newNamed: #someCheck withLabel: 'Pears')
			beRadio ;
			yourself).
	outputElement
		appendChild: ('' inHtmlTag: #p) ;
		appendChild: ((Fui2Checkbox newNamed: #someCheck withLabel: 'Bananas')
			beRadio ;
			yourself).

]

{ #category : #examples }
CpFomanticExamplesClientBehavior >> exampleInput [

	<example: 'Input' order: 200>

	| outputElement |

	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement
		appendChild: ('Basic input ' inHtmlTag: #span) ;
		appendChild: FuiInput new.

	outputElement appendChild: ((CpHtmlElement newWithTag: #div) addClass: #separator ; yourself).

	outputElement
		appendChild: ('Input with placeholder' inHtmlTag: #span) ;
		appendChild: (FuiInput new
			placeholder: 'Search...' ;
			yourself).

	outputElement appendChild: ((CpHtmlElement newWithTag: #div) addClass: #separator ; yourself).

	outputElement
		appendChild: ('Input with icon' inHtmlTag: #span) ;
		appendChild: (FuiInput new
			icon: #search ;
			yourself)
]

{ #category : #examples }
CpFomanticExamplesClientBehavior >> exampleInput2 [

	<example: 'Input2' order: 200>

	| outputElement |

	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement
		appendChild: ('Basic input' inHtmlTag: #p) ;
		appendChild: (Fui2Input newNamed: #myText).

	outputElement
		appendChild: ('Input with left icon' inHtmlTag: #p) ;
		appendChild: ((Fui2Input newNamed: #leftIconedText)
			leftIcon: #heart ;
			yourself).

	outputElement
		appendChild: ('Input with right icon' inHtmlTag: #p) ;
		appendChild: ((Fui2Input newNamed: #rightIconedText)
			rightIcon: #search ;
			yourself).

	outputElement
		appendChild: ('Input with left and right icon (only right will remain)' inHtmlTag: #p) ;
		appendChild: ((Fui2Input newNamed: #leftAndRightIconedText)
			leftIcon: #'angle left' ;
			rightIcon: #'angle right' ;
			yourself).

	outputElement
		appendChild: ('Input with right and left icon (only left will remain)' inHtmlTag: #p) ;
		appendChild: ((Fui2Input newNamed: #rightAndLeftIconedText)
			rightIcon: #'arrow right' ;
			leftIcon: #'arrow left' ;
			yourself).

	outputElement
		appendChild: ('Input is loading' inHtmlTag: #p) ;
		appendChild: ((Fui2Input newNamed: #loading)
			leftIcon: #heart ;
			beLoading ;
			yourself).
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

	"Beware: this method is NOT to be taken as exemplar for creating a UI.
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
			textContent: item value first ;	"ie title"
			yourself.
			
		list appendChild: ((CpHtmlElement newWithTag: #li)
			appendChild: example ;
			yourself).

		"Register interest in events on the list item"
		example when: CpClickEvent send: item key to: self ]
]
