Class {
	#name : #CpPMCursor,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'lastUpdateTick',
		'startFlutterTick',
		'lowerFlagTransition'
	],
	#category : #'CodeParadise-WebApplication-ProseMirror-View'
}

{ #category : #'web resources' }
CpPMCursor class >> style [

	<webResource: #css>

	^'*, *:before, *:after {
		-moz-box-sizing: border-box;
		-webkit-box-sizing: border-box;
		box-sizing: border-box;
	}
	:host {
		display: inline;
	}
	#container {
		position: relative;
		display: inline;
	}
	#pointer {
		position: absolute;
		top: 0;
		left: -1px;
		width: 2px;
		height: 1em;
		background-color: rgba(255, 0, 0, .5);
	}
	#flag {
		position: absolute;
		display: block;
		left: -2px;
		bottom: 100%;
		max-width: 0;
		max-height: 0;
		border: 3px solid #f00;
		border-radius: 3px;
		background-color: rgba(255, 0, 0, .5);
		color: #fff;
		font-size: .8rem;
		text-overflow: ellipsis;
		white-space: nowrap;
		overflow: hidden;

		transition: max-width 1s, max-height 1s;
	}
	:host(.show-below) #flag {
		top: -6px;
		bottom: auto;
	}
	:host(.show-left) #flag {
		text-align: right;
		right: -2px;
		left: auto;
	}
	:host(.flutter) #flag {
		max-width: 20em;
		max-height: 10em;
	}
	#flag:hover {
		max-width: 20em;
		max-height: 10em;
	}'
]

{ #category : #'web resources' }
CpPMCursor class >> template [

	<webResource: #html>

	^ '<div id="container"><div id="pointer"><div id="flag">Joost Jansen</div></div></div>'
]

{ #category : #accessing }
CpPMCursor >> editor [

	^ self firstAncestorMatching: '.ProseMirror.editor'
]

{ #category : #rendering }
CpPMCursor >> lowerFlag [

	"Hide the flag"

	"Stop fluttering the flag"
	self removeClass: #flutter.

	"Stop any pending 'lower the flag transition'"
	self stopLowerFlagTransition
]

{ #category : #constants }
CpPMCursor >> lowerFlagAfterStartDelay [

	"Answer the time (in milliseconds) before hiding the flag after it is initially shown"

	^ 5000
]

{ #category : #constants }
CpPMCursor >> lowerFlagDelay [

	"Answer the time (in milliseconds) before hiding the flag after it is updated"

	^ 3000
]

{ #category : #rendering }
CpPMCursor >> raiseFlag [

	"Show the flag"

	"Prevent any 'lower the flag transition' from executing shortly after this"
	self stopLowerFlagTransition.

	"Position the flag (below the pole) when the cursor is on the top part
	and to the left if on the right part"
	self editor
		ifNotNil: [ :editor |
			((self propertyAt: #offsetTop) - 30) < (editor propertyAt: #scrollTop)
				ifTrue: [ self addClass: #'show-below' ]
				ifFalse: [ self removeClass: #'show-below' ].
			((self propertyAt: #offsetLeft) + 150) > (editor propertyAt: #clientWidth)
				ifTrue: [ self addClass: #'show-left' ]
				ifFalse: [ self removeClass: #'show-left' ] ]
		ifNil: [ self removeClasses: #(#'show-below' #'show-left') ].

	"Start fluttering that flag"
	self addClass: #flutter
]

{ #category : #rendering }
CpPMCursor >> startLowerFlagTransitionAfter: anInteger [

	"Start the lower flag transition after the specified time (in milliseconds)"

	"Just a precaution"
	self stopLowerFlagTransition.

	lowerFlagTransition := [ self lowerFlag ] asTransition
		startDelayedBy: anInteger ;
		yourself
]

{ #category : #rendering }
CpPMCursor >> stopLowerFlagTransition [

	"Stop the lower flag transition (without performing its lowering action)"

	lowerFlagTransition ifNotNil: [
		lowerFlagTransition stop.
		lowerFlagTransition := nil ]
]

{ #category : #rendering }
CpPMCursor >> update [

	"Update the receiver (raise/lower flag)"

	| tickCount |

	"Handle new cursor (raise flag)"
	lastUpdateTick ifNil: [ ^ self updateNewCursor ].

	"Ignore recently added cursor (do not update flag)"
	tickCount := CpTransition tickCount.
	(startFlutterTick + self lowerFlagAfterStartDelay) > tickCount
		ifTrue: [ ^ self updateIgnore ].

	"Ignore recently updated cursor (do not update again)"
	lastUpdateTick + self updateInactivityDelay > tickCount
		ifTrue: [ ^ self updateIgnore ].

	self updateNewActivity
]

{ #category : #rendering }
CpPMCursor >> updateIgnore [

	"The receiver has been updated, but nothing has to be done about the flag"

	lastUpdateTick := CpTransition tickCount
]

{ #category : #constants }
CpPMCursor >> updateInactivityDelay [

	"Answer the time (in milliseconds) of inactivity before raising the flag again
	(to remind user who's who) after it was updated"

	^ 8000
]

{ #category : #rendering }
CpPMCursor >> updateNewActivity [

	"The receiver has become active again after some time, let's raise the flag"

	lastUpdateTick := CpTransition tickCount.

	self raiseFlag.

	"Lower the flag after some preset delay"
	self startLowerFlagTransitionAfter: self lowerFlagDelay
]

{ #category : #rendering }
CpPMCursor >> updateNewCursor [

	"The receiver has just arrived, let's raise the flag"

	lastUpdateTick := startFlutterTick := CpTransition tickCount.

	self raiseFlag.

	"Lower the flag after some preset delay"
	self startLowerFlagTransitionAfter: self lowerFlagAfterStartDelay
]
