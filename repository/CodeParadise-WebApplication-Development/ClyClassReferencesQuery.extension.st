Extension { #name : #ClyClassReferencesQuery }

{ #category : #'*CodeParadise-WebApplication-Development' }
ClyClassReferencesQuery >> decorateResultMethodEditor: aMethodEditor [

	"Decorate the specified method editor using the receiver's query result.
	When searching for WebComponents it can be found as tag name in HTML web resource
	methods (of TemplateComponents). If found, highlight the first occurrence.
	Otherwise use default decoration behavior."

	<serverEnvironment>

	"Check if a html web resource method is being decorated"
	aMethodEditor editingMethod isHtmlWebResourceMethod
		ifFalse: [ ^ super decorateResultMethodEditor: aMethodEditor ].

	"Iterate all vars"
	(variableQuery execute items) do: [ :var |

		"Some sanity checks on Class in var"
		var value ifNotNil: [ :class |

			"Check if a WebComponent is found"
			(class isClass and: [ class isWebComponent ])
				ifTrue: [
					"Find the tag of the WebComponent inside the method and highlight if found (and stop there)"
					(aMethodEditor editingMethod firstLocationOfWebResourceReference: class tagName) ifNotEmpty: [ :selection |
						aMethodEditor textMorph setSelection: selection.
						^ self ] ] ] ].

	"Fall back to default behavior"
	super decorateResultMethodEditor: aMethodEditor
]
