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

{ #category : #'as yet unclassified' }
CpViewInspectorSaveRequest >> performIn: anEnvironment [

	<serverEnvironment>

	self viewClass ifNotNil: [ :viewClass |
		| originalSourceCode escapedSourceCode newSourceCode |
		originalSourceCode := (viewClass class includesSelector: self sourceCodeSelector)
			ifTrue: [
				(viewClass class >> self sourceCodeSelector) sourceCode
					ifNil: [ ^ self showErrorAlert: 'Unknown source code' in: anEnvironment ] ]
			ifFalse: [ '' ].

		originalSourceCode := originalSourceCode trim.
		originalSourceCode ifNotEmpty: [
			(originalSourceCode beginsWith: self sourceCodePrefix)
				ifFalse: [ ^ self showErrorAlert: 'Unexpected source code format' in: anEnvironment ].
			(originalSourceCode endsWith: self sourceCodeSuffix)
				ifFalse: [ ^ self showErrorAlert: 'Unexpected source code format' in: anEnvironment ] ].

		"Escape single quote in template (remove leading and trailing quote)"
		escapedSourceCode := sourceCode printString.
		escapedSourceCode := escapedSourceCode copyFrom: 2 to: escapedSourceCode size - 1.
		escapedSourceCode replaceAll: Character lf with: Character cr.

		newSourceCode := self sourceCodePrefix, escapedSourceCode, self sourceCodeSuffix.
		originalSourceCode = newSourceCode
			ifTrue: [ self showAlert: 'Source already up-to-date' in: anEnvironment ] 
			ifFalse: [
				[
					viewClass class compile: newSourceCode classified: 'web resources'.
					self showAlert: 'Source code updated' in: anEnvironment
				] on: Error do: [ :err | self halt ] ] ]
]

{ #category : #rendering }
CpViewInspectorSaveRequest >> showAlert: aString in: anEnvironment [

	<serverEnvironment>

	anEnvironment sendMessage: (MessageSend
		receiver: CpViewInspectorView name
		selector: #showAlert:
		arguments: { aString })
]

{ #category : #rendering }
CpViewInspectorSaveRequest >> showErrorAlert: aString in: anEnvironment [

	<serverEnvironment>

	anEnvironment sendMessage: (MessageSend
		receiver: CpViewInspectorView name
		selector: #showErrorAlert:
		arguments: { aString })
]

{ #category : #accessing }
CpViewInspectorSaveRequest >> sourceCodePrefix [

	"Answer the source code prefix, to check if format is correct and create new method.
	Currently very strict check."

	<serverEnvironment>

	self subclassResponsibility
]

{ #category : #accessing }
CpViewInspectorSaveRequest >> sourceCodeSelector [

	"Answer the selector to retrieve the source code"

	<serverEnvironment>

	self subclassResponsibility
]

{ #category : #accessing }
CpViewInspectorSaveRequest >> sourceCodeSuffix [

	"Answer the source code suffix, to check if format is correct and create new method.
	Currently very strict check."

	<serverEnvironment>

	self subclassResponsibility
]
