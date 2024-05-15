Class {
	#name : 'CpEditorTokenizer',
	#superclass : 'CpTokenizer',
	#category : 'CodeParadise-Beach-Editor',
	#package : 'CodeParadise-Beach',
	#tag : 'Editor'
}

{ #category : 'api' }
CpEditorTokenizer class >> getTokenFromNode: aNode [

	"Answer the token represented by the specified node (no specific class required, node should be created
	through #createTokenNodeFor: or #createTokenNodeFor:with:)"

	^ aNode key
]

{ #category : 'api' }
CpEditorTokenizer class >> getValueFromNode: aNode [

	"Answer the value of the token represented by the specified node (no specific class required, node should be
	created through #createTokenNodeFor: or #createTokenNodeFor:with:)"

	^ aNode value
]

{ #category : 'api' }
CpEditorTokenizer >> createTokenNodeFor: aSymbol [

	"Create and answer a node (no specific class required) representing the specified token (a Symbol)"

	^ self createTokenNodeFor: aSymbol with: nil
]

{ #category : 'api' }
CpEditorTokenizer >> createTokenNodeFor: aSymbol with: aString [

	"Create and answer a node (no specific class required) representing the specified token (a Symbol)
	and having the specified value (a String)"

	^ aSymbol -> aString
]
