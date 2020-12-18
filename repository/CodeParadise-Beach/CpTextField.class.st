Class {
	#name : #CpTextField,
	#superclass : #CpView,
	#instVars : [
		'text'
	],
	#category : #'CodeParadise-Beach-Components'
}

{ #category : #'web resources' }
CpTextField class >> style [

	<webResource: #css>

	^ '#container {
			display: inline-block;
			width: 100%;
			height: 100%;
			min-height: inherit;
			overflow: hidden;
		}
		#container input {
			margin: 0;
			border-radius: .25rem;
			border: 1px solid #333;
			padding: 3px;
			font-size: 1em;
		}
		#container input:focus {
			outline: none;
		}'
]

{ #category : #'web resources' }
CpTextField class >> template [

	<webResource: #html>

	^ '<div id="container"><input type="text"></div>'
]

{ #category : #accessing }
CpTextField >> text [

	^ (self shadowRoot firstDescendantMatching: 'input') propertyAt: #value
]

{ #category : #accessing }
CpTextField >> text: aString [

	(self shadowRoot firstDescendantMatching: 'input') propertyAt: #value put: aString
]
