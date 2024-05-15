Class {
	#name : 'CpWindowTitle',
	#superclass : 'CpView',
	#category : 'CodeParadise-Beach-Components',
	#package : 'CodeParadise-Beach',
	#tag : 'Components'
}

{ #category : 'web resources' }
CpWindowTitle class >> style [

	<webResource: #css>

	^ '* {
			box-sizing: border-box;
		}
		:host,
		::slotted(*),
		.container {
			pointer-events: none;
			-moz-user-select: none;
			-webkit-user-select: none;
			-ms-user-select: none;
			user-select: none;
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
			vertical-align: top;
		}
		::slotted(cp-icon) {
			display: inline-block;
			width: calc(1.125em + 6px);
			height: calc(1.125em + 6px);
			margin-right: 4px;
		}'
]

{ #category : 'web resources' }
CpWindowTitle class >> template [

	<webResource: #html>

	^ '<div class="container"><slot name="icon"></slot><slot name="title"><span>Untitled</span></slot></div>'

]

{ #category : 'rendering' }
CpWindowTitle >> renderIcon: anIconName [

	self replaceAllChildrenWith: (CpIcon named: anIconName) atSlotNamed: #icon
]

{ #category : 'rendering' }
CpWindowTitle >> renderTitle: aString [

	(aString notNil and: [ aString isNotEmpty ])
		ifTrue: [ self replaceAllChildrenWith: (aString inHtmlTag: #span) atSlotNamed: #title ]
		ifFalse: [ self removeChildrenAtSlotNamed: #title ]
]
