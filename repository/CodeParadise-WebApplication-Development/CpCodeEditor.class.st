Class {
	#name : #CpCodeEditor,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'editor'
	],
	#category : #'CodeParadise-WebApplication-Development-View'
}

{ #category : #private }
CpCodeEditor class >> in: anElement on: aString language: aSymbol [

	"Answer a new instance in the specified element on the specified content using the specified (code) language"

	^ self basicNew
		initializeWithEditor: (CpBrowserWindow current apply: #cpOpenEditorIn:on:language: withArguments: { anElement . aString . aSymbol } resultAs: CpCodeMirrorEditorView) ;
		yourself
]

{ #category : #'instance creation' }
CpCodeEditor class >> in: anElement onCss: aString [

	"Answer a new instance in the specified element on the specified content"

	^ self in: anElement on: aString language: #css
]

{ #category : #'instance creation' }
CpCodeEditor class >> in: anElement onHtml: aString [

	"Answer a new instance in the specified element on the specified content"

	^ self in: anElement on: aString language: #html
]

{ #category : #'instance creation' }
CpCodeEditor class >> new [

	self error: 'Instances should be created in an existing HTML element. Please use ', #in:onCss:, ' or ', #in:onHtml:
]

{ #category : #accessing }
CpCodeEditor class >> updateHtmlTags: aCollection [

	CpBrowserWindow current
		apply: #cpSetWellKnownHtmlTags: withArguments: { aCollection }
]

{ #category : #accessing }
CpCodeEditor >> content [

	"Answer the content of the editor as String"

	^ editor content
]

{ #category : #initialization }
CpCodeEditor >> initializeWithEditor: anEditor [

	self initialize.

	editor := anEditor
]

{ #category : #accessing }
CpCodeEditor >> isDirty [

	^ editor isDirty
]

{ #category : #accessing }
CpCodeEditor >> markClean [

	editor markClean
]

{ #category : #accessing }
CpCodeEditor >> revert [

	"Revert all the changes in the editor"

	^ editor revert
]
