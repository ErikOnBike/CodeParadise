Class {
	#name : #CpViewInspectorRequest,
	#superclass : #Announcement,
	#instVars : [
		'viewTagName'
	],
	#category : #'CodeParadise-WebApplication-Development-Announcements'
}

{ #category : #accessing }
CpViewInspectorRequest class >> viewTagName: aString [

	^ self basicNew
		initializeWithViewTagName: aString ;
		yourself
]

{ #category : #accessing }
CpViewInspectorRequest >> extractSourceCode: aCompiledMethod [

	"Answer a Dictionary containing the prefix, sourceCode, suffix of the specified Method.
	The prefix includes everything up to and including the single quote (marking the start
	of the source code). The suffix includes the single quote (marking the end of the
	source code) up to the last character."

	<serverEnvironment>

	| stringNodes sourceCodeNode methodSourceCode prefix sourceCode suffix |

	stringNodes := aCompiledMethod ast allChildren select: [ :each | each class = RBLiteralValueNode and: [ each isString ] ].
	stringNodes size = 1
		ifFalse: [ self error: 'Source code incorrect format: does not have a single String value' ].
	sourceCodeNode := stringNodes first.

	methodSourceCode := aCompiledMethod sourceCode
		ifNil: [ self error: 'No source code available' ].

	prefix := methodSourceCode copyFrom: 1 to: sourceCodeNode start.
	sourceCode := methodSourceCode copyFrom: sourceCodeNode start + 1 to: sourceCodeNode stop - 1.
	suffix := methodSourceCode copyFrom: sourceCodeNode stop to: methodSourceCode size.

	"Remove escaped quotes"
	sourceCode := sourceCode unescapeCharacter: $'.

	^ Dictionary new
		at: #prefix put: prefix ;
		at: #sourceCode put: sourceCode ;
		at: #suffix put: suffix ;
		yourself
]

{ #category : #initialization }
CpViewInspectorRequest >> initializeWithViewTagName: aString [

	self initialize.

	viewTagName := aString
]

{ #category : #actions }
CpViewInspectorRequest >> performIn: anEnvironment [

	<serverEnvironment>

	self subclassResponsibility
]

{ #category : #rendering }
CpViewInspectorRequest >> showAlert: aString in: anEnvironment [

	<serverEnvironment>

	anEnvironment sendMessage: (MessageSend
		receiver: CpViewInspectorView name
		selector: #showAlert:
		arguments: { aString })
]

{ #category : #rendering }
CpViewInspectorRequest >> showErrorAlert: aString in: anEnvironment [

	<serverEnvironment>

	anEnvironment sendMessage: (MessageSend
		receiver: CpViewInspectorView name
		selector: #showErrorAlert:
		arguments: { aString })
]

{ #category : #view }
CpViewInspectorRequest >> viewClass [

	"Answer the View class of the receiver"

	<serverEnvironment>

	viewTagName ifNil: [ ^ nil ].

	"Find by iterating over all class to match on tag name"
	CpTemplateComponent allSubclassesDo: [ :each |
		each tagName = viewTagName
			ifTrue: [ ^ each ] ].

	^ nil
]
