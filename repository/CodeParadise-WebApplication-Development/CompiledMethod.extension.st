Extension { #name : #CompiledMethod }

{ #category : #'*CodeParadise-WebApplication-Development' }
CompiledMethod >> firstLocationOfWebResourceReference: aSymbol [

	"Answer an Interval specifying the first location within the receiver's
	source code where the specified Symbol is referenced.
	This method assumes the receiver is a CodeParadise web resource method.
	Answer an empty Interval if the reference is not found.

	Implementation:
	Search all literal Strings and find occurrence of the specified Symbol.
	Validate the occurrence is not a partial match (i.e. the Symbol should be
	surrounded by non valid identifier Characters or is at end/start)."

	<serverEnvironment>

	| string index |

	self ast allChildren do: [ :each |
		(each class == RBLiteralValueNode and: [ each isString ])
			ifTrue: [

				"Find first occurrence"
				string := each value.
				index := string findString: aSymbol.

				"Test for presence of the specified Symbol"
				[ index >= 1 ] whileTrue: [

					"Make sure the reference is not a sub or partial reference"
					((index = 1 or: [ (string at: index - 1) isAllowedInWebResourceId not ]) and: [ (index + aSymbol size - 1) = string size or: [ (string at: index + aSymbol size) isAllowedInWebResourceId not ] ])
						ifTrue: [ ^ Interval from: each start + index to: each start + index + aSymbol size - 1 ].

					"Find next occcurrence"				
					index := string findString: aSymbol startingAt: index + 1 ] ] ].

	"Not found, answer empty Interval"
	^ Interval from: 0 to: -1
]

{ #category : #'*CodeParadise-WebApplication-Development' }
CompiledMethod >> hasSelector: aSymbol [

	"Answer a Boolean stating whether the receiver contains a reference to the specified Symbol.

	Implementation:
	This method adds behavior specific for CodeParadise to search for Class references in html
	web resources (like the #template method of CpTemplateComponent)."

	<serverEnvironment>

	"Only search in html web resources"
	self isHtmlWebResourceMethod
		ifTrue: [
			"Only search for classes"
			(Smalltalk classNamed: aSymbol) ifNotNil: [ :class |
				"Check if the receiver refers to the class' tag name"
				(class isWebComponent and: [ self webResourceRefersTo: class tagName ])
					ifTrue: [ ^ true ] ] ].

	"Fall back to default behavior"
	^ super hasSelector: aSymbol
]

{ #category : #'*CodeParadise-WebApplication-Development' }
CompiledMethod >> isHtmlWebResourceMethod [

	"Answer a Boolean stating whether the receiver is a CodeParadise html web resource method"

	<serverEnvironment>

	^ (self pragmaAt: CpWebApplication webResourcePragmaName)
		ifNotNil: [ :pragma | (pragma argumentAt: 1) = CpWebApplication webResourceHTML ]
		ifNil: [ false ]
]

{ #category : #'*CodeParadise-WebApplication-Development' }
CompiledMethod >> isWebResourceMethod [

	"Answer a Boolean stating whether the receiver is a CodeParadise web resource method"

	<serverEnvironment>

	^ self hasPragmaNamed: CpWebApplication webResourcePragmaName
]

{ #category : #'*CodeParadise-WebApplication-Development' }
CompiledMethod >> webResourceRefersTo: aSymbol [

	"Answer a Boolean stating whether the receiver contains a reference to
	the specified Symbol.
	This method assumes the receiver is a CodeParadise web resource method.

	Implementation:
	Search all literal Strings and find occurrence of the specified Symbol.
	Validate the occurrence is not a partial match (i.e. the Symbol should be
	surrounded by non valid identifier Characters or is at end/start)."

	<serverEnvironment>

	^ (self firstLocationOfWebResourceReference: aSymbol) isNotEmpty
]
