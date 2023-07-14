"
I am a ProseMirror Markdown Document. I can be edited collaboratively (i.e. by multiple concurrent users).
Therefore I keep track of changes made to the document in the form of ProseMirror Steps (see
https://github.com/ProseMirror/prosemirror-transform/blob/master/src/step.ts).
By allowing only updates to the document based on a given version, multiple simultaneous updates will be
(re)ordered to reflect a single view of the document state. (see https://prosemirror.net/docs/guide/#collab).
To allow views to reset themselves in case a failure occurs, a snapshot is kept to come back to a well known
state. If such recovery is not possible, the full document has to be recreated for the view (which might
mean any history/undo information is lost for that particular view).

"
Class {
	#name : #CpPMMarkdownDocument,
	#superclass : #CpModel,
	#instVars : [
		'document',
		'snapshot',
		'version',
		'steps',
		'selections',
		'mutex',
		'updating'
	],
	#category : #'CodeParadise-WebApplication-ProseMirror-Model'
}

{ #category : #'instance creation' }
CpPMMarkdownDocument class >> document: aDocument [

	^ self basicNew
		initializeWithDocument: aDocument ;
		yourself
]

{ #category : #accessing }
CpPMMarkdownDocument >> applyChange: aDocumentChange forClientID: aString onSuccess: successBlock onFailure: failureBlock [

	mutex critical: [

		| content  newSteps selection |

		"Validate this is a correct version"
		version = aDocumentChange version
			ifFalse: [ ^ failureBlock value: version ].

		"Update document and/or steps based on whether new content is provided"
		newSteps := aDocumentChange steps.
		(content := aDocumentChange content)
			ifNotNil: [
				"Update document and reset steps (prevent recursion in update)"
				updating := true.
				[ document content: content ] ensure: [ updating := false ].
				snapshot := content.
				steps
					removeAll ;
					addAll: newSteps ]
			ifNil: [ steps addAll: newSteps ].

		"Always update the version info to reflect the receiver's state"
		version := version + newSteps size.

		"Keep the selection (if present)"
		(selection := aDocumentChange selection) ifNotNil: [
			selections at: aString put: selection ].

		"Let the caller handle the successful update"
		successBlock value: newSteps value: version value: selection ]
]

{ #category : #'event handling' }
CpPMMarkdownDocument >> documentChanged [

	mutex critical: [

		"If in updating process, ignore this change"
		updating ifTrue: [ ^ self ].

		"Reset steps, start with new version number"
		steps removeAll.
		version := version + 1.

		"Allow dependents to update"
		self valueChanged ]
]

{ #category : #initialization }
CpPMMarkdownDocument >> initialize [

	super initialize.

	steps := OrderedCollection new.
	version := 0.
	selections := Dictionary new.

	mutex := Mutex new.
	updating := false
]

{ #category : #initialization }
CpPMMarkdownDocument >> initializeWithDocument: aDocument [

	self initialize.

	document := aDocument.
	snapshot := aDocument content.

	document whenChangedSend: #documentChanged to: self
]

{ #category : #testing }
CpPMMarkdownDocument >> isForDocument: aDocument [

	"Answer whether the specified document is the basis for the receiver"

	^ document == aDocument
]

{ #category : #presenter }
CpPMMarkdownDocument >> preferredPresenterClass [

	^ CpPMMarkdownEditorPresenter
]

{ #category : #accessing }
CpPMMarkdownDocument >> withSelectionsDo: aBlock [

	mutex critical: [
		selections keysAndValuesDo: [ :clientID :selection |
			aBlock value: clientID value: selection ] ]
]

{ #category : #accessing }
CpPMMarkdownDocument >> withSnapshotStepsAndVersionDo: aBlock [

	"Since snapshot, steps and version can change because of updates,
	allow an interested party to receive all 3 values consistently"

	mutex critical: [ aBlock value: snapshot value: steps value: version ]
]
