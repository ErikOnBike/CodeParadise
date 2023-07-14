Class {
	#name : #CpPMMarkdownEditorPresenter,
	#superclass : #CpPresenter,
	#instVars : [
		'clientID'
	],
	#classVars : [
		'ClientIDs',
		'IdentifierGenerator',
		'PresentersByDocument',
		'SharedMutex'
	],
	#category : #'CodeParadise-WebApplication-ProseMirror-Presenter'
}

{ #category : #collaboration }
CpPMMarkdownEditorPresenter class >> addSelection: aDictionary for: aString toCollaborativeDocument: aMarkdownDocument [

	"Add the specified selection for the specified client ID (for all running instances)"

	self allInstancesFor: aMarkdownDocument do: [ :each |
		each addSelection: aDictionary for: aString ]
]

{ #category : #collaboration }
CpPMMarkdownEditorPresenter class >> allInstancesFor: aMarkdownDocument do: aBlock [

	"Evaluate the specified block for all presenters on the specified Markdown document"

	SharedMutex critical: [
		(PresentersByDocument at: aMarkdownDocument ifAbsent: [ ^ self ])
			do: [ :each | aBlock value: each ] ]
]

{ #category : #accessing }
CpPMMarkdownEditorPresenter class >> defaultViewClass [

	^ CpPMMarkdownEditor
]

{ #category : #presenter }
CpPMMarkdownEditorPresenter class >> generateClientIdentifier [

	"Generate an unique identifier for the receiver's instances used as a client identifier
	within collaborative editing (should be meaningless value which cannot be used to change state,
	since it is shared with multiple instances when showing the collaborative changes).
	The generated identifier is stored here to keep track of uniqueness."

	SharedMutex critical: [
		^ ClientIDs add: (IdentifierGenerator generateSatisfying: [ :id | (ClientIDs includes: id) not ]) asSymbol ]
]

{ #category : #initialization }
CpPMMarkdownEditorPresenter class >> initialize [

	<script>

	ClientIDs := OrderedCollection new.
	IdentifierGenerator := CpWebIdentifierGenerator new.
	PresentersByDocument := IdentityDictionary new.
	SharedMutex := Mutex new
]

{ #category : #collaboration }
CpPMMarkdownEditorPresenter class >> registerCollaborativeDocumentFor: aDocument in: aPresenter [

	"Answer the unique CpPMMarkdownDocument instance for the specified document (or create a new one)
	and register the specified Presenter with it"

	| markdownDocument |

	SharedMutex critical: [

		"Find and answer existing instance"
		PresentersByDocument keysAndValuesDo: [ :eachMarkdownDocument :presenters |
			(eachMarkdownDocument isForDocument: aDocument)
				ifTrue: [
					presenters add: aPresenter.
					^ eachMarkdownDocument ] ].

		"Create new collaborative document instance and store presenter"
		markdownDocument := CpPMMarkdownDocument document: aDocument.
		PresentersByDocument at: markdownDocument put: (OrderedCollection with: aPresenter).

		^ markdownDocument ]
]

{ #category : #collaboration }
CpPMMarkdownEditorPresenter class >> removeSelection: aString fromCollaborativeDocument: aMarkdownDocument [

	"Remove the selection for the specified client ID (for all running instances)"

	self allInstancesFor: aMarkdownDocument do: [ :each |
		each removeSelection: aString ]
]

{ #category : #collaboration }
CpPMMarkdownEditorPresenter class >> unregisterCollaborativeDocument: aMarkdownDocument in: aPresenter [

	SharedMutex critical: [

		"Find and remove identifier"
		ClientIDs remove: aPresenter clientID ifAbsent: [ "Ignore" ].

		"Find and unregister existing instance"
		PresentersByDocument keysAndValuesDo: [ :markdownDocument :presenters |
			markdownDocument == aMarkdownDocument
				ifTrue: [
					"Remove Presenter"
					presenters remove: aPresenter ifAbsent: [ "Ignore" ].

					"If no Presenters left, remove MarkdownDocument"
					presenters
						ifNotEmpty: [ presenters do: [ :each | each removeSelection: aPresenter clientID ] ]
						ifEmpty: [ PresentersByDocument removeKey: aMarkdownDocument ].
					^ self ] ] ]
]

{ #category : #selections }
CpPMMarkdownEditorPresenter >> addSelection: aDictionary for: aString [

	self view
		setSelection: aDictionary clientID: aString
]

{ #category : #accessing }
CpPMMarkdownEditorPresenter >> clientID [

	^ clientID
]

{ #category : #'event handling' }
CpPMMarkdownEditorPresenter >> handleDocumentChange: aDocumentChange [

	"Handle the (collaborative) document change by sending all instances a change event"

	| markdownDocument |

	(markdownDocument := self markdownDocument)
		applyChange: aDocumentChange
		forClientID: clientID
		onSuccess: [ :steps :version :selection |
			self class allInstancesFor: markdownDocument do: [ :each |
				each renderSteps: steps version: version selection: selection clientID: clientID ] ]
		onFailure: [ :version |
			self view
				crTrace: 'Failed to handle changes, server is at version ', version printString ]
]

{ #category : #'event handling' }
CpPMMarkdownEditorPresenter >> handleFocusIn: aFocusInAnnouncement [

	"The receiver has gained focus, add selection in other collaborater views.

	Implementation:
	Do NOT call the instance method #addSelection: here, since it will only
	update the receiver's view and not the collaborators views."

	self class
		addSelection: aFocusInAnnouncement selection
		for: clientID
		toCollaborativeDocument: self markdownDocument
]

{ #category : #'event handling' }
CpPMMarkdownEditorPresenter >> handleFocusOut [

	"The receiver has lost focus, remove selection in other collaborater views.

	Implementation:
	Do NOT call the instance method #removeSelection: here, since it will only
	update the receiver's view and not the collaborators views."

	self class
		removeSelection: clientID
		fromCollaborativeDocument: self markdownDocument
]

{ #category : #initialization }
CpPMMarkdownEditorPresenter >> initialize [

	super initialize.

	clientID := self class generateClientIdentifier
]

{ #category : #accessing }
CpPMMarkdownEditorPresenter >> markdownDocument [

	^ self model
]

{ #category : #accessing }
CpPMMarkdownEditorPresenter >> model: aDocument [

	"Assume the model is a regular Document and wrap it in a collaborative ProseMirror
	document (i.e. CpPMMarkdownDocument) which is a unique instance for the document.
	This document becomes the authorative model allowing collaborative editing."

	"Unregister any previously registered instance"
	model ifNotNil: [ self class unregisterCollaborativeDocument: model in: self ].

	"Register new instance"
	super model: (self class registerCollaborativeDocumentFor: aDocument in: self)
]

{ #category : #accessing }
CpPMMarkdownEditorPresenter >> release [

	"Unregister any previously registered instance"
	model ifNotNil: [ self class unregisterCollaborativeDocument: model in: self ].

	super release
]

{ #category : #selections }
CpPMMarkdownEditorPresenter >> removeSelection: aString [

	self view
		removeSelectionClientID: aString
]

{ #category : #rendering }
CpPMMarkdownEditorPresenter >> renderSteps: aCollection version: anInteger selection: aDictionary clientID: aString [

	self view
		renderSteps: aCollection asArray version: anInteger selection: aDictionary clientID: aString
]

{ #category : #rendering }
CpPMMarkdownEditorPresenter >> renderView [

	"Whenever the receiver's model changes, update the view's content.
	This will reset the editor with respect to history/undo features.
	The smaller changes to the model (as part of the collaborative
	editing will not issue a #renderView but update through #renderChanges:)"

	self markdownDocument withSnapshotStepsAndVersionDo: [ :content :steps :version |
		
		"Render (snapshot) content and steps (to sync the document to final state).
		Use an empty clientID to 'force' the ProseMirror editor to show it."
		self view
			updateContent: content version: version - steps size clientID: clientID ;
			renderSteps: steps asArray version: version selection: nil clientID: ''.

		"Add all selections"
		self markdownDocument withSelectionsDo: [ :selectionClientID :selection |
			self view
				setSelection: selection clientID: selectionClientID ] ]
]

{ #category : #view }
CpPMMarkdownEditorPresenter >> viewCreated [

	super viewCreated.

	self view
		when: CpPMCollaborativeDocumentChange send: #handleDocumentChange: to: self ;
		when: CpPMCollaborativeDocumentFocusIn send: #handleFocusIn: to: self ;
		when: CpPMCollaborativeDocumentFocusOut send: #handleFocusOut to: self
]
