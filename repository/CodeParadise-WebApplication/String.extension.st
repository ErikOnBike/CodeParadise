Extension { #name : #String }

{ #category : #'*CodeParadise-WebApplication' }
String >> asHtmlElement [

	<webApplicationExtension>

	^ self inHtmlTag: #span
]

{ #category : #'*CodeParadise-WebApplication' }
String >> asMaterialIcon [

	<webApplicationMaterialDesignExtension>

	^ ((Smalltalk classNamed: #CpHtmlElement) newWithTag: #i)
		attributeAt: #class put: 'material-icons' ;
		textContent: self ;
		yourself
]

{ #category : #'*CodeParadise-WebApplication' }
String >> asRegularFontAwesomeIcon [

	<webApplicationFontAwesomeExtension>

	^ ((Smalltalk classNamed: #CpHtmlElement) newWithTag: #i)
		attributeAt: #class put: 'far fa-', self
]

{ #category : #'*CodeParadise-WebApplication' }
String >> asSolidFontAwesomeIcon [

	<webApplicationFontAwesomeExtension>

	^ ((Smalltalk classNamed: #CpHtmlElement) newWithTag: #i)
		attributeAt: #class put: 'fas fa-', self
]

{ #category : #'*CodeParadise-WebApplication' }
String >> inHtmlTag: tagString [

	<webApplicationExtension>

	^ ((Smalltalk classNamed: #CpHtmlElement) newWithTag: tagString)
		textContent: self ;
		yourself
]
