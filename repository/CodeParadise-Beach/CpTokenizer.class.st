Class {
	#name : #CpTokenizer,
	#superclass : #Object,
	#category : #'CodeParadise-Beach-Editor'
}

{ #category : #api }
CpTokenizer class >> getTokenFromNode: aNode [

	"Answer the token represented by the specified node (no specific class required, node should be created through #createTokenNodeFor:)"

	self subclassResponsibility
]

{ #category : #api }
CpTokenizer class >> getValueFromNode: aNode [

	"Answer the value of the token represented by the specified node (no specific class required, node should be
	created through #createTokenNodeFor: or #createTokenNodeFor:with:)"

	self subclassResponsibility
]

{ #category : #api }
CpTokenizer >> createTokenNodeFor: aSymbol [

	"Create and answer a node (no specific class required) representing the specified token (a Symbol)"

	self subclassResponsibility
]

{ #category : #api }
CpTokenizer >> createTokenNodeFor: aSymbol with: aString [

	"Create and answer a node (no specific class required) representing the specified token (a Symbol)
	and having the specified value"

	self subclassResponsibility
]
