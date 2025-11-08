Class {
	#name : #CpBrowserDocumentSnapshot,
	#superclass : #CpBrowserSnapshot,
	#category : #'CodeParadise-WebApplication-Snapshot-Core'
}

{ #category : #accessing }
CpBrowserDocumentSnapshot class >> collectWebComponentsFrom: anElement into: aDictionary [

	"Collect the receiver and all children which are WebComponents into the specified Dictionary.
	Use the component's ID as key and the component itself as value."

	anElement isWebComponent
		ifTrue: [
			anElement id
				ifNotNil: [ :id | aDictionary at: id put: anElement ] ].

	anElement children do: [ :each | self collectWebComponentsFrom: each into: aDictionary ]
]

{ #category : #snapshot }
CpBrowserDocumentSnapshot class >> customPostSnapshotWith: aDictionary [

	"Perform custom post snapshot behavior"

	| content components |

	content := aDictionary at: #content.
	components := aDictionary at: #components.

	"Restore the application content"
	CpHtmlElement documentBody markupContent: content.

	components keysAndValuesDo: [ :id :element |
		element
			privateAttachToId: id ;
			initialize ]
]

{ #category : #snapshot }
CpBrowserDocumentSnapshot class >> customPreSnapshot [

	"Perform custom pre snapshot behavior.

	Implementation:
	Currently it is assumed the receiver is running inside an MVP-based
	webapplication and no 'manual' DOM manipulation has been performed.
	In the future support might be added for other environments as well
	(like Node.js based environments or WebWorker threads which don't have
	access to the DOM). Also non MVP webapplications might be supported.

	Only the HTML body is preserved during the snapshot process. The
	head content is assumed to be created by the different classes and/or
	components and will be recreated during the restart.
	Since WebComponents do not know their content nor where they are
	placed inside the DOM, a dictionary is kept with their id, so they
	can be restored in the proper location.

	See also https://github.com/ErikOnBike/TinyBootstrap for an
	alternative to create custom images."

	| content components |

	"Save application content"
	content := CpHtmlElement documentBody markupContent.
	self traceCr: 'Saving markup: ', content.

	"Save components"
	components := Dictionary new.
	self collectWebComponentsFrom: CpHtmlElement documentBody into: components.

	^ {
		#content -> content.
		#components -> components } asDictionary
]
