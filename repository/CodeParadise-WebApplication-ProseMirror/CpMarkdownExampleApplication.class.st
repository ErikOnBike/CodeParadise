Class {
	#name : #CpMarkdownExampleApplication,
	#superclass : #CpMvpWebApplication,
	#instVars : [
		'documents'
	],
	#category : #'CodeParadise-WebApplication-ProseMirror-Examples'
}

{ #category : #accessing }
CpMarkdownExampleApplication >> applicationModel [

	"Answer the Model for the receiver, which is the receiver itself"

	^ self
]
