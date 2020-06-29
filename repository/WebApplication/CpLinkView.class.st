Class {
	#name : #CpLinkView,
	#superclass : #CpView,
	#category : #'WebApplication-Components'
}

{ #category : #'web resources' }
CpLinkView class >> style [

	<webResource: #css>

	^ ':host {
			display: inline-block;
			position: relative;
			outline: none;
			white-space: nowrap;
			font-size: .8rem;
		}
	
		#container {
			display: inline-flex;
			width: 100%;
			height: 100%;
			min-height: inherit;
			color: var(--link-text-color);
			background-color: var(--link-background-color);
			cursor: pointer;
		}
	
		#container:hover {
			text-decoration: underline;
			color: var(--link-hovered-text-color);
			background-color: var(--link-hovered-background-color);
		}

		#container:active {
			color: var(--link-activated-text-color);
			background-color: var(--link-activated-background-color);
		}'
]

{ #category : #'web resources' }
CpLinkView class >> template [

	<webResource: #html>

	^ '<div id="container"><slot></slot></div>'
]

{ #category : #'event handling' }
CpLinkView >> handleClickEvent: aClickEvent [

	self announce: aClickEvent asAnnouncement
]
