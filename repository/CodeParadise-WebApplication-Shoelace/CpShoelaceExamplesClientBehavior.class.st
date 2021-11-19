Class {
	#name : #CpShoelaceExamplesClientBehavior,
	#superclass : #CpWebClientBehavior,
	#category : #'CodeParadise-WebApplication-Shoelace-Examples'
}

{ #category : #examples }
CpShoelaceExamplesClientBehavior >> exampleButton [

	<example: 'Button' order: 100>

	| outputElement button disabledState loadingState pillState outlineState |

	"Clear content"
	outputElement := self outputElement.
	outputElement textContent: ''.

	outputElement appendChild: (SlButton label: 'Simple button').
 
	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (SlButton new beDefault ; label: 'Default button' ; yourself).
	outputElement appendChild: (SlButton new beText ; label: 'Text button' ; yourself).
	outputElement appendChild: (SlButton new bePrimary ; label: 'Primary button' ; yourself).
	outputElement appendChild: (SlButton new beSuccess ; label: 'Success button' ; yourself).
	outputElement appendChild: (SlButton new beInfo ; label: 'Info button' ; yourself).
	outputElement appendChild: (SlButton new beWarning ; label: 'Warning button' ; yourself).
	outputElement appendChild: (SlButton new beDanger ; label: 'Danger button' ; yourself).

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (SlButton new beSmall ; label: 'Small button' ; yourself).
	outputElement appendChild: (SlButton new beMedium ; label: 'Medium button' ; yourself).
	outputElement appendChild: (SlButton new beLarge ; label: 'Large button' ; yourself).

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (SlButton new bePill ; label: 'Pill button' ; yourself).
	outputElement appendChild: (SlButton new beNotPill ; label: 'No pill button' ; yourself).

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (SlButton new beCircle ; label: 'CB' ; yourself).
	outputElement appendChild: (SlButton new beNotCircle ; label: 'NCB' ; yourself).

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: (SlButton new beOutline ; label: 'Outline button' ; yourself).
	outputElement appendChild: (SlButton new beNotOutline ; label: 'No outline button' ; yourself).

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	outputElement appendChild: ((SlButton label: 'CodeParadise' suffix: 'box-arrow-up-right' asShoelaceIcon) link: 'https://github.com/ErikOnBike/CodeParadise' target: '_blank' ; yourself).
	outputElement appendChild: ((SlButton label: 'Shoelace' suffix: 'box-arrow-down' asShoelaceIcon) link: 'https://shoelace.style/assets/images/wordmark.svg' download: 'shoelace.svg' ; yourself).

	outputElement appendChild: (CpHtmlElement newWithTag: #p).

	button := outputElement appendChild: (SlButton label: 'Hello world').
	button bePrimary.
	outputElement appendChild: (disabledState := SlCheckbox label: 'Disabled').
	outputElement appendChild: (loadingState := SlCheckbox label: 'Loading').
	outputElement appendChild: (pillState := SlCheckbox label: 'Pill').
	outputElement appendChild: (outlineState := SlCheckbox label: 'Outline').
	disabledState when: SlChangeEvent do: [ disabledState isChecked ifTrue: [ button beDisabled ] ifFalse: [ button beNotDisabled ] ].
	loadingState when: SlChangeEvent do: [ loadingState isChecked ifTrue: [ button beLoading ] ifFalse: [ button beNotLoading ] ].
	pillState when: SlChangeEvent do: [ pillState isChecked ifTrue: [ button bePill ] ifFalse: [ button beNotPill ] ].
	outlineState when: SlChangeEvent do: [ outlineState isChecked ifTrue: [ button beOutline ] ifFalse: [ button beNotOutline ] ].

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
		appendChild: ('Make changes to the above input field to trigger an "input" event. The input content will be displayed below.' inHtmlTag: #p) ;
		appendChild: (('' inHtmlTag: #p) id: #result ; yourself).

	"Show we receive a genuine SlCheckbox element"
	checkbox := outputElement firstDescendantMatching: 'sl-checkbox'.
	checkbox beChecked.

	"Show we receive a genuine SlInput element"
	input := outputElement firstDescendantMatching: 'sl-input'.
	input value: 'initial value received from code'.
	input when: SlInputEvent do: [ (outputElement firstDescendantMatching: '#result') textContent: input value ].

	"Show we receive a genuine SlButton element"
	button := CpDomElement newWithTag: 'sl-button'.
	button label: 'I am created dynamically. I am a ', button class name ; beInfo.
	outputElement insertChild: button before: (outputElement firstDescendantMatching: #div).
]

{ #category : #examples }
CpShoelaceExamplesClientBehavior >> exampleDialog [

	<example: 'Dialog' order: 200>

	| outputElement regularDialog modalDialog mixedDialog modalCheckbox |

	"Clear content"
	outputElement := self outputElement.
	outputElement textContent: ''.

	"Create a simple dialog with a paragraph of text"
	regularDialog := SlDialog new
		label: 'First dialog' ;
		appendChild: ('Hello world' inHtmlTag: #p) ;
		yourself.

	"Add a close button in the dialog footer"
	regularDialog footer: ((SlButton label: 'Close')
		when: CpPrimaryClickEvent send: #hide to: regularDialog ;
		yourself).

	"Create a simple dialog with a paragraph of text"
	modalDialog := SlDialog new
		label: 'Modal dialog' ;
		appendChild: ('You have to click the close button to close this dialog. Clicking outside the dialog will not close it (in contrast to regular dialog).' inHtmlTag: #p) ;
		yourself.

	"Add a close button in the dialog footer"
	modalDialog footer: ((SlButton label: 'Close please!')
		when: CpPrimaryClickEvent send: #hide to: modalDialog ;
		yourself).

	"Create a mixed dialog with a paragraph of text"
	mixedDialog := SlDialog new
		label: 'Mixed dialog' ;
		appendChild: ('This is a mixed dialog. It can either be opened modal or regular. This allows for the same dialog to be reused for different purposes or different levels of ''requiredness''. Have fun!' inHtmlTag: #p) ;
		yourself.

	"Add a close button in the dialog footer"
	mixedDialog footer: ((SlButton label: 'Bye!')
		when: CpPrimaryClickEvent send: #hide to: mixedDialog ;
		yourself).

	"Add buttons to the example, these open the dialog in different ways"
	outputElement
		appendChild: ((SlButton label: 'Open regular')
			when: CpPrimaryClickEvent send: #show to: regularDialog ;
			yourself) ;
		appendChild: ((SlButton label: 'Open modal')
			when: CpPrimaryClickEvent send: #showModal to: modalDialog ;
			yourself) ;
		appendChild: ('' inHtmlTag: #p) ;
		appendChild: (modalCheckbox := SlCheckbox label: 'modal') ;
		appendChild: (' ' inHtmlTag: #span) ;
		appendChild: ((SlButton label: 'Mixed dialog')
			when: CpPrimaryClickEvent do: [ modalCheckbox isChecked ifTrue: [ mixedDialog showModal ] ifFalse: [ mixedDialog showNonModal ] ] ;
			yourself) ;
		appendChild: regularDialog ;
		appendChild: modalDialog ;
		appendChild: mixedDialog

]

{ #category : #examples }
CpShoelaceExamplesClientBehavior >> exampleDrawer [

	<example: 'Drawer' order: 200>

	| outputElement drawer1 drawer2 |

	"Clear content"
	outputElement := self outputElement.
	outputElement textContent: ''.

	"Create some simple drawers with a paragraph of text"
	drawer1 := (SlDrawer label: 'First drawer')
		beStart ;
		appendChild: ('Hello y''all. This is a paragraph in a regular drawer. It became visible because you pushed the red button. The drawer can be closed by clicking outside the drawer.' inHtmlTag: #p) ;
		yourself.
	drawer2 := (SlDrawer label: 'First drwaer')
		beEnd ;
		appendChild: ('Hello there. This is a paragraph in a modal drawer. It became visible because you pushed the blue button. The drawer must be closed by the button inside the drawer.' inHtmlTag: #p) ;
		yourself.

	"Add a close button in the drawer footer"
	drawer1 footer: ((SlButton label: 'Close')
		when: CpPrimaryClickEvent send: #hide to: drawer1 ;
		yourself).

	"Add a close button in the drawer footer"
	drawer2 footer: ((SlButton label: 'Close')
		when: CpPrimaryClickEvent send: #hide to: drawer2 ;
		yourself).

	"Add buttons to the example, these open the dialog in different ways"
	outputElement
		appendChild: ((SlButton label: 'Open left')
			bePrimary ;
			when: CpPrimaryClickEvent send: #show to: drawer1 ;
			yourself) ;
		appendChild: ((SlButton label: 'Open right')
			beWarning ;
			when: CpPrimaryClickEvent send: #showModal to: drawer2 ;
			yourself) ;
		appendChild: drawer1 ;
		appendChild: drawer2

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

	outputElement appendChild: (SlInput new bePassword ; beTogglePassword ; label: 'Your password' ; yourself).

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
	disabledState when: SlChangeEvent do: [ disabledState isChecked ifTrue: [ input beDisabled ] ifFalse: [ input beNotDisabled ] ].
	pillState when: SlChangeEvent do: [ pillState isChecked ifTrue: [ input bePill ] ifFalse: [ input beNotPill ] ].
	clearableState when: SlChangeEvent do: [ clearableState isChecked ifTrue: [ input beClearable ] ifFalse: [ input beNotClearable ] ].

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
	disabledState when: SlChangeEvent do: [ disabledState isChecked ifTrue: [ input beDisabled ] ifFalse: [ input beNotDisabled ] ].
	resizeableState when: SlChangeEvent do: [ resizeableState isChecked ifTrue: [ input resizeAuto ] ifFalse: [ input resizeNone ] ].

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
		example when: CpPrimaryClickEvent send: item key to: self ]
]
