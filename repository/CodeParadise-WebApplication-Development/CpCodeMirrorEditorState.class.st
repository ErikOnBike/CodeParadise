Class {
	#name : #CpCodeMirrorEditorState,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-WebApplication-Development-View'
}

{ #category : #'accessing - convenience' }
CpCodeMirrorEditorState >> content [

	"Convenience method to retrieve the editor content"

	^ self doc toString
]

{ #category : #accessing }
CpCodeMirrorEditorState >> doc [

	"The current document."

	^ self apply: #doc resultAs: CpCodeMirrorText
]
