Class {
	#name : 'CpComponentExamplesClientBehavior',
	#superclass : 'CpMvpWebClientBehavior',
	#category : 'CodeParadise-Beach-Examples',
	#package : 'CodeParadise-Beach',
	#tag : 'Examples'
}

{ #category : 'examples' }
CpComponentExamplesClientBehavior >> exampleButtons [

	<example: 'Buttons' order: 200>

	| outputElement group1 group2 group3 button1a button1b button2a button2b button3a button3b |
	
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: (CpButton label: 'My label').

	"Add separator"
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement
		appendChild: (CpButton icon: #heart asRegularFontAwesomeIcon) ;
		appendChild: ' icon button' asHtmlElement.

	"Add separator"
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement
		appendChild: (CpButton label: 'Suffixed' suffix: #forward asSolidFontAwesomeIcon) ;
		appendChild: ' this is a FontAwesome Icon' asHtmlElement.

	"Add separator"
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement
		appendChild: (CpButton prefix: #backward asSolidFontAwesomeIcon label: 'Prefixed') ;
		appendChild: ' this is a FontAwesome Icon' asHtmlElement.

	"Add separator"
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (CpButton prefix: #'chevron-left' asSolidFontAwesomeIcon label: 'Both' suffix: #'chevron-right' asSolidFontAwesomeIcon).

	"Add separator"
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	(outputElement appendChild: CpButtonGroup new)
		appendChild: (CpButton label: 'One') ;
		appendChild: (CpButton label: 'Two') ;
		appendChild: (CpButton label: 'Three').
	outputElement appendChild: ' in a button group' asHtmlElement.

	"Add separator"
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	(outputElement appendChild: CpButtonGroup new)
		attributeAdd: #vertical ;
		appendChild: (CpButton label: 'One') ;
		appendChild: (CpButton label: 'Two') ;
		appendChild: (CpButton label: 'Three').
	outputElement appendChild: ' in a vertical button group' asHtmlElement.

	"Add separator"
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	group1 := outputElement appendChild: CpButtonGroup new.
	button1a := group1 appendChild: ((CpButton label: 'Button1a')
		when: CpPrimaryClickEvent do: [ self traceCr: 'Button1a clicked' ] ;
		yourself).
	button1b := group1 appendChild: ((CpButton label: 'Button1b')
		when: CpPrimaryClickEvent do: [ self traceCr: 'Button1b clicked' ] ;
		yourself).
	group2 := group1 appendChild: CpButtonGroup new.
	group2
		styleAt: #display put: #block ;
		styleAt: #'margin-left' put: '3em'.
	button2a := group2 appendChild: ((CpButton label: 'Button2a')
		when: CpPrimaryClickEvent do: [ self traceCr: 'Button2a clicked' ] ;
		yourself).
	button2b := group2 appendChild: ((CpButton label: 'Button2b')
		when: CpPrimaryClickEvent do: [ self traceCr: 'Button2b clicked' ] ;
		yourself).
	group3 := group2 appendChild: CpButtonGroup new.
	group3
		styleAt: #display put: #block ;
		styleAt: #'margin-left' put: '6em'.
	button3a := group3 appendChild: ((CpButton label: 'Button3a')
		when: CpPrimaryClickEvent do: [ self traceCr: 'Button3a clicked' ] ;
		yourself).
	button3b := group3 appendChild: ((CpButton label: 'Button3b')
		when: CpPrimaryClickEvent do: [ self traceCr: 'Button3b clicked' ] ;
		yourself).

	"Add separator"
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	(outputElement appendChild: (CpButton label: 'Disable group1'))
		when: CpPrimaryClickEvent do: [ group1 disable ].
	(outputElement appendChild: (CpButton label: 'Enable group1'))
		when: CpPrimaryClickEvent do: [ group1 enable ].
	(outputElement appendChild: (CpButton label: 'Disable group2'))
		when: CpPrimaryClickEvent do: [ group2 disable ].
	(outputElement appendChild: (CpButton label: 'Enable group2'))
		when: CpPrimaryClickEvent do: [ group2 enable ].
	(outputElement appendChild: (CpButton label: 'Disable group3'))
		when: CpPrimaryClickEvent do: [ group3 disable ].
	(outputElement appendChild: (CpButton label: 'Enable group3'))
		when: CpPrimaryClickEvent do: [ group3 enable ].

	"Add separator"
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	(outputElement appendChild: (CpButton label: 'Disable button1a'))
		when: CpPrimaryClickEvent do: [ button1a disable ].
	(outputElement appendChild: (CpButton label: 'Enable button1a'))
		when: CpPrimaryClickEvent do: [ button1a enable ].
	(outputElement appendChild: (CpButton label: 'Disable button1b'))
		when: CpPrimaryClickEvent do: [ button1b disable ].
	(outputElement appendChild: (CpButton label: 'Enable button1b'))
		when: CpPrimaryClickEvent do: [ button1b enable ].

	"Add separator"
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	(outputElement appendChild: (CpButton label: 'Disable button2a'))
		when: CpPrimaryClickEvent do: [ button2a disable ].
	(outputElement appendChild: (CpButton label: 'Enable button2a'))
		when: CpPrimaryClickEvent do: [ button2a enable ].
	(outputElement appendChild: (CpButton label: 'Disable button2b'))
		when: CpPrimaryClickEvent do: [ button2b disable ].
	(outputElement appendChild: (CpButton label: 'Enable button2b'))
		when: CpPrimaryClickEvent do: [ button2b enable ].

	"Add separator"
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	(outputElement appendChild: (CpButton label: 'Disable button3a'))
		when: CpPrimaryClickEvent do: [ button3a disable ].
	(outputElement appendChild: (CpButton label: 'Enable button3a'))
		when: CpPrimaryClickEvent do: [ button3a enable ].
	(outputElement appendChild: (CpButton label: 'Disable button3b'))
		when: CpPrimaryClickEvent do: [ button3b disable ].
	(outputElement appendChild: (CpButton label: 'Enable button3b'))
		when: CpPrimaryClickEvent do: [ button3b enable ].

]

{ #category : 'examples' }
CpComponentExamplesClientBehavior >> exampleCheckboxes [

	<example: 'Checkboxes' order: 300>

	| outputElement checkbox |
	
	outputElement := self outputElement.
	outputElement textContent: ''.

	checkbox := outputElement appendChild: (CpCheckbox label: 'First selection').

	"Add horizontal separator"
	outputElement appendChild: (' ' inHtmlTag: #span).

	outputElement appendChild: ((CpButton label: 'Make mixed')
			when: CpPrimaryClickEvent do: [ checkbox makeMixed ] ;
			yourself).

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	{ 'One' . 'Two' . 'Three' } withIndexDo: [ :each :index |
		| element |
		outputElement appendChild: (element := CpCheckbox label: each).
		index = 2
			ifTrue: [ element disable ] ]
]

{ #category : 'examples' }
CpComponentExamplesClientBehavior >> exampleDraggableWindows [

	<example: 'Draggable windows' order: 500>

	| outputElement window |
	
	outputElement := self outputElement.
	outputElement textContent: ''.

	window := CpWindow new
		replaceAllChildrenWith: 'Hello World' asHtmlElement atSlotNamed: #title ;
		replaceAllChildrenWith: 'Drag me!' asHtmlElement atSlotNamed: #content ;
		yourself.

	(window firstChildAtSlotNamed: #controls) remove.

	CpHtmlElement documentBody appendChild: window
]

{ #category : 'examples' }
CpComponentExamplesClientBehavior >> exampleLinks [

	<example: 'Links' order: 100>

	| outputElement |
	
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: (CpLink label: 'My link').
	outputElement appendChild: ' ' asHtmlElement.
	outputElement appendChild: ((CpLink label: 'Disabled link') disable ; yourself)
]

{ #category : 'examples' }
CpComponentExamplesClientBehavior >> exampleRadioButtons [

	<example: 'Radio buttons' order: 310>

	| outputElement apples bananas |
	
	outputElement := self outputElement.
	outputElement textContent: ''.

	(outputElement appendChild: CpRadioButtonGroup new)
		appendChild: (CpRadioButton label: 'Apples') ;
		appendChild: (CpRadioButton label: 'Oranges') ;
		appendChild: (CpRadioButton label: 'Bananas') ;
		appendChild: (CpRadioButton label: 'Pears').

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	(outputElement appendChild: (CpRadioButtonGroup new attributeAdd: #vertical ; yourself))
		appendChild: (apples := (CpRadioButton label: 'Apples (disabled)') disable ; yourself) ;
		appendChild: (CpRadioButton label: 'Oranges') ;
		appendChild: (bananas := (CpRadioButton label: 'Bananas (readonly)') beReadOnly ; yourself) ;
		appendChild: (CpRadioButton label: 'Pears').

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: ((CpButton label: 'Select apples')
		when: CpPrimaryClickEvent do: [ apples select ] ;
		yourself).
	outputElement appendChild: ((CpButton label: 'Select bananas')
		when: CpPrimaryClickEvent do: [ bananas select ] ;
		yourself)

]

{ #category : 'examples' }
CpComponentExamplesClientBehavior >> exampleRichTextField [

	"Temporary remove this example, because it is no longer working"
	"<example: 'Rich text fields' order: 400>"

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

{ #category : 'examples' }
CpComponentExamplesClientBehavior >> exampleTextField [

	<example: 'Text fields' order: 400>

	| outputElement text1 text2 |
	
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: ((text1 := CpTextField new)
		styleAt: #width put: '20em' ;
		when: CpInputEvent do: [ self traceCr: 'Text 1: ', text1 text ] ;
		text: 'Hello world' ;
		yourself).

	"Separator"
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: ((text2 := CpTextField new)
		styleAt: #width put: '20em' ;
		when: CpInputEvent do: [ self traceCr: 'Text 2: ', text2 text ] ;
		text: '' ;
		yourself)
]

{ #category : 'events' }
CpComponentExamplesClientBehavior >> handleFocusEvent: aFocusEvent [

	self traceCr: aFocusEvent printString
]

{ #category : 'initialization' }
CpComponentExamplesClientBehavior >> initialize [

	super initialize.

	self showIndex
]

{ #category : 'accessing' }
CpComponentExamplesClientBehavior >> outputElement [

	^ CpHtmlElement documentBody firstDescendantMatching: '#output'
]

{ #category : 'examples' }
CpComponentExamplesClientBehavior >> showIndex [

	"Beware: this method is not to be taken as exemplar for creating a UI.
	This class is just a collection of examples of UI possibilities."

	| body list items |

	CpHtmlElement documentAddStyle: '
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
		}'.
	CpHtmlElement documentAddStylesheet: 'https://use.fontawesome.com/releases/v5.0.7/css/all.css'.
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
		example when: CpPrimaryClickEvent send: item key to: self ]
]

{ #category : 'explanation' }
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
