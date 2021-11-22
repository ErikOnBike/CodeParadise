Class {
	#name : #SlIcon,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #'class initialization' }
SlIcon class >> loadComponent [

	"Fix to allow icons to be loaded correctly.
	See https://github.com/shoelace-style/shoelace/issues/569"

	self flag: #TODO. "See comment above"

	super loadComponent.

	CpHtmlElement documentHead
		appendChild:
			((CpHtmlElement newWithTag: #script)
				attributeAt: #type put: 'module' ;
				textContent: 'import { setBasePath } from "', self importBasePath, 'utilities/base-path.js";setBasePath("', self importBasePath, '");' ;
				yourself)
]

{ #category : #accessing }
SlIcon class >> name: aString [

	^ self new
		name: aString ;
		yourself
]

{ #category : #accessing }
SlIcon >> library [

	^ self propertyAt: #library
]

{ #category : #accessing }
SlIcon >> library: aString [

	self propertyAt: #library put: aString
]

{ #category : #accessing }
SlIcon >> name [

	^ self propertyAt: #name
]

{ #category : #accessing }
SlIcon >> name: aString [

	self propertyAt: #name put: aString
]

{ #category : #accessing }
SlIcon >> src [

	^ self propertyAt: #src
]

{ #category : #accessing }
SlIcon >> src: aString [

	self propertyAt: #src put: aString
]
