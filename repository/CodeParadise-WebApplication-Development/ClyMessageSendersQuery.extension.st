Extension { #name : #ClyMessageSendersQuery }

{ #category : #'*CodeParadise-WebApplication-Development' }
ClyMessageSendersQuery >> decorateResultMethodEditor: aMethodEditor [

	"Decorate the specified method editor using the receiver's query result.
	When searching for selectors they can be found in web resource methods
	(of TemplateComponents) like CSS or HTML. If found, highlight the first
	occurrence.
	Otherwise use default decoration behavior."

	<serverEnvironment>

	"Check if a web resource method is being decorated"
	aMethodEditor editingMethod isWebResourceMethod
		ifFalse: [ ^ super decorateResultMethodEditor: aMethodEditor ].

	selectors do: [ :selector |
		(aMethodEditor editingMethod firstLocationOfWebResourceReference: selector) ifNotEmpty: [ :selection |
			aMethodEditor textMorph setSelection: selection.
			^ self ] ].

	"Fall back to default behavior"
	super decorateResultMethodEditor: aMethodEditor
]
