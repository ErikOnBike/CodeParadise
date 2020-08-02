Class {
	#name : #FuiButton,
	#superclass : #FuiElement,
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #'web resources' }
FuiButton class >> template [

	<webResource: #html>

	^ '<button class="ui button"><slot></slot></button>'
]

{ #category : #accessing }
FuiButton class >> type [

	"Buttons do not have a type"

	^ nil
]

{ #category : #'accessing - state' }
FuiButton >> beLoaded [

	^ self shadowElement removeClass: #loading
]

{ #category : #'accessing - state' }
FuiButton >> beLoading [

	^ self shadowElement addClass: #loading
]

{ #category : #'accessing - state' }
FuiButton >> disable [

	^ self shadowElement addClass: #disabled
]

{ #category : #'accessing - state' }
FuiButton >> enable [

	^ self shadowElement removeClass: #disabled
]

{ #category : #'event handling' }
FuiButton >> handleClickEvent: aClickEvent [

	"Announce the fact that receiver has been clicked"

	self announce: aClickEvent asAnnouncement
]
