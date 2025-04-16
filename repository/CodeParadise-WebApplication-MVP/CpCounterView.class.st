"
I am a View for a Counter Model.
"
Class {
	#name : #CpCounterView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-MVP-Examples'
}

{ #category : #'web resources' }
CpCounterView class >> style [

	<webResource: #css>

	^'.button {
		display: inline-block;
		width: 3em;
		text-align: center;
		border: 1px solid rgb(60, 60, 60);
		border-radius: .2em;
		box-shadow: .3em .3em .3em rgba(200, 200, 200, .5);
		-webkit-user-select: none;
		background-color: rgba(0, 0, 255, .3);
		user-select: none;
		cursor: pointer;
	}
	.button:active {
		transform: translate(.1em, .1em);
		box-shadow: .1em .1em .1em rgba(150, 150, 150, .6);
	}
	.counter {
		display: inline-block;
		width: 2em;
		text-wrap: none;
		overflow: hidden;
		text-overflow: ellipsis;
		text-align: right;
	}'
]

{ #category : #'web resources' }
CpCounterView class >> template [

	<webResource: #html>

	^ '<div>
		<span id="decrease" class="button">--</span>
		<span class="counter"><slot></slot></span>
		<span id="increase" class="button">++</span>
	</div>'
]

{ #category : #'event handling' }
CpCounterView >> handleDecrease [

	self serverAnnounce: CpCounterDecrease
]

{ #category : #'event handling' }
CpCounterView >> handleIncrease [

	self serverAnnounce: CpCounterIncrease
]

{ #category : #initialization }
CpCounterView >> initializeShadowRoot [

	super initializeShadowRoot.

	(self shadowedElementWithId: #increase)
		when: CpClickEvent basicPrimary send: #handleIncrease to: self.
	(self shadowedElementWithId: #decrease)
		when: CpClickEvent basicPrimary send: #handleDecrease to: self
]

{ #category : #rendering }
CpCounterView >> renderValue: counterValue [

	self textContent: counterValue printString
]
