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
CpFomanticExamplesClientBehavior >> createCalendarWithLabel: labelString andIcon: iconString [

	^ (CpHtmlElement newWithTag: #div)
		attributeAt: #class put: 'ui calendar' ;
		appendChild: ((CpHtmlElement newWithTag: #div)
			attributeAt: #class put: 'ui input left icon' ;
			appendChild: ((CpHtmlElement newWithTag: #i)
				attributeAt: #class put: iconString, ' icon' ;
				yourself) ;
			appendChild: ((CpHtmlElement newWithTag: #input)
				attributeAt: #type put: 'text' ;
				attributeAt: #placeholder put: labelString ;
				yourself) ;
			yourself)
]

{ #category : #examples }
CpFomanticExamplesClientBehavior >> createCheckboxWithLabel: labelString [

	^ (CpHtmlElement newWithTag: #div)
		attributeAt: #class put: 'ui toggle checkbox' ;
		appendChild: ((CpHtmlElement newWithTag: #input)
			attributeAt: #type put: 'checkbox' ;
			attributeAt: #tabindex put: '0' ;
			attributeAt: #class put: 'hidden' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #label)
			textContent: labelString ;
			yourself) ;
		yourself
]

{ #category : #examples }
CpFomanticExamplesClientBehavior >> createHeaderWithIcon: iconString andLabel: labelString andSubLabel: subLabelString [

	^ (CpHtmlElement newWithTag: #h1)
		attributeAt: #class put: 'ui icon header' ;
		appendChild: ((CpHtmlElement newWithTag: #i)
			attributeAt: #class put: iconString, ' icon' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #div)
			attributeAt: #class put: 'content' ;
			appendChild: ((CpHtmlElement newWithTag: #span)
				textContent: labelString ;
				yourself) ;
			appendChild: ((CpHtmlElement newWithTag: #div)
				attributeAt: #class put: 'sub header' ;
				textContent: subLabelString ;
				yourself) ;
			yourself) ;
		yourself
]

{ #category : #examples }
CpFomanticExamplesClientBehavior >> exampleButton [

	<example: 'Button' order: 100>

	| button |

	CpHtmlElement documentBody appendChild: ((CpHtmlElement newWithTag: #button)
		attributeAt: #class put: 'ui button' ;
		textContent: 'Hello world' ;
		yourself).

	button := FuiButton new
		textContent: 'Second button' ;
		yourself.
	CpHtmlElement documentBody appendChild: button.
	CpBrowserEventHandler current registerInterestIn: button
]

{ #category : #examples }
CpFomanticExamplesClientBehavior >> exampleCalendar [

	<example: 'Calendar' order: 100>

	CpHtmlElement documentBody
		appendChild: (self createCalendarWithLabel: 'Date' andIcon: 'calendar') ;
		appendChild: ((self createCalendarWithLabel: 'Time' andIcon: 'time') becomeElement: #calendar with: { #type -> 'time' } asDictionary) ;
		appendChild: ((self createCalendarWithLabel: 'Year' andIcon: 'calendar') becomeElement: #calendar with: { #startMode -> 'year' } asDictionary)
]

{ #category : #examples }
CpFomanticExamplesClientBehavior >> exampleCheckbox [

	<example: 'Checkbox' order: 100>

	CpHtmlElement documentBody
		appendChild: (self createCheckboxWithLabel: 'First checkbox') ;
		appendChild: ((self createCheckboxWithLabel: 'Second checkbox') becomeElement: #checkbox)
]

{ #category : #examples }
CpFomanticExamplesClientBehavior >> exampleHeader [

	<example: 'Header' order: 100>

	CpHtmlElement documentBody
		appendChild: (self createHeaderWithIcon: 'settings' andLabel: 'Account settings' andSubLabel: 'Manage your account settings and set e-mail preferences.')
]

{ #category : #events }
CpFomanticExamplesClientBehavior >> handleEvent: anEvent [

	self crTrace: anEvent printString
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

{ #category : #examples }
CpFomanticExamplesClientBehavior >> showIndex [

	| items |

	self loadFomantic.

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
	items do: [ :each | self crTrace: each printString ].
	self exampleButton ; exampleCheckbox ; exampleCalendar ; exampleHeader
]
