Class {
	#name : #CpContextLineView,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'context',
		'currentVariable'
	],
	#category : #'CodeParadise-WebApplication-Debugger-View'
}

{ #category : #'web resources' }
CpContextLineView class >> style [

	<webResource: #css>

	^ '*, *:before, *:after {
		-moz-box-sizing: border-box;
		-webkit-box-sizing: border-box;
		box-sizing: border-box;
	}
	:host {
		display: block;
	}
	#container {
		padding-top: 2px;
	}
	:host(.selected) #container {
		background-color: rgba(0, 0, 255, .3);
	}'
]

{ #category : #'web resources' }
CpContextLineView class >> template [

	<webResource: #html>

	^ '<div id="container">
		<span id="class"><slot name="class"></slot></span><span> &gt;&gt; </span><span id="method"><slot name="method"></slot></span>
	</div>'
]

{ #category : #rendering }
CpContextLineView >> beSelected: aBoolean [

	self classed: #selected if: aBoolean
]

{ #category : #accessing }
CpContextLineView >> context [

	^ context
]

{ #category : #accessing }
CpContextLineView >> context: aContext [

	context := aContext
]

{ #category : #rendering }
CpContextLineView >> render [

	| compiledCode className selector |

	[
		"Distinguish between CompiledMethod and CompiledBlock"
		compiledCode := context method.
		className := compiledCode methodClass name.
		selector := String streamContents: [ :stream |
			compiledCode isCompiledMethod
				ifFalse: [ stream nextPutAll: '[] in ' ].
			compiledCode selector
				ifNotNil: [ :selectorSymbol |
					stream
						nextPut: $# ;
						nextPutAll: selectorSymbol ]
				ifNil: [ stream nextPutAll: '<unnamed method>' ] ].

		self
			replaceAllChildrenWith: className asHtmlElement atSlotNamed: #class ;
			replaceAllChildrenWith: selector asHtmlElement atSlotNamed: #method
	] on: Error do: [ :error | self errorCr: 'Error in the debugger context line: ', error printString ]
]
