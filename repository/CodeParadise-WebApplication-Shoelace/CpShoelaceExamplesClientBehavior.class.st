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
CpShoelaceExamplesClientBehavior >> exampleButtonGroup [

	<example: 'ButtonGroup' order: 100>

	| outputElement |

	"Clear content"
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: (SlButtonGroup new
		appendChild: (SlButton new label: 'First' ; yourself) ;
		appendChild: (SlButton new label: 'Second' ; yourself) ;
		appendChild: (SlButton new label: 'Third' ; yourself) ;
		yourself)

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
CpShoelaceExamplesClientBehavior >> exampleCode [

	<example: 'Code' order: 900>

	| outputElement checkbox input button |

	"Clear content"
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement
		appendChild: ('Here is an example of HTML code containing WebComponents which can be queried using Smalltalk code' inHtmlTag: #p) ;
		appendChild: ((CpHtmlElement newWithTag: #div) markupContent: '<div><sl-button type="primary">Primary</sl-button> <sl-button><sl-icon name="emoji-smile" slot="prefix"></sl-icon>Smile!</sl-button></div><div><sl-checkbox>I am happy</sl-checkbox></div><div><sl-input label="What is your name?"></sl-input>' ; yourself) ;
		appendChild: ('Leave the above input field to trigger a "changed" event. The input content will be displayed below.' inHtmlTag: #p) ;
		appendChild: (('' inHtmlTag: #p) id: #result ; yourself).

	"Show we receive a genuine SlCheckbox element"
	checkbox := outputElement firstDescendantMatching: 'sl-checkbox'.
	checkbox beChecked.

	"Show we receive a genuine SlInput element"
	input := outputElement firstDescendantMatching: 'sl-input'.
	input value: 'initial value received from code'.
	input when: CpChangeEvent do: [ (outputElement firstDescendantMatching: '#result') textContent: input value ].

	"Show we receive a genuine SlButton element"
	button := CpDomElement newWithTag: 'sl-button'.
	button label: 'I am created dynamically. I am a ', button class name ; info.
	outputElement insertChild: button before: (outputElement firstDescendantMatching: #div).
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

{ #category : #examples }
CpShoelaceExamplesClientBehavior >> exampleSwitch [

	<example: 'Switch' order: 100>

	| outputElement |

	"Clear content"
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement
		appendChild: ('Some switches' inHtmlTag: #p) ;
		appendChild: SlSwitch new ;
		appendChild: (SlSwitch new beChecked ; yourself) ;
		appendChild: (SlSwitch new beDisabled ; yourself) ;
		appendChild: (SlSwitch new beDisabled ; beChecked ; yourself)
]

{ #category : #examples }
CpShoelaceExamplesClientBehavior >> exampleTextarea [

	<example: 'Textarea' order: 100>

	| outputElement input disabledState resizeableState |

	"Clear content"
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: (SlTextarea new label: 'Need your input' ; yourself).

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (SlTextarea new placeholder: 'Your first name' ; yourself).

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (SlTextarea new helpText: 'I''m here to help you' ; label: 'Textarea with help text' ; placeholder: 'Anything you want to share?' ; yourself).

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (SlTextarea new
		help: ((CpHtmlElement newWithTag: #span) appendChild: ('Happy help ' inHtmlTag: #span) ; appendChild: (SlIcon name: 'emoji-smile') ; yourself) ;
		label: 'Happy textarea (with help HTML and icons)' ;
		placeholder: 'Anything you want to share?' ;
		yourself).

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	input := outputElement appendChild: (SlTextarea new label: 'Need more input').
	outputElement appendChild: (disabledState := SlCheckbox label: 'Disabled').
	outputElement appendChild: (resizeableState := SlCheckbox label: 'Resizeable').
	disabledState when: CpChangeEvent do: [ disabledState isChecked ifTrue: [ input beDisabled ] ifFalse: [ input beNotDisabled ] ].
	resizeableState when: CpChangeEvent do: [ resizeableState isChecked ifTrue: [ input autoResize ] ifFalse: [ input noResize ] ].

]

{ #category : #examples }
CpShoelaceExamplesClientBehavior >> exampleTooltip [

	<example: 'Tooltip' order: 100>

	| outputElement |

	"Clear content"
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement
		appendChild: (SlTooltip new contentText: 'This is one funny icon' ; appendChild: (SlIcon name: 'emoji-smile') ; yourself) ;
		appendChild: ('' inHtmlTag: #p) ;
		appendChild: (SlTooltip new contentText: 'topStart' ; topStart ; appendChild: (SlButton label: 'topStart') ; yourself) ;
		appendChild: (SlTooltip new contentText: 'top' ; top ; appendChild: (SlButton label: 'top') ; yourself) ;
		appendChild: (SlTooltip new contentText: 'topEnd' ; topEnd ; appendChild: (SlButton label: 'topEnd') ; yourself) ;
		appendChild: ('' inHtmlTag: #p) ;
		appendChild: (SlTooltip new contentText: 'rightStart' ; rightStart ; appendChild: (SlButton label: 'rightStart') ; yourself) ;
		appendChild: (SlTooltip new contentText: 'right' ; right ; appendChild: (SlButton label: 'right') ; yourself) ;
		appendChild: (SlTooltip new contentText: 'rightEnd' ; rightEnd ; appendChild: (SlButton label: 'rightEnd') ; yourself) ;
		appendChild: ('' inHtmlTag: #p) ;
		appendChild: (SlTooltip new contentText: 'bottomStart' ; bottomStart ; appendChild: (SlButton label: 'bottomStart') ; yourself) ;
		appendChild: (SlTooltip new contentText: 'bottom' ; bottom ; appendChild: (SlButton label: 'bottom') ; yourself) ;
		appendChild: (SlTooltip new contentText: 'bottomEnd' ; bottomEnd ; appendChild: (SlButton label: 'bottomEnd') ; yourself) ;
		appendChild: ('' inHtmlTag: #p) ;
		appendChild: (SlTooltip new contentText: 'leftStart' ; leftStart ; appendChild: (SlButton label: 'leftStart') ; yourself) ;
		appendChild: (SlTooltip new contentText: 'left' ; left ; appendChild: (SlButton label: 'left') ; yourself) ;
		appendChild: (SlTooltip new contentText: 'leftEnd' ; leftEnd ; appendChild: (SlButton label: 'leftEnd') ; yourself) ;
		appendChild: ('' inHtmlTag: #p) ;
		appendChild: (SlTooltip new content: (SlIcon name: 'emoji-smile') ; appendChild: (SlButton label: 'HTML in tooltip') ; yourself) ;
		appendChild: ('' inHtmlTag: #p) ;
		appendChild: (SlTooltip new contentText: 'You clicked for me?' ; triggerClick ; appendChild: (SlButton label: 'Tooltip via click') ; yourself)
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
			#output div {
				padding-top: 1em;
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
