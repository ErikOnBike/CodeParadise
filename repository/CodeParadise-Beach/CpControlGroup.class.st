Class {
	#name : #CpControlGroup,
	#superclass : #CpControl,
	#category : #'CodeParadise-Beach-Components'
}

{ #category : #'web resources' }
CpControlGroup class >> style [

	<webResource: #css>

	^ '*, *:before, *:after {
			-moz-box-sizing: border-box;
			-webkit-box-sizing: border-box;
			box-sizing: border-box;
		}'
]

{ #category : #'web resources' }
CpControlGroup class >> template [

	<webResource: #html>

	^ '<slot></slot>'
]

{ #category : #'adding/removing' }
CpControlGroup >> appendChild: anElement [

	"Append group element to the receiver"

	"If receiver is disabled make group member also (secundary) disabled"
	(self attributeAt: #disabled)
		ifNotNil: [ anElement disableSecundary ].

	^ super appendChild: anElement
]

{ #category : #'adding/removing' }
CpControlGroup >> insertChild: childElement before: siblingElement [

	"Insert group member before the specified sibling into the receiver"

	"If receiver is disabled make group member also (secundary) disabled"
	(self attributeAt: #disabled)
		ifNotNil: [ childElement disableSecundary ].

	^ super insertChild: childElement before: siblingElement
]

{ #category : #'adding/removing' }
CpControlGroup >> replaceChild: childElement with: replacementElement [

	"Replace the specified existing group member with specified replacement"

	"If receiver is disabled make group member also (secundary) disabled"
	(self attributeAt: #disabled)
		ifNotNil: [ replacementElement disableSecundary ].

	^ super replaceChild: childElement with: replacementElement
]
