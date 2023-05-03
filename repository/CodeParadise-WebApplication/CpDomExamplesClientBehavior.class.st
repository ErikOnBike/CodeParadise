"
I am the client behavior for the DOM Example Server Application.
I only live in the ClientEnvironment.
"
Class {
	#name : #CpDomExamplesClientBehavior,
	#superclass : #CpWebClientBehavior,
	#instVars : [
		'transition',
		'textRegistry'
	],
	#category : #'CodeParadise-WebApplication-Examples'
}

{ #category : #resources }
CpDomExamplesClientBehavior class >> gearPathForRaduis: radius teeth: teethCount asAnnulus: aBoolean [

	| path innerRadius outerRadius axelRadius arcDelta arc |

	innerRadius := radius - 8.
	outerRadius := radius + 8.
	axelRadius := 20.
	arcDelta := Float pi / teethCount.
	arc := Float pi negated / 2.

	path := String streamContents: [ :stream |

		"Set start position"
		stream nextPut: $M.
		innerRadius * arc cos printOn: stream.
		stream nextPut: $,.
		innerRadius * arc sin printOn: stream.

		"Create all teeth"
		teethCount timesRepeat: [

			"Inner/lower part of tooth"
			stream nextPut: $A.
			innerRadius printOn: stream.
			stream nextPut: $,.
			innerRadius printOn: stream.
			stream nextPutAll: ' 0 0,1  '.
			innerRadius * (arc := arc + arcDelta) cos printOn: stream.
			stream nextPut: $,.
			innerRadius * arc sin printOn: stream.
			stream nextPut: $L.
			radius * arc cos printOn: stream.
			stream nextPut: $,.
			radius * arc sin printOn: stream.
			stream nextPut: $L.
			outerRadius * (arc := arc + (arcDelta / 3)) cos printOn: stream.
			stream nextPut: $,.
			outerRadius * arc sin printOn: stream.

			"Outer/higher part of tooth"
			stream nextPut: $A.
			outerRadius printOn: stream.
			stream nextPut: $,.
			outerRadius printOn: stream.
			stream nextPutAll: ' 0 0,1 '.
			outerRadius * (arc := arc + (arcDelta / 3)) cos printOn: stream.
			stream nextPut: $,.
			outerRadius * arc sin printOn: stream.
			stream nextPut: $L.
			radius * (arc := arc + (arcDelta / 3)) cos printOn: stream.
			stream nextPut: $,.
			radius * arc sin printOn: stream.
			stream nextPut: $L.
			innerRadius * arc cos printOn: stream.
			stream nextPut: $,.
			innerRadius * arc sin printOn: stream].

		"Create axel hole"
		stream nextPutAll: 'M0,'.
		axelRadius negated printOn: stream.
		stream nextPut: $A.
		axelRadius printOn: stream.
		stream nextPut: $,.
		axelRadius printOn: stream.
		stream nextPutAll: ' 0 0,0 0,'.
		axelRadius printOn: stream.
		stream nextPut: $A.
		axelRadius printOn: stream.
		stream nextPut: $,.
		axelRadius printOn: stream.
		stream nextPutAll: ' 0 0,0 0,'.
		axelRadius negated printOn: stream.
		stream nextPut: $Z ].

	^ path
]

{ #category : #examples }
CpDomExamplesClientBehavior class >> someValue [

	^ 3 + 4
]

{ #category : #accessing }
CpDomExamplesClientBehavior >> clearOutput [

	transition ifNotNil: [ transition stop ].

	self outputElement textContent: ''
]

{ #category : #examples }
CpDomExamplesClientBehavior >> exampleAnimationMany [

	<example: 'Many Animation' order: 810>

	| outputElement |
	
	self clearOutput.
	outputElement := self outputElement.

	100 timesRepeat: [
		| element |
		
		element := outputElement appendChild: ((CpHtmlElement newWithTag: #div)
			styleAt: #display put: 'inline-block' ;
			styleAt: #width put: '10vmin' ;
			styleAt: #height put: '10vmin' ;
			styleAt: #margin put: '.2vmin' ;
			styleAt: #'background-color' put: '#C2B280' ;
			yourself).

		[ :p | element styleAt: #transform put: 'rotate(', (90 * p) printString, 'deg)' ] asTransition
			duration: 400 ;
			startDelayedBy: 1000 ]
]

{ #category : #examples }
CpDomExamplesClientBehavior >> exampleAnimationSimple [

	<example: 'Simple Animation' order: 800>

	| outputElement element1 element2 |
	
	self clearOutput.
	outputElement := self outputElement.

	element1 := outputElement appendChild: ((CpHtmlElement newWithTag: #div)
		styleAt: #width put: '50vmin' ;
		styleAt: #height put: '50vmin' ;
		styleAt: #'background-color' put: '#C2B280' ;
		yourself).
	element2 := outputElement appendChild: ((CpHtmlElement newWithTag: #div)
		styleAt: #width put: '50vmin' ;
		styleAt: #height put: '20vmin' ;
		styleAt: #'background-color' put: '#B280C2' ;
		yourself).

	[ :p | element1 styleAt: #transform put: 'rotate(', (360 * p) printString, 'deg)' ] asTransition
		duration: 1500 ;
		start.
	[ :p | element2 styleAt: #transform put: 'translate(', (200 * p) printString, 'px,0)' ] asTransition
		duration: 800 ;
		startDelayedBy: 700

]

{ #category : #examples }
CpDomExamplesClientBehavior >> exampleClickEvents [

	<example: 'Click Events' order: 900>

	| outputElement buttonDefs |
	
	self clearOutput.
	outputElement := self outputElement.

	buttonDefs := {
		'Native click' -> CpClickEvent.
		'Any button (no modifier)' -> CpAnyClickEvent.
		'Primary button (no modifier)' -> CpPrimaryClickEvent.
		'Primary button (no modifier, short click)' -> (CpPrimaryClickEvent + CpShortClickModifier).
		'Primary button (no modifier, long click)' -> (CpPrimaryClickEvent + CpLongClickModifier).
		'Primary button with shift' -> (CpPrimaryClickEvent + CpShiftModifier).
		'Primary button with alt' -> (CpPrimaryClickEvent + CpAltModifier).
		'Primary button with ctrl' -> (CpPrimaryClickEvent + CpCtrlModifier).
		'Primary button with meta' -> (CpPrimaryClickEvent + CpMetaModifier).
		'Primary button with ctrl + meta' -> (CpPrimaryClickEvent + CpMetaModifier + CpCtrlModifier).
		'Secondary button (no modifier)' -> CpSecondaryClickEvent.
		'Secondary button (no modifier, short click)' -> (CpSecondaryClickEvent + CpShortClickModifier).
		'Secondary button (no modifier, long click)' -> (CpSecondaryClickEvent + CpLongClickModifier).
		'Secondary button with shift' -> (CpSecondaryClickEvent + CpShiftModifier).
		'Secondary button with alt' -> (CpSecondaryClickEvent + CpAltModifier).
		'Secondary button with ctrl' -> (CpSecondaryClickEvent + CpCtrlModifier).
		'Secondary button with meta' -> (CpSecondaryClickEvent + CpMetaModifier).
		'Secondary button with ctrl + shift' -> (CpSecondaryClickEvent + CpCtrlModifier + CpShiftModifier).
	}.

	buttonDefs do: [ :each |
		outputElement appendChild: ((CpHtmlElement newWithTag: #div)
			styleAt: #'margin-top' put: '1.4em' ;
			styleAt: #width put: '20em' ;
			styleAt: #height put: '2em' ;
			styleAt: #'border-radius' put: '1em' ;
			styleAt: #'background-color' put: #blue ;
			styleAt: #color put: #white ;
			styleAt: #cursor put: #pointer ;
			styleAt: #'text-align' put: #center ;
			styleAt: #'line-height' put: '2em' ;
			styleAt: #'user-select' put: #none ;
			styleAt: #'-webkit-user-select' put: #none ;
			textContent: each key ;
			when: each value send: #wiggleOnEvent: to: self ;
			yourself) ]
]

{ #category : #examples }
CpDomExamplesClientBehavior >> exampleCreateRandomBlocks [

	<example: 'Create 1000 random blocks' order: 100>

	| outputElement |
	
	self clearOutput.
	outputElement := self outputElement.

	1000 timesRepeat: [
		| block left top |
		block := CpDomElement newWithTag: #div.
		left := 100 atRandom.
		top := 100 atRandom.

		"Set individual style elements (see #exampleCreateRandomEllipses for alternative)."
		"The following is more readable then #exampleCreateRandomEllipses, but less performant."
		block
			styleAt: #position put: #absolute ;
			styleAt: #left put: left printString, '%' ;
			styleAt: #top put: top printString, '%' ;
			styleAt: #width put: (100 - left) atRandom printString, '%' ;
			styleAt: #height put: (100 - top) atRandom printString, '%' ;
			styleAt: #'background-color' put: 'rgb(', 255 atRandom printString, ',', 255 atRandom printString, ',', 255 atRandom printString, ')'.

		"Only append DOM element once it is fully constructed (to prevent redrawing)"
		outputElement appendChild: block ]
]

{ #category : #examples }
CpDomExamplesClientBehavior >> exampleCreateRandomEllipses [

	<example: 'Create 1000 random ellipses' order: 100>

	| outputElement |
	
	self clearOutput.
	outputElement := self outputElement.

	1000 timesRepeat: [
		| ellipse style left top width height |

		ellipse := CpDomElement newWithTag: #div.
		left := 100 atRandom.
		top := 100 atRandom.
		width := (100 - left) atRandom.
		height := (100 -top) atRandom.

		"Create single style value (see #exampleCreateRandomBlocks for alternative)."
		"The following is less readable then #exampleCreateRandomBlocks, but more performant."
		"On MacBook Pro (mid 2015) with i7 using Safari 1000 creates takes around 430ms vs 720ms."
		"It might also be more error-prone to construct the style, but YMMV."
		style := String streamContents: [ :stream |
			stream nextPutAll: 'position: absolute; border-radius: 50%; left: '.
			left printOn: stream.
			stream nextPutAll: '%; top: '.
			top printOn: stream.
			stream nextPutAll: '%; width: '.
			width printOn: stream.
			stream nextPutAll: '%; height: '.
			height printOn: stream.
			stream nextPutAll: '%; background-color: rgb('.
			255 atRandom printOn: stream.
			stream nextPut: $,.
			255 atRandom printOn: stream.
			stream nextPut: $,.
			255 atRandom printOn: stream.
			stream nextPutAll: ');' ].
		ellipse style: style.

		"Only append DOM element once it is fully constructed (to prevent redrawing)"
		outputElement appendChild: ellipse ]
]

{ #category : #examples }
CpDomExamplesClientBehavior >> exampleEvents [

	<example: 'Events' order: 910>

	| outputElement |

	textRegistry := Dictionary new.
	self clearOutput.
	outputElement := self outputElement.

	outputElement appendChild: ((CpHtmlElement newWithTag: #div)
		markupContent: '
			<h3>Inner and outer (both accepting events)</h3>
			<div id="outer" style="padding: 2em; background-color: rgba(255, 0, 0, .1)">
				<div id="inner" style="padding: 2em; background-color: rgba(0, 255, 0, .1)">
					<span style="display: inline-block" class="text"></span>
				</div>
				<span style="display: inline-block" class="text"></span>
			</div>

			<h3>Inner and outer (inner has 2 handlers, first stops propagation)</h3>
			<p>Use SHIFT + click</p>
			<div id="outer2" style="padding: 2em; background-color: rgba(255, 0, 0, .1)">
				<div id="inner2" style="padding: 2em; background-color: rgba(0, 255, 0, .1)">
					<span style="display: inline-block" class="text1"></span>
					<span style="display: inline-block" class="text2"></span>
				</div>
					<span style="display: inline-block" class="text"></span>
			</div>

			<h3>Inner and outer (inner has 2 handlers, first stops propagation immediately)</h3>
			<p>Use CTRL + click</p>
			<div id="outer3" style="padding: 2em; background-color: rgba(255, 0, 0, .1)">
				<div id="inner3" style="padding: 2em; background-color: rgba(0, 255, 0, .1)">
					<span style="display: inline-block" class="text1"></span>
					<span style="display: inline-block" class="text2"></span>
				</div>
					<span style="display: inline-block" class="text"></span>
			</div>
		' ;
		yourself).

	(outputElement firstDescendantMatching: '#outer')
		when: CpPrimaryClickEvent do: [ self showText: 'Clicked' in: '#outer > .text' ].
	(outputElement firstDescendantMatching: '#inner')
		when: CpPrimaryClickEvent do: [ self showText: 'Clicked' in: '#inner > .text' ].

	(outputElement firstDescendantMatching: '#outer2')
		when: CpPrimaryClickEvent + CpShiftModifier do: [ self showText: 'Clicked' in: '#outer2 > .text' ].
	(outputElement firstDescendantMatching: '#inner2')
		when: CpPrimaryClickEvent + CpShiftModifier do: [ :event | event stopPropagation. self showText: 'Clicked (1st handler)' in: '#inner2 > .text1' ].
	(outputElement firstDescendantMatching: '#inner2')
		when: CpPrimaryClickEvent + CpShiftModifier do: [ :event | self showText: 'Clicked (2nd handler)' in: '#inner2 > .text2' ].

	(outputElement firstDescendantMatching: '#outer3')
		when: CpPrimaryClickEvent + CpCtrlModifier do: [ self showText: 'Clicked' in: '#outer3 > .text' ].
	(outputElement firstDescendantMatching: '#inner3')
		when: CpPrimaryClickEvent + CpCtrlModifier do: [ :event | event stopImmediatePropagation. self showText: 'Clicked (1st handler)' in: '#inner3 > .text1' ].
	(outputElement firstDescendantMatching: '#inner3')
		when: CpPrimaryClickEvent + CpCtrlModifier do: [ :event | self showText: 'Clicked (2nd handler)' in: '#inner3 > .text2' ].

]

{ #category : #examples }
CpDomExamplesClientBehavior >> exampleHelloWorld [

	<example: 'Hello world' order: 10>

	| outputElement |

	self clearOutput.
	outputElement := self outputElement.

	outputElement appendChild: ((CpHtmlElement newWithTag: #h1)
		textContent: 'Hello 😀 world' ;
		yourself).
	outputElement appendChild: ((CpHtmlElement newWithTag: #section)
		markupContent: '<p>Change <code>', self class name, ' >> #someValue</code> in the ServerEnvironment, save it and then click again on my link in the menu on the left. Without needing to reload this page, the application has updated this ClientEnvironment.</p><p>Remember that all methods in this class are actually executed in the ClientEnvironment (here in the browser). This means there are many restrictions on what you can do. Trying to show an inspector will not work yet...</p><p>Please do try this out on other examples as well.</p><p>Since this code is still work in progress, some things might break. Please register any issues and/or consider contributing any fixes you find.</p>' ;
		yourself).
	outputElement appendChild: ((CpHtmlElement newWithTag: #p)
		styleAt: #'font-size' put: '4em' ;
		textContent: self class someValue printString ;
		yourself)
]

{ #category : #examples }
CpDomExamplesClientBehavior >> exampleMathFormula [

	<example: 'MathML formula' order: 200>

	| outputElement mathElement |

	self clearOutput.
	outputElement := self outputElement.

	"Content is created through markup instead of DOM manipulation."
	"Compare this with #exampleSVGSimple"
	outputElement markupContent: '<h1>MathML formula</h1>
	<p>The following formula might not be visible on all browsers</p>'.

	mathElement := outputElement appendChild: (CpMathElement newWithTag: #math).
	mathElement markupContent: '<mtable columnalign="left"><mtr><mtd><mrow><mrow><mrow><mrow> <mi>a</mi> <msup> <mi>x</mi> <mn>2</mn> </msup></mrow> <mo> + </mo> <mi>b</mi> <mi>x</mi> </mrow> <mo> + </mo> <mi>c</mi> </mrow> <mo>=</mo> <mn>0</mn> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mi>a</mi> <msup> <mi>x</mi> <mn>2</mn> </msup></mrow> <mo> + </mo> <mi>b</mi> <mi>x</mi> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> </mrow> <mo>=</mo> <mo>-</mo><mi> c</mi><mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <msup> <mi>x</mi> <mn>2</mn> </msup></mrow> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mi>a</mi> </mfrac> <mi>x</mi> </mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mo>=</mo> <mfrac> <mrow> <mo>-</mo><mi>c</mi> </mrow> <mi>a</mi> </mfrac> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt">Divide out leading coefficient.</mtext> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <msup> <mi>x</mi> <mn>2</mn> </msup></mrow> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mi>a</mi> </mfrac> <mi>x</mi> <mo> + </mo> <msup> <mfenced> <mfrac> <mrow> <mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow> </mfrac> </mfenced> <mn>2</mn> </msup> </mrow> <mo>=</mo> <mfrac> <mrow> <mo>-</mo> <mi>c</mi> <mo>(</mo> <mn>4</mn> <mi>a</mi> <mo>)</mo> </mrow> <mrow> <mi>a</mi> <mo>(</mo> <mn>4</mn> <mi>a</mi> <mo>)</mo> </mrow></mfrac> </mrow> <mo> + </mo> <mfrac> <mrow> <msup> <mi>b</mi> <mn>2</mn> </msup> </mrow> <mrow> <mn>4</mn> <msup> <mi>a</mi> <mn>2</mn> </msup> </mrow></mfrac> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt">Complete the square.</mtext> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mo>(</mo> <mi>x</mi> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> <mo>)</mo> <mo>(</mo> <mi>x</mi> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> <mo>)</mo> <mo>=</mo> <mfrac> <mrow> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo> - </mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </mrow> <mrow> <mn>4</mn> <msup> <mi>a</mi> <mn>2</mn> </msup> </mrow></mfrac> </mrow> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt">Discriminant revealed.</mtext> </mrow> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <msup> <mrow> <mo>(</mo> <mi>x</mi> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> <mo>)</mo> </mrow> <mn>2</mn> </msup> <mo>=</mo> <mfrac> <mrow> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo> - </mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </mrow> <mrow> <mn>4</mn> <msup> <mi>a</mi> <mn>2</mn> </msup> </mrow></mfrac> </mrow> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt"></mtext> </mrow> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mrow> <mi>x</mi> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> </mrow> <mo>=</mo> <msqrt> <mfrac> <mrow> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo> - </mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </mrow> <mrow> <mn>4</mn> <msup> <mi>a</mi> <mn>2</mn> </msup> </mrow></mfrac> </msqrt> </mrow> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt"></mtext> </mrow> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mrow> <mi>x</mi> </mrow> <mo>=</mo> <mfrac> <mrow> <mo>-</mo><mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> <mo>±</mo><mrow><mo>{</mo><mi>C</mi><mo>}</mo></mrow> <msqrt> <mfrac> <mrow> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo> - </mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </mrow> <mrow> <mn>4</mn> <msup> <mi>a</mi> <mn>2</mn> </msup> </mrow></mfrac> </msqrt> </mrow> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt">There''s the vertex formula.</mtext> </mrow> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mrow> <mi>x</mi> </mrow> <mo>=</mo> <mfrac> <mrow> <mo>-</mo> <mi> b</mi> <mo>±</mo><mrow><mo>{</mo><mi>C</mi><mo>}</mo></mrow> <msqrt> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo> - </mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </msqrt></mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> </mrow> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace> <mrow><mtext mathcolor="red" mathsize="10pt"></mtext> </mrow> </mrow> </mtd> </mtr> </mtable>'
]

{ #category : #examples }
CpDomExamplesClientBehavior >> exampleNestedClickEvents [

	<example: 'Nested Click Events' order: 901>

	| outputElement buttonDefs1 buttonDefs2 buttonDefs3 installBlock id |
	
	self clearOutput.
	outputElement := self outputElement.

	buttonDefs1 := {
		'Any button (no modifier)' -> CpAnyClickEvent.
		'Primary button (no modifier)' -> CpPrimaryClickEvent.
		'Primary button with shift' -> (CpPrimaryClickEvent + CpShiftModifier).
		'Any button (no modifier)' -> CpAnyClickEvent.
		'Secondary button (no modifier)' -> CpSecondaryClickEvent.
		'Secondary button (shift, long click)' -> (CpSecondaryClickEvent + CpShiftModifier + CpLongClickModifier).
		'Primary button (no modifier)' -> CpPrimaryClickEvent.
		'Any button (no modifier)' -> CpAnyClickEvent.
	}.

	buttonDefs2 := {
		'Any button (shift modifier)' -> (CpAnyClickEvent + CpShiftModifier).
		'Primary button (no modifier)' -> CpPrimaryClickEvent.
		'Primary button with shift' -> (CpPrimaryClickEvent + CpShiftModifier).
		'Any button (shift modifier)' -> (CpAnyClickEvent + CpShiftModifier).
		'Secondary button (no modifier)' -> CpSecondaryClickEvent.
		'Secondary button (shift, long click)' -> (CpSecondaryClickEvent + CpShiftModifier + CpLongClickModifier).
		'Primary button (no modifier)' -> CpPrimaryClickEvent.
		'Any button (no modifier)' -> CpAnyClickEvent.
	}.

	buttonDefs3 := {
		'Any button (shift modifier)' -> (CpAnyClickEvent + CpShiftModifier).
		'Primary button (no modifier)' -> CpPrimaryClickEvent.
		'Primary button with shift' -> (CpPrimaryClickEvent + CpShiftModifier).
		'Any button (shift modifier)' -> (CpAnyClickEvent + CpShiftModifier).
		'Native button' -> CpClickEvent.
		'Secondary button (no modifier)' -> CpSecondaryClickEvent.
		'Secondary button (shift, long click)' -> (CpSecondaryClickEvent + CpShiftModifier + CpLongClickModifier).
		'Primary button (no modifier)' -> CpPrimaryClickEvent.
		'Native button' -> CpClickEvent.
	}.

	id := 1.
	installBlock := [ :buttonDefs |
		| parent |
		parent := outputElement.
		buttonDefs do: [ :each |
			parent := parent appendChild: ((CpHtmlElement newWithTag: #div)
				styleAt: #width put: '80%' ;
				styleAt: #'margin-left' put: '10%' ;
				styleAt: #'min-height' put: '2em' ;
				styleAt: #'border-radius' put: '1em' ;
				styleAt: #'background-color' put: 'rgba(0, 0, 255, .2)' ;
				styleAt: #color put: #white ;
				styleAt: #cursor put: #pointer ;
				styleAt: #'text-align' put: #center ;
				styleAt: #'line-height' put: '2em' ;
				styleAt: #'user-select' put: #none ;
				styleAt: #'-webkit-user-select' put: #none ;
				id: 'div', id printString ; 
				appendChild: ((CpHtmlElement newWithTag: #span)
					styleAt: #display put: #'inline-block' ;	"Make it transformable for shake animation"
					id: 'span', id printString ; 
					textContent: each key ;
					yourself) ;
				appendChild: (' Stop propagation: ' asHtmlElement) ;
				appendChild: ((CpHtmlElement newWithTag: #input)
					attributeAt: #type put: #checkbox ;
					yourself) ;
				when: each value send: #shakeLabelOnEvent: to: self ;
				yourself).
			id := id + 1 ].
		outputElement appendChild: (CpHtmlElement newWithTag: #p).	"Make some room" ].

	installBlock value: buttonDefs1.
	installBlock value: buttonDefs2.
	installBlock value: buttonDefs3.

]

{ #category : #examples }
CpDomExamplesClientBehavior >> exampleSVGGears [

	<example: 'SVG Gears (animated)' order: 210>

	| outputElement svgElement middleElement topElement leftElement rightElement x y speed |
	
	self clearOutput.
	outputElement := self outputElement.

	"Add speed decrease/increase buttons"
	speed := 5.
	outputElement appendChild: ((CpHtmlElement newWithTag: #button)
		textContent: '-' ;
		when: CpPrimaryClickEvent do: [ speed := speed + 1 ] ;
		yourself).
	outputElement appendChild: ((CpHtmlElement newWithTag: #button)
		textContent: '+' ;
		when: CpPrimaryClickEvent do: [ speed := (speed - 1) max: 2 ] ;
		yourself).
	outputElement appendChild: (CpHtmlElement newWithTag: #p). "Separator"

	"Content is created through DOM manipulation instead of markup."
	"Compare this with #exampleMathFormula"
	svgElement := outputElement appendChild: ((CpSvgElement newWithTag: #svg)
		attributeAt: #viewBox put: '0 0 500 500' ;
		attributeAt: #width put: '500px' ;
		attributeAt: #height put: '500px' ;
		yourself).

	x := (2 * Float pi / 3) sin.
	y := (2 * Float pi / 3) cos.

	svgElement appendChild: ((CpSvgElement newWithTag: #g)
		attributeAt: #transform put: 'translate(250,250)scale(.55)' ;
		appendChild: ((CpSvgElement newWithTag: #g)
			appendChild: (middleElement := (CpSvgElement newWithTag: #path)
				attributeAt: #d put: (self class gearPathForRaduis: 80 teeth: 16 asAnnulus: false) ;
				attributeAt: #fill put: '#ff0000' ;
				yourself) ;
			yourself) ;

		appendChild: ((CpSvgElement newWithTag: #g)
			attributeAt: #transform put: 'translate(0,-240)' ;
			appendChild: (topElement := (CpSvgElement newWithTag: #path)
				attributeAt: #d put: (self class gearPathForRaduis: 160 teeth: 32 asAnnulus: false) ;
				attributeAt: #fill put: '#0000ff' ;
				yourself) ;
			yourself) ;

		appendChild: ((CpSvgElement newWithTag: #g)
			attributeAt: #transform put: 'translate(', (-240 * x) printString, ',', (-240 * y) printString, ')' ;
			appendChild: (leftElement := (CpSvgElement newWithTag: #path)
				attributeAt: #d put: (self class gearPathForRaduis: 160 teeth: 32 asAnnulus: false) ;
				attributeAt: #fill put: '#00ffff' ;
				yourself) ;
			yourself) ;

		appendChild: ((CpSvgElement newWithTag: #g)
			attributeAt: #transform put: 'translate(', (240 * x) printString, ',', (-240 * y) printString, ')' ;
			appendChild: (rightElement := (CpSvgElement newWithTag: #path)
				attributeAt: #d put: (self class gearPathForRaduis: 160 teeth: 32 asAnnulus: false) ;
				attributeAt: #fill put: '#ff00ff' ;
				yourself) ;
			yourself) ;
	
		yourself).

	(transition := CpTransition onBlock: [ :p :t |
		| transform1 transform2 |
		transform1 := 'rotate(', (t / speed) printString, ')'.
		transform2 := 'rotate(', (t / (-2 * speed)) printString, ')'.
		middleElement attributeAt: #transform put: transform1.
		topElement attributeAt: #transform put: transform2.
		leftElement attributeAt: #transform put: transform2.
		rightElement attributeAt: #transform put: transform2 ])
			duration: Float infinity ;
			startDelayedBy: 1000
]

{ #category : #examples }
CpDomExamplesClientBehavior >> exampleSVGSimple [

	<example: 'Simple SVG' order: 200>

	| outputElement svgElement |
	
	self clearOutput.
	outputElement := self outputElement.

	"Content is created through DOM manipulation instead of markup."
	"Compare this with #exampleMathFormula"
	svgElement := outputElement appendChild: ((CpSvgElement newWithTag: #svg)
		attributeAt: #viewBox put: '0 0 250 250' ;
		attributeAt: #width put: '250px' ;
		attributeAt: #height put: '250px' ;
		yourself).
	svgElement appendChild: ((CpSvgElement newWithTag: #rect)
		attributeAt: #x put: '50' ;
		attributeAt: #y put: '50' ;
		attributeAt: #width put: '150' ;
		attributeAt: #height put: '150' ;
		attributeAt: #transform put: 'rotate(10 125 125)' ;
		attributeAt: #stroke put: 'green' ;
		attributeAt: #'stroke-width' put: '5' ;
		attributeAt: #fill put: 'grey' ;
		yourself).
	svgElement appendChild: ((CpSvgElement newWithTag: #circle)
		attributeAt: #cx put: '200' ;
		attributeAt: #cy put: '200' ;
		attributeAt: #r put: '45' ;
		attributeAt: #stroke put: 'yellow' ;
		attributeAt: #'stroke-width' put: '3' ;
		attributeAt: #fill put: 'blue' ;
		yourself).
	svgElement appendChild: ((CpSvgElement newWithTag: #path)
		attributeAt: #d put: 'M 10,30 A 20,20 0,0,1 50,30 A 20,20 0,0,1 90,30 Q 90,60 50,90 Q 10,60 10,30 z' ;
		attributeAt: #fill put: 'red' ;
		yourself).
]

{ #category : #examples }
CpDomExamplesClientBehavior >> exampleToDo [

	<example: 'ToDo List' order: 1000>

	| outputElement listElement |
	
	self clearOutput.
	outputElement := self outputElement.

	outputElement appendChild: ((CpHtmlElement newWithTag: #h1)
		textContent: 'ToDo List' ;
		yourself).
	listElement := outputElement appendChild: (CpHtmlElement newWithTag: #ul).

	{
		'Add real debugging options to ClientEnvironment' .
		'Add better event handling to ClientEnvironment' .
		'Allow full keyboard input to ClientEnvironment' .
		'Add (full) set of WebComponents and Views' .
		'Add better session management to ServerEnvironment' .
		'Add Fraction and ScaledDecimal to ClientEnvironment' .
		'Add Date and Time classes to ClientEnvironment' .
		'Add animation capabilities to ClientEnvironment' .
		'Document' .
		'Test test test' .
		'Add more examples' .
		'And so much more...'
	} do: [ :each | listElement appendChild: ((CpHtmlElement newWithTag: #li)
		textContent: each ;
		yourself) ]
]

{ #category : #initialization }
CpDomExamplesClientBehavior >> initialize [

	super initialize.

	CpTransition beLoaded.

	self showIndex
]

{ #category : #accessing }
CpDomExamplesClientBehavior >> outputElement [

	^ CpHtmlElement documentBody firstDescendantMatching: '#output'
]

{ #category : #'event handling' }
CpDomExamplesClientBehavior >> shakeLabelOnEvent: aClickEvent [

	(aClickEvent target tagName = #input)
		ifTrue: [ ^ self ].

	((aClickEvent currentTarget firstDescendantMatching: #input) propertyAt: #checked)
		ifTrue: [ aClickEvent stopPropagation ].

	(aClickEvent currentTarget firstDescendantMatching: #span)
		animate: CpCssAnimation shakeKeyframes duration: 750
]

{ #category : #examples }
CpDomExamplesClientBehavior >> showIndex [

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
			#menu li { 
				cursor: pointer;
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
		' ;
		yourself).
	body := CpHtmlElement documentBody.
	body markupContent: '<h1>DOM Examples</h1>
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
				
		list appendChild: ((CpHtmlElement newWithTag: 'li')
			id: item key ;	"ie selector"
			textContent: item value first ;	"ie title"
			when: CpClickEvent send: item key to: self ;
			yourself) ]
]

{ #category : #accessing }
CpDomExamplesClientBehavior >> showText: textString in: selectorString [

	textRegistry at: selectorString ifPresent: [ :textTransition | textTransition finish ].

	(self outputElement firstDescendantMatching: selectorString)
		ifNotNil: [ :element |
			element textContent: textString.
			textRegistry at: selectorString put: ([ element textContent: '' ] asTransition
				duration: 0 ;
				startDelayedBy: 1000) ]
]

{ #category : #'event handling' }
CpDomExamplesClientBehavior >> wiggleOnEvent: aClickEvent [

	aClickEvent currentTarget
		animate: CpCssAnimation tadaKeyframes duration: 750
]
