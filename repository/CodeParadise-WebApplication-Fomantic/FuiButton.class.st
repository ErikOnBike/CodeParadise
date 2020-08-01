Class {
	#name : #FuiButton,
	#superclass : #FuiElement,
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #'web resources' }
FuiButton class >> style [

	<webResource: #css>

	^ '@import "https://cdn.jsdelivr.net/npm/fomantic-ui@2.8.6/dist/semantic.min.css";'
]

{ #category : #'web resources' }
FuiButton class >> template [

	<webResource: #html>

	^ '<button class="ui button"><slot></slot></button>'
]

{ #category : #protocol }
FuiButton >> beLoaded [

	^ self shadowElement removeClass: #loading
]

{ #category : #protocol }
FuiButton >> beLoading [

	^ self shadowElement addClass: #loading
]

{ #category : #protocol }
FuiButton >> disable [

	^ self shadowElement addClass: #disabled
]

{ #category : #protocol }
FuiButton >> enable [

	^ self shadowElement removeClass: #disabled
]

{ #category : #'event handling' }
FuiButton >> handleClickEvent: aClickEvent [

	"Announce the fact that receiver has been clicked"

	self announce: aClickEvent asAnnouncement
]
