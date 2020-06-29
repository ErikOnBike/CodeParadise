Class {
	#name : #CpButtonView,
	#superclass : #CpView,
	#category : #'WebApplication-Components'
}

{ #category : #'web resources' }
CpButtonView class >> style [

	<webResource: #css>

	^ ':host {
			display: inline-block;
			position: relative;
			outline: none;
			white-space: nowrap;
			font-size: .8rem;
		}

		/* Ensure the button is always aligned on the baseline */
		#container::before {
			content: "\2003";
			display: inline-block;
			width: 0;
		}

		#container {
			display: inline-flex;
			width: 100%;
			height: 100%;
			min-height: inherit;
			padding: .25rem;
			border-radius: .25rem;
			align-items: center;
			justify-content: center;
			text-align: center;
			color: var(--control-text-color);
			background-color: var(--control-background-color);
			cursor: pointer;
			-webkit-user-select: none;
			-moz-user-select: none;
			user-select: none;
		}

		#container:hover {
			color: var(--control-hovered-text-color); 
			background-color: var(--control-hover-background-color);
		}

		#container:active {
			color: var(--control-activated-text-color);
			background-color: var(--control-activated-background-color);
		}

		#prefix,
		#suffix {
			flex: none;
		}

		#label {
			white-space: nowrap;
			overflow: hidden;
			text-overflow: ellipsis;
		}'
]

{ #category : #'web resources' }
CpButtonView class >> template [

	<webResource: #html>

	^ '<div id="container">
			<div id="prefix">
				<slot name="prefix"></slot>
			</div>
			<div id="label">
				<slot></slot>
			</div>
			<div id="suffix">
				<slot name="suffix"></slot>
			</div>
		</div>'
]

{ #category : #'event handling' }
CpButtonView >> handleClickEvent: aClickEvent [

	self announce: aClickEvent asAnnouncement
]
