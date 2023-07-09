Class {
	#name : #CpInspectorView,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'object',
		'fields',
		'objects'
	],
	#category : #'CodeParadise-WebApplication-Debugger-View'
}

{ #category : #'web resources' }
CpInspectorView class >> style [

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
	#container {
		height: 100%;
	}
	#objects {
		padding-bottom: 4px;
		overflow-x: scroll;
	}
	#objects slot {
		display: inline-block;
		white-space: nowrap;
	}
	::slotted(sl-button) {
		width: 15em;
		margin-right: 4px;
	}
	#fields {
		height: 100%;
		overflow-y: scroll;
	}
	#fields slot {
		display: block;
		height: 100%;
		overflow-y: scroll;
	}
	::slotted(cp-variable:hover) {
		background-color: rgba(0, 0, 0, .05);
		cursor: pointer;
	}'
]

{ #category : #'web resources' }
CpInspectorView class >> template [

	<webResource: #html>

	^ '<div id="container">
		<div id="objects"><slot name="objects"></slot></div>
		<div id="fields"><slot name="fields"></slot></div>
	</div>'
]

{ #category : #private }
CpInspectorView >> createFields [

	"Create the collection of fields (Associations) for the receiver's object"

	| class instNames startIndex |

	fields := OrderedCollection new.

	"Add named fields"
	class := object class.
	instNames := class allInstVarNames.
	1 to: class instSize do: [ :index |
		fields add: (instNames at: index) -> (object instVarAt: index) ].

	"Add variable fields"
	class isVariable
		ifTrue: [
			startIndex := (object isCompiledBlock or: [ object isCompiledMethod ])
				ifTrue: [ object initialPC ]
				ifFalse: [ 1 ].
			startIndex to: object basicSize do: [ :index | fields add: index -> (object basicAt: index) ] ]
]

{ #category : #accessing }
CpInspectorView >> object [

	^ object
]

{ #category : #accessing }
CpInspectorView >> object: anObject [

	object := anObject.
	objects := OrderedCollection with: object
]

{ #category : #rendering }
CpInspectorView >> render [

	self
		removeChildrenAtSlotNamed: #objects ;
		removeChildrenAtSlotNamed: #fields.

	"Create fields collection"
	self createFields.

	"Rander objects"
	objects do: [ :each | self renderObject: each ].
	(self childrenAtSlotNamed: #objects)
		ifNotEmpty: [ :objectElements |
			objectElements last
				bePrimary ;
				apply: #scrollIntoView withArguments: { #behavior -> #smooth } ].

	"Render fields or show 'nil'"
	object
		ifNotNil: [
			fields
				ifNotEmpty: [ fields do: [ :each | self renderField: each ] ]
				ifEmpty: [ self appendChild: '<no fields>' asHtmlElement atSlotNamed: #fields ] ]
		ifNil: [ self appendChild: 'nil' asHtmlElement atSlotNamed: #fields ]
]

{ #category : #rendering }
CpInspectorView >> renderField: anAssociation [

	(self appendChild: CpVariableView new atSlotNamed: #fields)
		variable: anAssociation ;
		when: CpClickEvent basicPrimary send: #updateObject: to: self ;
		render
]

{ #category : #rendering }
CpInspectorView >> renderObject: anObject [

	| button |
	
	button := ((SlButton new)
		textContent: anObject printString ;
		beSmall ;
		when: CpClickEvent basicPrimary send: #updateObjects: to: self ;
		yourself). 

	self appendChild: button atSlotNamed: #objects
]

{ #category : #'event handling' }
CpInspectorView >> updateObject: aClickEvent [

	"A field is selected, add its value as a new object"

	| index buttonClicked |

	buttonClicked := aClickEvent currentTarget.
	index := (self childrenAtSlotNamed: #fields) findFirst: [ :each | each == buttonClicked ].

	"Sanity check if a correct field is selected"
	(index = 0 or: [ index > fields size ])
		ifTrue: [ ^ self ].

	"Add the object and (re)render"
	objects add: (fields at: index) value.
	object := objects last.
	self render
]

{ #category : #'event handling' }
CpInspectorView >> updateObjects: aClickEvent [

	"A button in the buttons list has been clicked, update the receiver"

	| index buttonClicked |

	buttonClicked := aClickEvent currentTarget.
	index := (self childrenAtSlotNamed: #objects) findFirst: [ :each | each == buttonClicked ].

	"Sanity check if the correct object is selected and not interested if last object is selected
	(which does not change the UI)."
	(index = 0 or: [ index == objects size ])
		ifTrue: [ ^ self ].

	"Use removeLast since it will not recreate a collection"
	[ index < objects size ] whileTrue: [
		objects removeLast ].

	"Set the current object and (re)render"
	object := objects last.
	self render
]
