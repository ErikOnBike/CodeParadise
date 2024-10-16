Class {
	#name : #CpViewInspectorSaveRequest,
	#superclass : #CpViewInspectorRequest,
	#instVars : [
		'sourceCode'
	],
	#category : #'CodeParadise-WebApplication-Development-Announcements'
}

{ #category : #'as yet unclassified' }
CpViewInspectorSaveRequest >> initializeWithViewTagName: tagNameString sourceCode: sourceCodeString [

	self initializeWithViewTagName: tagNameString.

	sourceCode := sourceCodeString
]

{ #category : #actions }
CpViewInspectorSaveRequest >> performIn: anEnvironment [

	<serverEnvironment>

	self viewClass ifNotNil: [ :viewClass |
		| sourceCodeInfo escapedSourceCode |

		"Extract source code from method"
		[
			sourceCodeInfo := self extractSourceCode: ((viewClass class includesSelector: self sourceCodeSelector)
				ifTrue: [ viewClass class >> self sourceCodeSelector ]
				ifFalse: [ CpTemplateComponent class >> self sourceCodeSelector ])
		] on: Error do: [ :err |
			self showErrorAlert: err messageText in: anEnvironment.
			self halt ].

		"If nothing changed, we're done"
		(sourceCodeInfo at: #sourceCode) = sourceCode
			ifTrue: [ ^ self showAlert: 'Source already up-to-date' in: anEnvironment ].

		"Escape single quote in template (remove leading and trailing quote)"
		escapedSourceCode := sourceCode printString.
		escapedSourceCode := escapedSourceCode copyFrom: 2 to: escapedSourceCode size - 1.
		escapedSourceCode replaceAll: Character lf with: Character cr.

		"Install the new method"
		[
			viewClass class
				compile: (sourceCodeInfo at: #prefix), escapedSourceCode, (sourceCodeInfo at: #suffix)
				classified: 'web resources'.
			self showAlert: 'Source code updated' in: anEnvironment
		] on: Error do: [ :err |
			self showErrorAlert: err messageText in: anEnvironment.
			self halt ] ]
]

{ #category : #accessing }
CpViewInspectorSaveRequest >> sourceCodeSelector [

	"Answer the selector to retrieve the source code"

	<serverEnvironment>

	self subclassResponsibility
]
