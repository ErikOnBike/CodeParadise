Class {
	#name : #CpViewInspectorSyncStyleRequest,
	#superclass : #CpViewInspectorRequest,
	#instVars : [
		'style'
	],
	#category : #'CodeParadise-WebApplication-Development-Announcements'
}

{ #category : #'instance creation' }
CpViewInspectorSyncStyleRequest class >> viewTagName: tagNameString [

	self error: 'Incorrect use. Please use ', #viewTagName:style:
]

{ #category : #'instance creation' }
CpViewInspectorSyncStyleRequest class >> viewTagName: tagNameString style: styleString [

	^ self basicNew
		initializeWithViewTagName: tagNameString style: styleString ;
		yourself
]

{ #category : #initialization }
CpViewInspectorSyncStyleRequest >> initializeWithViewTagName: tagNameString style: styleString [

	self initializeWithViewTagName: tagNameString.

	style := styleString
]

{ #category : #actions }
CpViewInspectorSyncStyleRequest >> perform [

	<serverEnvironment>

	self error: 'Please use ', #performIn:
]

{ #category : #actions }
CpViewInspectorSyncStyleRequest >> performIn: anEnvironment [

	<serverEnvironment>

	self viewClass ifNotNil: [ :viewClass |
		| styleSource escapedStyle newStyleSourceCode |
		styleSource := (viewClass class includesSelector: #style)
			ifTrue: [
				(viewClass class >> #style) sourceCode
					ifNil: [ ^ self showErrorAlert: 'Unknown source code' in: anEnvironment ] ]
			ifFalse: [ '' ].

		styleSource := styleSource trim.
		styleSource ifNotEmpty: [
			(styleSource beginsWith: self sourceCodePrefix)
				ifFalse: [ ^ self showErrorAlert: 'Unexpected source code format' in: anEnvironment ].
			(styleSource endsWith: self sourceCodeSuffix)
				ifFalse: [ ^ self showErrorAlert: 'Unexpected source code format' in: anEnvironment ] ].

		"Escape single quote in style (remove leading and trailing quote)"
		escapedStyle := style printString.
		escapedStyle := escapedStyle copyFrom: 2 to: escapedStyle size - 1.
		escapedStyle replaceAll: Character lf with: Character cr.

		newStyleSourceCode := self sourceCodePrefix, escapedStyle, self sourceCodeSuffix.
		styleSource = newStyleSourceCode
			ifTrue: [ self showAlert: 'Source already up-to-date' in: anEnvironment ] 
			ifFalse: [
				[
					viewClass class compile: newStyleSourceCode classified: 'web resources'.
					self showAlert: 'Source code updated' in: anEnvironment
				] on: Error do: [ :err | self halt ] ] ]
]

{ #category : #rendering }
CpViewInspectorSyncStyleRequest >> showAlert: aString in: anEnvironment [

	anEnvironment sendMessage: (MessageSend
		receiver: CpViewInspectorView name
		selector: #showAlert:
		arguments: { aString })
]

{ #category : #rendering }
CpViewInspectorSyncStyleRequest >> showErrorAlert: aString in: anEnvironment [

	anEnvironment sendMessage: (MessageSend
		receiver: CpViewInspectorView name
		selector: #showErrorAlert:
		arguments: { aString })
]

{ #category : #accessing }
CpViewInspectorSyncStyleRequest >> sourceCodePrefix [

	"Answer the source code prefix, to check if format is correct and create new method.
	Currently very strict check."

	<serverEnvironment>

	^ 'style

	<webResource: #css>

	^ '''
]

{ #category : #accessing }
CpViewInspectorSyncStyleRequest >> sourceCodeSuffix [

	"Answer the source code suffix, to check if format is correct and create new method.
	Currently very strict check."

	<serverEnvironment>

	^ ''''
]
