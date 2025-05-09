Extension { #name : #ClyClassReferencesQuery }

{ #category : #'*CodeParadise-WebApplication-Development' }
ClyClassReferencesQuery >> decorateResultMethodEditor: aMethodEditor [

	"When searching for WebComponents search for the tag name in html web resource
	methods and highlight the first occurrence. Otherwise use default behavior.

	Implementation:
	This method replaces the superclass' implementation with a check for tag names
	on WebComponent if (and only if) a html web resource method is decorated and a
	WebComponent is searched for."

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

	"Fall back to regular implementation"
	super decorateResultMethodEditor: aMethodEditor
]
