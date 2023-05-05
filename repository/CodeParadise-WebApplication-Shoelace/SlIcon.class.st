Class {
	#name : #SlIcon,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #'instance creation' }
SlIcon class >> fontAwesomeNamed: aString [

	^ self new
		beFontAwesome ;
		name: aString ;
		yourself
]

{ #category : #accessing }
SlIcon class >> fullyNamed: aString [

	^ self new
		fullName: aString ;
		yourself
]

{ #category : #'class initialization' }
SlIcon class >> loadComponent [

	"Fix to allow icons to be loaded correctly.
	See https://github.com/shoelace-style/shoelace/issues/569"

	self flag: #TODO. "See comment above"

	super loadComponent.

	CpHtmlElement documentAddModuleScript: 'import { setBasePath } from "', self importBasePath, 'utilities/base-path.js";setBasePath("', self importBasePath, '");'
]

{ #category : #accessing }
SlIcon class >> named: aString [

	^ self new
		name: aString ;
		yourself
]

{ #category : #'instance creation' }
SlIcon class >> newFontAwesome [

	^ self new
		beFontAwesome ;
		yourself
]

{ #category : #'class initialization' }
SlIcon class >> registerFontAwesome [

	"Register Font Awesome as icon library to load icons from CDN"

	CpHtmlElement documentAddModuleScript: self registerFontAwesomeCode
]

{ #category : #'class initialization' }
SlIcon class >> registerFontAwesomeCode [

	^ String streamContents: [ :stream |

		stream
			nextPutAll: 'import { registerIconLibrary } from "' ;
			nextPutAll: self importBasePath ;
			nextPutAll: 'utilities/icon-library.js";' ;

			nextPutAll: 'registerIconLibrary("fa", {' ;
			nextPutAll: '  resolver: function(name) {' ;
			nextPutAll: '    const filename = name.replace(/^fa[rbs]-/, "");' ;
			nextPutAll: '    let folder = name.substring(0, 4) === "fas-" ? "solid" : (name.substring(0, 4) === "fab-" ? "brands" : "regular");' ;
			nextPutAll: '    return `https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.4/svgs/${folder}/${filename}.svg`;' ;
			nextPutAll: '  },' ;
			nextPutAll: '  mutator: function(svg) { svg.setAttribute("fill", "currentColor"); }' ;
			nextPutAll: '});' ]

]

{ #category : #accessing }
SlIcon >> beFontAwesome [

	self library: 'fa'
]

{ #category : #copying }
SlIcon >> clone [

	"Deep clone the receiver.

	Implementation:
	Set the (non reflecting properties explicitly)."

	^ super clone
		name: self name ;
		library: self library ;
		yourself

]

{ #category : #accessing }
SlIcon >> fullName: aString [

	"Set the name and optionally the library for the receiver specified on the given full name.
	The full name should take the form: <library>:<name>
	If no colon ($:) is specified, only the name is assumed."

	| separatorIndex |

	separatorIndex := aString indexOf: $:.
	separatorIndex = 0
		ifTrue: [ self name: aString ]
		ifFalse: [
			self
				library: (aString first: separatorIndex - 1) ;
				name: (aString allButFirst: separatorIndex) ]
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
