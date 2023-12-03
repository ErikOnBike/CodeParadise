Class {
	#name : #CpImageContentView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Presentation-View'
}

{ #category : #'web resources' }
CpImageContentView class >> style [

	<webResource: #css>

	^ '* {
			box-sizing: border-box;
		}
		:host {
			display: inline-block;
			width: 100%;
		}'
]

{ #category : #'web resources' }
CpImageContentView class >> template [

	<webResource: #html>

	^ '<div id="container">
			<slot></slot>
		</div>'
]

{ #category : #rendering }
CpImageContentView >> renderImage: stringUrl [

	| image |

	image := (self firstDescendantMatching: #img)
		ifNil: [ self appendChild: (CpHtmlElement newWithTag: #img) ].

	image attributeAt: #src put: stringUrl
]

{ #category : #rendering }
CpImageContentView >> renderImage: stringUrl width: widthString height: heightString [

	self renderImage: stringUrl.

	(self firstDescendantMatching: #img)
		styleAt: #width put: widthString ;
		styleAt: #height put: heightString
]
