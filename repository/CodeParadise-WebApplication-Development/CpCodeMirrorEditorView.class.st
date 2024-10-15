Class {
	#name : #CpCodeMirrorEditorView,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-WebApplication-Development-View'
}

{ #category : #'instance creation' }
CpCodeMirrorEditorView class >> newInstanceWithArguments: anArray resultAs: aProxyClass [

	self error: 'An instance should be retrieved using class ', #CpCssEditor
]

{ #category : #'class initialization' }
CpCodeMirrorEditorView class >> postInstallOnce [

	CpHtmlElement documentAddExternalScript: '/dev/cp-codemirror-editor.js'
]

{ #category : #'accessing - convenience' }
CpCodeMirrorEditorView >> content [

	"Convenience method to retrieve the editor content"

	^ self state content
]

{ #category : #testing }
CpCodeMirrorEditorView >> isDirty [

	"Answer whether the editor has changes"

	^ self apply: #isDirty
]

{ #category : #'accessing - convenience' }
CpCodeMirrorEditorView >> revert [

	"Convenience method to revert the editor content to initial value"

	self apply: #revert
]

{ #category : #accessing }
CpCodeMirrorEditorView >> state [

	"The current editor state."

	^ self apply: #state resultAs: CpCodeMirrorEditorState
]
