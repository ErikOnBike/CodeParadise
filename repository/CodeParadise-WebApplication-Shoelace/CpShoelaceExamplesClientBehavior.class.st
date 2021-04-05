Class {
	#name : #CpShoelaceExamplesClientBehavior,
	#superclass : #CpWebClientBehavior,
	#category : #'CodeParadise-WebApplication-Shoelace-Examples'
}

{ #category : #examples }
CpShoelaceExamplesClientBehavior >> exampleButton [

	<example: 'Button' order: 100>

	| outputElement button disabledState loadingState pillState |

	"Clear content"
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: (SlButton label: 'Simple button').

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (SlButton new default ; label: 'Default button' ; yourself).
	outputElement appendChild: (SlButton new text ; label: 'Text button' ; yourself).
	outputElement appendChild: (SlButton new primary ; label: 'Primary button' ; yourself).
	outputElement appendChild: (SlButton new success ; label: 'Success button' ; yourself).
	outputElement appendChild: (SlButton new info ; label: 'Info button' ; yourself).
	outputElement appendChild: (SlButton new warning ; label: 'Warning button' ; yourself).
	outputElement appendChild: (SlButton new danger ; label: 'Danger button' ; yourself).

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (SlButton new small ; label: 'Small button' ; yourself).
	outputElement appendChild: (SlButton new medium ; label: 'Medium button' ; yourself).
	outputElement appendChild: (SlButton new large ; label: 'Large button' ; yourself).

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (SlButton new bePill ; label: 'Pill button' ; yourself).
	outputElement appendChild: (SlButton new beNoPill ; label: 'No pill button' ; yourself).

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (SlButton new beCircle ; label: 'CB' ; yourself).
	outputElement appendChild: (SlButton new beNoCircle ; label: 'NCB' ; yourself).

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: ((SlButton label: 'CodeParadise' suffix: 'box-arrow-up-right' asShoelaceIcon) link: 'https://github.com/ErikOnBike/CodeParadise' target: '_blank' ; yourself).
	outputElement appendChild: ((SlButton label: 'Shoelace' suffix: 'box-arrow-down' asShoelaceIcon) link: 'https://shoelace.style/assets/images/wordmark.svg' download: 'shoelace.svg' ; yourself).

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	button := outputElement appendChild: (SlButton label: 'Hello world').
	outputElement appendChild: (disabledState := SlCheckbox label: 'Disabled').
	outputElement appendChild: (loadingState := SlCheckbox label: 'Loading').
	outputElement appendChild: (pillState := SlCheckbox label: 'Pill').
	disabledState when: CpChangeEvent do: [ disabledState isChecked ifTrue: [ button beDisabled ] ifFalse: [ button beNotDisabled ] ].
	loadingState when: CpChangeEvent do: [ loadingState isChecked ifTrue: [ button beLoading ] ifFalse: [ button beNotLoading ] ].
	pillState when: CpChangeEvent do: [ pillState isChecked ifTrue: [ button bePill ] ifFalse: [ button beNoPill ] ].

]

{ #category : #examples }
CpShoelaceExamplesClientBehavior >> exampleCheckbox [

	<example: 'Checkbox' order: 100>

	| outputElement |

	"Clear content"
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement
		appendChild: ((CpHtmlElement newWithTag: #div)
			appendChild: (SlCheckbox label: 'Works') ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #div)
			appendChild: ((SlCheckbox label: 'Amazing') beIndeterminate ; yourself) ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #div)
			appendChild: ((SlCheckbox label: 'Not me') beDisabled ; yourself) ;
			yourself)
]

{ #category : #examples }
CpShoelaceExamplesClientBehavior >> exampleIcon [

	<example: 'Icon' order: 100>

	| outputElement |

	"Clear content"
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement
		appendChild: (SlIcon name: 'emoji-smile') ;
		appendChild: (SlIcon name: 'heart') ;
		appendChild: (SlIcon name: 'hand-thumbs-up-fill') ;
		appendChild: (SlIcon name: 'star-fill')

]

{ #category : #examples }
CpShoelaceExamplesClientBehavior >> exampleInput [

	<example: 'Input' order: 100>

	| outputElement input disabledState pillState clearableState |

	"Clear content"
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: (SlInput new label: 'Need your input' ; yourself).

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (SlInput new placeholder: 'Your first name' ; yourself).

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (SlInput new password ; togglePassword ; label: 'Your password' ; yourself).

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (SlInput new helpText: 'I''m here to help you' ; label: 'Input with help text' ; placeholder: 'Anything you want to share?' ; yourself).

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (SlInput new
		help: ((CpHtmlElement newWithTag: #span) appendChild: ('Happy help ' inHtmlTag: #span) ; appendChild: (SlIcon name: 'emoji-smile') ; yourself) ;
		label: 'Happy input (with help HTML and icons)' ;
		placeholder: 'Anything you want to share?' ;
		prefix: (SlIcon name: 'emoji-smile') ;
		suffix: (SlIcon name: 'emoji-smile') ;
		yourself).

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	input := outputElement appendChild: (SlInput new label: 'Need more input').
	outputElement appendChild: (disabledState := SlCheckbox label: 'Disabled').
	outputElement appendChild: (pillState := SlCheckbox label: 'Pill').
	outputElement appendChild: (clearableState := SlCheckbox label: 'Clearable').
	disabledState when: CpChangeEvent do: [ disabledState isChecked ifTrue: [ input beDisabled ] ifFalse: [ input beNotDisabled ] ].
	pillState when: CpChangeEvent do: [ pillState isChecked ifTrue: [ input bePill ] ifFalse: [ input beNoPill ] ].
	clearableState when: CpChangeEvent do: [ clearableState isChecked ifTrue: [ input beClearable ] ifFalse: [ input beNotClearable ] ].

]

{ #category : #initialization }
CpShoelaceExamplesClientBehavior >> initialize [

	super initialize.

	self showIndex
]

{ #category : #accessing }
CpShoelaceExamplesClientBehavior >> outputElement [

	^ CpHtmlElement documentBody firstDescendantMatching: '#output'
]

{ #category : #examples }
CpShoelaceExamplesClientBehavior >> showIndex [

	"Beware: this method is NOT to be taken as exemplar for creating a UI.
	This class is just a collection of examples of UI possibilities."

	| body list items |

	CpHtmlElement documentHead appendChild: ((CpHtmlElement newWithTag: #style)
		textContent: '
			#menu {
				display: inline-block;
				width: 20em;
				height: calc(100vh - 6em);
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
	body markupContent: '<h1>Shoelace Examples</h1>
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

		example := SlButton
			label: item value first		"ie title"
			suffix: 'arrow-right' asShoelaceIcon.

		list appendChild: ((CpHtmlElement newWithTag: #li)
			appendChild: example ;
			yourself).

		"Register interest in events on the list item"
		example when: CpClickEvent send: item key to: self ]
]
