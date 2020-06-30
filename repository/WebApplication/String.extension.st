Extension { #name : #String }

{ #category : #'*WebApplication' }
String >> asElement [

	<webApplicationExtension>

	^ self inHtmlTag: #span
]

{ #category : #'*WebApplication' }
String >> asMaterialIcon [

	<webApplicationMaterialDesignExtension>

	^ ((Smalltalk classNamed: #CpHtmlElement) newWithTag: #i)
		attributeAt: #class put: 'material-icons' ;
		textContent: self ;
		yourself
]

{ #category : #'*WebApplication' }
String >> asRegularFontAwesomeIcon [

	<webApplicationFontAwesomeExtension>

	^ ((Smalltalk classNamed: #CpHtmlElement) newWithTag: #i)
		attributeAt: #class put: 'far fa-', self
]

{ #category : #'*WebApplication' }
String >> asSolidFontAwesomeIcon [

	<webApplicationFontAwesomeExtension>

	^ ((Smalltalk classNamed: #CpHtmlElement) newWithTag: #i)
		attributeAt: #class put: 'fas fa-', self
]

{ #category : #'*WebApplication' }
String >> inHtmlTag: tagString [

	<webApplicationExtension>

	^ ((Smalltalk classNamed: #CpHtmlElement) newWithTag: tagString)
		textContent: self ;
		yourself
]
