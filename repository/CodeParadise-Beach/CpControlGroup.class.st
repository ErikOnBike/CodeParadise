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
CpControlGroup >> appendChild: childElement [

	"Append group element to the receiver"

	"If receiver is disabled make group member also (secundary) disabled"
	(self attributeAt: #disabled)
		ifNotNil: [ childElement disableSecondary ].

	^ super appendChild: childElement
]

{ #category : #'adding/removing' }
CpControlGroup >> insertChild: childElement before: siblingElement [

	"Insert group member before the specified sibling into the receiver"

	"If receiver is disabled make group member also (secundary) disabled"
	(self attributeAt: #disabled)
		ifNotNil: [ childElement disableSecondary ].

	^ super insertChild: childElement before: siblingElement
]

{ #category : #'adding/removing' }
CpControlGroup >> replaceChild: childElement with: replacementElement [

	"Replace the specified existing group member with specified replacement"

	"If receiver is disabled make group member also (secundary) disabled"
	(self attributeAt: #disabled)
		ifNotNil: [ replacementElement disableSecondary ].

	^ super replaceChild: childElement with: replacementElement
]
