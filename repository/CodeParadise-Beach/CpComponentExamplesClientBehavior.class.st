Class {
	#name : #CpComponentExamplesClientBehavior,
	#superclass : #CpMvpWebClientBehavior,
	#category : #'CodeParadise-Beach-Examples'
}

{ #category : #examples }
CpComponentExamplesClientBehavior >> exampleButtons [

	<example: 'Buttons' order: 200>

	| outputElement |
	
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: (CpButton label: 'My label').

	"Add separator"
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (CpButton label: #heart asRegularFontAwesomeIcon).

	"Add separator"
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement
		appendChild: (CpButton label: 'Suffixed' suffix: #face asMaterialIcon) ;
		appendChild: (' this is a Material (Design) Icon' inHtmlTag: #span).

	"Add separator"
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement
		appendChild: (CpButton prefix: #backward asSolidFontAwesomeIcon label: 'Prefixed') ;
		appendChild: (' this is a FontAwesome Icon' inHtmlTag: #span).

	"Add separator"
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (CpButton prefix: #'chevron-left' asSolidFontAwesomeIcon label: 'Both' suffix: #'chevron-right' asSolidFontAwesomeIcon).
]

{ #category : #examples }
CpComponentExamplesClientBehavior >> exampleCheckboxes [

	<example: 'Checkboxes' order: 300>

	| outputElement checkbox |
	
	outputElement := self outputElement.
	outputElement textContent: ''.

	checkbox := outputElement appendChild: (CpCheckbox label: 'First selection').

	"Add horizontal separator"
	outputElement appendChild: (' ' inHtmlTag: #span).

	outputElement appendChild: ((CpButton label: 'Make mixed')
			when: CpClickEvent do: [ checkbox makeMixed ] ;
			yourself).

]

{ #category : #examples }
CpComponentExamplesClientBehavior >> exampleDraggableWindows [

	<example: 'Draggable windows' order: 500>

	| outputElement window |
	
	outputElement := self outputElement.
	outputElement textContent: ''.

	window := CpWindow new
		replaceChild: 'Hello World' asElement atSlotNamed: #title ;
		replaceChild: 'Drag me!' asElement atSlotNamed: #content ;
		yourself.

	(window childAtSlotNamed: #controls) remove.

	CpHtmlElement documentBody appendChild: window
]

{ #category : #examples }
CpComponentExamplesClientBehavior >> exampleLinks [

	<example: 'Links' order: 100>

	| outputElement |
	
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: (CpLink label: 'My link')
]

{ #category : #examples }
CpComponentExamplesClientBehavior >> exampleTextField [

	<example: 'Text fields' order: 400>

	| outputElement |
	
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: (self textFieldExplanation inHtmlTag: #p).

	outputElement appendChild: ((CpRichTextField new)
		styleAt: #width put: '20em' ;
		text: 'Hello world' ;
		yourself).

	"Separator"
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: ((CpRichTextField new)
		styleAt: #width put: '20em' ;
		text: '' ;
		yourself)
]

{ #category : #events }
CpComponentExamplesClientBehavior >> handleFocusEvent: aFocusEvent [

	self crTrace: aFocusEvent printString
]

{ #category : #accessing }
CpComponentExamplesClientBehavior >> outputElement [

	^ CpHtmlElement documentBody firstDescendantMatching: '#output'
]

{ #category : #examples }
CpComponentExamplesClientBehavior >> showIndex [

	"Beware: this method is not to be taken as exemplar for creating a UI.
	This class is just a collection of examples of UI possibilities."

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
	CpHtmlElement documentHead appendChild: ((CpHtmlElement newWithTag: #link)
		attributeAt: #rel put: 'stylesheet' ;
		attributeAt: #href put: 'https://fonts.googleapis.com/icon?family=Material+Icons' ;
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
	Pragma withPragmasIn: self class do: [ :pragma |
		pragma key = #example:order:
			ifTrue: [ items add: pragma methodSelector -> pragma arguments ] ].

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
		example when: CpClickEvent send: item key to: self ]
]

{ #category : #explanation }
CpComponentExamplesClientBehavior >> textFieldExplanation [

	^ 'This is a very early first beta trial prototype experiment thing
	(hoping this makes it clear you can''t claim anything based on the result ;-).
	The textfield below, might look (sort of) normal, but in fact is almost
	fully rendered and handled by Smalltalk code. There is a hidden HTML input tag
	on the location where the cursor is, but that is for future use when copy
	and paste are going to be implemented. (Don''t believe me? Just open up your
	browser console and check the DOM!) All keyboard events are caught and
	handled by Smalltalk code. All updating of the visible text field is done
	by Smalltalk code. The blinking cursor is just a little bar with CSS styling
	making it look like a blinking cursor. Only a few keystrokes are handled
	at the moment: single characters, left and right arrow, delete and backspace.
	You can only set the cursor and not remove it (visually) yet. Although only
	one text field will have actual focus for input.
	Still hope you have as much fun with it as I have :-)'
]
