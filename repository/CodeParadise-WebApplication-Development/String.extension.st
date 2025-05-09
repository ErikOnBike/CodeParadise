Extension { #name : #String }

{ #category : #'*CodeParadise-WebApplication-Development' }
String >> refersToLiteral: aSymbol [

	"Answer whether the receiver contains a reference to the specified Symbol.
	This method tests for the specific situation that it is called while searching
	for either a Class reference or a messagge send. It will search in the
	CodeParadise web resource methods (typically in CpTemplateComponent subclass)
	for an appropriate reference. When searching for WebComponent classes this
	means looking whether the appropriate tag name is present."

	<serverEnvironment>

	| sender method |

	"Extension for specific case when we're looking for references in source code"
	((sender := thisContext sender) selector = #refersToLiteral: and: [ (method := sender receiver) isCompiledMethod ])
		ifTrue: [
			aSymbol isSymbol
				ifTrue: [

					"Make distinction between testing for Class and non-class literals (both represented by Symbols)"
					(Smalltalk classNamed: aSymbol)
						ifNotNil: [ :class |

							"Only add test when searching for WebComponents"
							class isWebComponent
								ifTrue: [

									"Test for reference to the WebComponent's tag name"
									(method isHtmlWebResourceMethod and: [ method webResourceRefersTo: class tagName ])
										ifTrue: [ ^ true ] ] ]
						ifNil: [
							"Test for reference to the non-class literal in web resource method"
							(method isWebResourceMethod and: [ method webResourceRefersTo: aSymbol ])
								ifTrue: [ ^ true ] ] ] ].

	^ super refersToLiteral: aSymbol
]
