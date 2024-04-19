Class {
	#name : #CpExceptionView,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'exception'
	],
	#category : #'CodeParadise-WebApplication-Debugger-View'
}

{ #category : #'web resources' }
CpExceptionView class >> style [

	<webResource: #css>

	^ '*, *:before, *:after {
		-moz-box-sizing: border-box;
		-webkit-box-sizing: border-box;
		box-sizing: border-box;
	}
	:host {
		display: block;
		height: 100%;
	}
	#label {
		font-weight: bold;
	}'
]

{ #category : #'web resources' }
CpExceptionView class >> template [

	<webResource: #html>

	^ '<div id="container">
		<div id="label">Exception:</div>
		<div id="message"><slot name="message"></slot></div>
	</div>'
]

{ #category : #accessing }
CpExceptionView >> exception [

	^ exception
]

{ #category : #accessing }
CpExceptionView >> exception: anException [

	exception := anException
]

{ #category : #rendering }
CpExceptionView >> render [

	[
		self replaceAllChildrenWith: exception description asHtmlElement atSlotNamed: #message
	] on: Error do: [ :error | self errorCr: 'Error in the debugger exception: ', error printString ]
]
