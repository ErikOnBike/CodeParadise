Class {
	#name : #CpVariableView,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'variable'
	],
	#category : #'CodeParadise-WebApplication-Debugger-View'
}

{ #category : #'web resources' }
CpVariableView class >> style [

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
		display: inline-flex;
		width: 100%;
	}
	:host(.selected) #container {
		background-color: rgba(0, 0, 255, .3);
	}
	#key {
		width: 15em;
		flex-shrink: 0;
	}
	#class {
		width: 15em;
		flex-shrink: 0;
		overflow: hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
	}
	#value {
		overflow: hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
	}'
]

{ #category : #'web resources' }
CpVariableView class >> template [

	<webResource: #html>

	^ '<div id="container">
		<div id="key"><slot name="key"></slot></div>
		<div id="class"><slot name="class"></slot></div>
		<div id="value"><slot name="value"></slot></div>
	</div>'
]

{ #category : #rendering }
CpVariableView >> beSelected: aBoolean [

	self classed: #selected if: aBoolean
]

{ #category : #rendering }
CpVariableView >> render [

	[
		self
			replaceAllChildrenWith: variable key asString asHtmlElement atSlotNamed: #key ;
			replaceAllChildrenWith: variable value class printString asHtmlElement atSlotNamed: #class ;
			replaceAllChildrenWith: variable value printString asHtmlElement atSlotNamed: #value
	] on: Error do: [ :error | self crError: 'Error in debugger context variable: ', error printString ]
]

{ #category : #accessing }
CpVariableView >> variable [

	^ variable
]

{ #category : #accessing }
CpVariableView >> variable: anAssociation [

	variable := anAssociation
]
