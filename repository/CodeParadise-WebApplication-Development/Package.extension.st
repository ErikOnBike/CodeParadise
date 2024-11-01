Extension { #name : #Package }

{ #category : #'*CodeParadise-WebApplication-Development' }
Package >> codeParadiseWebApplicationDevelopmentSupport [

	"Marker to indicate this package is a development support package"

	<developmentSupport>
]

{ #category : #'*CodeParadise-WebApplication-Development' }
Package >> isDevelopmentSupport [

	"Answer whether the receiver contains development support classes.

	Implementation:
	To mark a package as development support package, add an extension method
	to the receiver containing the pragma <developmentSupport>.
	To prevent name clashing use a method name resembling the package name."

	^ (self extensionMethodsForClass: Package) anySatisfy: [ :each |
		each hasPragmaNamed: #developmentSupport ]
]
